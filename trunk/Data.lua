local function DeathIterator(state)
	repeat
		local l = DeathNoteData.log[state.t]
		if l then
			if state.i == nil then
				state.i = #l
			end
			for i = state.i, 1, -1 do
				local entry = l[i]
				if entry[8] == state.guid and entry[3] <= state.death_time then
					if entry[4] == "UNIT_DIED" then
						state.death_found = state.death_found + 1
						if state.death_found > 1 then
							return nil
						end
					end
				
					state.i = i - 1
					return entry
				end
			end
			state.i = nil
		end
		state.t = state.t - 1
	until state.t < state.endt
	
	return nil
end
	
function DeathNote:IterateDeath(death, maxt)
	local state = {
		guid = death[2],
		death_time = death[1],
		t = floor(death[1]),
		endt = floor(death[1]) - maxt,
		death_found = 0,
	}
	
	return DeathIterator, state
end

-- Overkill readers
local function SpellDamageAmount(spellId, spellName, spellSchool, ...)
	return ...
end

local function SwingDamageAmount(...)
	return ...
end

local function EnvironmentalAmount(environmentalType, amount)
	return amount
end

local function SpellInstakillAmount()
	return -1
end

-- Heal readers
local function SpellHealAmount(spellId, spellName, spellSchool, amount)
	return amount
end

-- SpellId readers
function SpellSpellId(spellId, spellName, spellSchool)
	return spellId, spellName, spellSchool
end

function SwingSpellId(amount, overkill, school)
	return ACTION_SWING, ACTION_SWING, school
end

function EnvironmentalSpellId(environmentalType, amount, overkill, school)
	return _G["STRING_ENVIRONMENTAL_DAMAGE_" .. environmentalType], _G["STRING_ENVIRONMENTAL_DAMAGE_" .. environmentalType], school
end

-- Aura readers
local function AuraApplied(spellId, spellName, spellSchool, auraType, amount)
	return true, auraType, amount, spellId, spellName, spellSchool
end

local function AuraRemoved(spellId, spellName, spellSchool, auraType, amount)
	return false, auraType, amount, spellId, spellName, spellSchool
end

local event_reader_table = {
	["SPELL_DAMAGE"] 			= { SpellDamageAmount, nil, SpellSpellId },
	["SPELL_PERIODIC_DAMAGE"] 	= { SpellDamageAmount, nil, SpellSpellId },
	["SPELL_BUILDING_DAMAGE"] 	= { SpellDamageAmount, nil, SpellSpellId },
	["RANGE_DAMAGE"] 			= { SpellDamageAmount, nil, SpellSpellId },
	["DAMAGE_SHIELD"] 			= { SpellDamageAmount, nil, SpellSpellId },
	["DAMAGE_SPLIT"] 			= { SpellDamageAmount, nil, SpellSpellId },

	["SPELL_MISSED"] 			= { nil, nil, SpellSpellId, nil, true },
	["SPELL_PERIODIC_MISSED"] 	= { nil, nil, SpellSpellId, nil, true },
	["SPELL_BUILDING_MISSED"] 	= { nil, nil, SpellSpellId, nil, true },
	["DAMAGE_SHIELD_MISSED"] 	= { nil, nil, SpellSpellId, nil, true },

	["SWING_DAMAGE"] 			= { SwingDamageAmount, nil, SwingSpellId },

	["SWING_MISSED"] 			= { nil, nil, SwingSpellId, nil, true },

	["ENVIRONMENTAL_DAMAGE"] 	= { EnvironmentalAmount, nil, EnvironmentalSpellId },

	["SPELL_HEAL"] 				= { nil, SpellHealAmount, SpellSpellId },
	["SPELL_PERIODIC_HEAL"] 	= { nil, SpellHealAmount, SpellSpellId },
	["SPELL_BUILDING_HEAL"] 	= { nil, SpellHealAmount, SpellSpellId },
	
	["SPELL_AURA_APPLIED"]		= { nil, nil, SpellSpellId, AuraApplied },
	["SPELL_AURA_REMOVED"]		= { nil, nil, SpellSpellId, AuraRemoved },
	["SPELL_AURA_APPLIED_DOSE"]	= { nil, nil, SpellSpellId, AuraApplied },
	["SPELL_AURA_REMOVED_DOSE"]	= { nil, nil, SpellSpellId, AuraRemoved },
	
	-- ["SPELL_CAST_START"]		= { CastStart, CastChat, CastTooltip },
	-- ["SPELL_CAST_FAILED"]		= { CastFailed, CastChat, CastTooltip },
	-- ["SPELL_CAST_SUCCESS"]		= { CastSuccess, CastChat, CastTooltip },
	
	-- ["SPELL_INTERRUPT"] 		= { SpellInterrupt, SpellChat, SpellTooltip },
	
	["SPELL_INSTAKILL"]			= { SpellInstakillAmount, nil, SpellSpellId },

	-- ["UNIT_DIED"] 				= { nil, nil },
}

local function GetEntryReader(entry, nreader)
	local reader = event_reader_table[entry[4]] and event_reader_table[entry[4]][nreader]

	if reader then
		return reader(unpack(entry, 11))
	end
end

function DeathNote:GetEntryDamage(entry)
	return GetEntryReader(entry, 1)
end

function DeathNote:GetEntryHeal(entry)
	return GetEntryReader(entry, 2)
end

function DeathNote:GetEntrySpell(entry)
	return GetEntryReader(entry, 3)
end

function DeathNote:GetEntryAura(entry)
	return GetEntryReader(entry, 4)
end

function DeathNote:GetEntryMiss(entry)
	return event_reader_table[entry[4]] and event_reader_table[entry[4]][5]
end

function DeathNote:GetKillingBlow(death)	
	for entry in self:IterateDeath(death, 3) do
		local damage, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing = self:GetEntryDamage(entry)
		if damage and damage > 0 or damage == -1 then
			return entry, damage, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing
		end
	end
	
	return nil
end

function DeathNote:IsEntryOverThreshold(entry)
	if self.settings.display_filters.damage_threshold > 0 then
		local damage = self:GetEntryDamage(entry)
		if damage and damage < self.settings.display_filters.damage_threshold then
			return false
		end
	end

	if self.settings.display_filters.heal_threshold > 0 then
		local heal = self:GetEntryHeal(entry)
		if heal and heal < self.settings.display_filters.heal_threshold then
			return false
		end
	end

	return true
end

function DeathNote:IsEntryFiltered(entry)
	if self.settings.display_filters.hide_misses then
		local miss = self:GetEntryMiss(entry)
		if miss then
			return false
		end
	end	
	if self.settings.display_filters.survival_buffs then
		local gain, _, _, spellid = self:GetEntryAura(entry)
		if self.SurvivalIDs[spellid] then
			return true
		end	
	end
	
	if not self.settings.display_filters.buff_gains then
		local gain, auraType = self:GetEntryAura(entry)
		if gain and auraType == "BUFF" then
			return false
		end
	end

	if not self.settings.display_filters.buff_fades then
		local gain, auraType = self:GetEntryAura(entry)
		if not gain and auraType == "BUFF" then
			return false
		end
	end

	if not self.settings.display_filters.debuff_gains then
		local gain, auraType = self:GetEntryAura(entry)
		if gain and auraType == "DEBUFF" then
			return false
		end
	end
	
	if not self.settings.display_filters.debuff_fades then
		local gain, auraType = self:GetEntryAura(entry)
		if not gain and auraType == "DEBUFF" then
			return false
		end
	end
	
	if next(self.settings.display_filters.spell_filter) then
		local _, spellname = self:GetEntrySpell(entry)
		if self.settings.display_filters.spell_filter[string.lower(spellname or "")] then
			return false
		end
	end

	if next(self.settings.display_filters.source_filter) then
		if self.settings.display_filters.source_filter[string.lower(entry[6] or "")] then
			return false
		end
	end
	
	return true
end
