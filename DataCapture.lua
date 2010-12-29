local tinsert, tremove = table.insert, table.remove
local floor = math.floor
local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax
local UnitIsFeignDeath = UnitIsFeignDeath
local bit_bor, bit_band = bit.bor, bit.band

local log
local deaths

local unit_filters = {}

local SPELLID_LIFETAP = 1454
local SPELLID_SOR = 27827

local SorSkipTable = {}

local function SpellAuraRemovedFilter(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool, auraType)
	if spellId == SPELLID_SOR then
		-- Ignore next UNIT_DIED for sourceGUID
		SorSkipTable[sourceGUID] = timestamp
	end
end

local function SpellCastSuccessFilter(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellId, spellName, spellSchool)
	if spellId == SPELLID_LIFETAP then
		-- Generate fake SPELL_DAMAGE with the Life Tap damage
		local hpmax = UnitHealthMax(sourceName) or 0
		local amount = floor(hpmax * 0.15 + 0.5)
		
		DeathNote:COMBAT_LOG_EVENT_UNFILTERED(
			"COMBAT_LOG_EVENT_UNFILTERED",
			timestamp,
			"SPELL_DAMAGE",
			sourceGUID,
			sourceName,
			sourceFlags,
			sourceGUID,
			sourceName,
			sourceFlags,
			spellId,
			spellName,
			spellSchool,
			amount,
			-1,
			spellSchool)
	end
end

local function UnitDiedFilter(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags)
	if not destName then
		return
	end
	
	if UnitIsFeignDeath(destName) then
		return
	end
	
	local t = SorSkipTable[destGUID]
	if t then
		SorSkipTable[destGUID] = nil
		if (timestamp - t)  < 2  then
			return
		end
	end
	
	tinsert(deaths, { timestamp, destGUID, destName, destFlags })
	
	-- UpdateNameList does nothing when the frame is hidden
	DeathNote:UpdateNameList()
end

local event_handler_table = {
	["SPELL_DAMAGE"] 			= true,
	["SPELL_PERIODIC_DAMAGE"] 	= true,
	["SPELL_BUILDING_DAMAGE"] 	= true,
	["RANGE_DAMAGE"] 			= true,
	["DAMAGE_SHIELD"] 			= true,
	["DAMAGE_SPLIT"] 			= true,

	["SPELL_MISSED"] 			= true,
	["SPELL_PERIODIC_MISSED"] 	= true,
	["SPELL_BUILDING_MISSED"] 	= true,
	["DAMAGE_SHIELD_MISSED"] 	= true,

	["SWING_DAMAGE"] 			= true,
	
	["SWING_MISSED"] 			= true,

	["ENVIRONMENTAL_DAMAGE"] 	= true,

	["SPELL_HEAL"] 				= true,
	["SPELL_PERIODIC_HEAL"] 	= true,
	["SPELL_BUILDING_HEAL"] 	= true,
	
	["SPELL_AURA_APPLIED"]		= true,
	["SPELL_AURA_REMOVED"]		= SpellAuraRemovedFilter,
	["SPELL_AURA_APPLIED_DOSE"]	= true,
	["SPELL_AURA_REMOVED_DOSE"]	= true,
	["SPELL_AURA_REFRESH"]		= true,
	["SPELL_AURA_BROKEN"]		= true,
	["SPELL_AURA_BROKEN_SPELL"]	= true,
	
	["SPELL_CAST_START"]		= true,
	["SPELL_CAST_SUCCESS"]		= SpellCastSuccessFilter,
	
	["SPELL_DISPEL"]			= true,
	["SPELL_DISPEL_FAILED"]		= true,
	["SPELL_STOLEN"]			= true,
	
	["SPELL_INTERRUPT"] 		= true,
	
	["SPELL_INSTAKILL"]			= true,
	
	["UNIT_DIED"] 				= UnitDiedFilter,
}

function DeathNote:DataCapture_Initialize()
	if not DeathNoteData then
		DeathNoteData = {
			log = {},
			deaths = {},
			keep_data = false,
		}
	end
	
	log = DeathNoteData.log
	deaths = DeathNoteData.deaths	
	self:UpdateUnitFilters()
end

function DeathNote:ResetData(silent)
	wipe(log)
	wipe(deaths)
	collectgarbage("collect")
	self:UpdateNameList()
	
	if not silent then
		self:Print("Data has been reset")
	end
end

function DeathNote:CleanData(manual)
	if manual or self.settings.debugging then debugprofilestart() end

	if not self.frame or not self.frame:IsShown() then
		local count = #deaths - self.settings.max_deaths
		for i = 1, count do
			tremove(deaths, 1)
		end
	end

	self:UpdateNameList()

	local death_time = self.settings.death_time
	local others_death_time = self.settings.others_death_time
	local min_time = deaths[1] and (deaths[1][1] - death_time) or 0
	local max_time = time() - death_time
	
	local keep_guid, keep_all = {}, {}
	for i = 1, #deaths do
		local deathsi = deaths[i]
		local timestamp = floor(deathsi[1])
		local guid = deathsi[2]
		for t = timestamp - death_time, timestamp - others_death_time do
			if not keep_guid[t] then
				keep_guid[t] = {}
			end
			keep_guid[t][guid] = true
		end

		for t = timestamp - others_death_time, timestamp do
			keep_all[t] = true
		end
	end

	local t = next(log)
	while t do
		local logt = log[t]
		if logt then
			if t < min_time then
				log[t] = nil
			elseif t < max_time and not keep_all[t] then
				local keep_guidt = keep_guid[t]				
				if not keep_guidt then
					log[t] = nil
				else
					for i = #logt, 1, -1 do
						if not keep_guidt[logt[i][8]] then
							tremove(logt, i)
						end
					end
				end
			end
		end
		t = next(log, t)
	end
	
	if manual or self.settings.debugging then self:Debug(string.format("Data optimization took %.02f ms", debugprofilestop())) end
end

function DeathNote:SetUnitFilter(filter, value)
	self.settings.unit_filters[filter] = value
	self:UpdateUnitFilters()
end

function DeathNote:UpdateUnitFilters()
	local f = self.settings.unit_filters

	wipe(unit_filters)

	if f.group then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_TYPE_PLAYER))
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_AFFILIATION_PARTY, COMBATLOG_OBJECT_TYPE_PLAYER))
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_AFFILIATION_RAID, COMBATLOG_OBJECT_TYPE_PLAYER))
	end
	
	if f.my_pet then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_AFFILIATION_MINE, COMBATLOG_OBJECT_TYPE_PET))
	end
	
	if f.friendly_players then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_REACTION_FRIENDLY))
	end
	
	if f.enemy_players then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_TYPE_PLAYER, COMBATLOG_OBJECT_REACTION_HOSTILE))
	end

	if f.friendly_npcs then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_TYPE_NPC, COMBATLOG_OBJECT_REACTION_FRIENDLY))
	end

	if f.enemy_npcs then
		tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_TYPE_NPC, COMBATLOG_OBJECT_REACTION_HOSTILE))
	end

	if f.other_pets then
		if f.friendly_players then
			tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET))
		end
		
		if f.enemy_players then
			tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_CONTROL_PLAYER, COMBATLOG_OBJECT_TYPE_PET))
		end

		if f.friendly_npcs then
			tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_REACTION_FRIENDLY, COMBATLOG_OBJECT_CONTROL_NPC, COMBATLOG_OBJECT_TYPE_PET))
		end

		if f.enemy_npcs then
			tinsert(unit_filters, bit_bor(COMBATLOG_OBJECT_REACTION_HOSTILE, COMBATLOG_OBJECT_CONTROL_NPC, COMBATLOG_OBJECT_TYPE_PET))
		end
	end
end

function DeathNote:PLAYER_REGEN_DISABLED()
	self:CancelTimer(self.clean_timer, true)
end

function DeathNote:PLAYER_REGEN_ENABLED()
	self.clean_timer = self:ScheduleTimer("CleanData", 15)
end

function DeathNote:PLAYER_FLAGS_CHANGED(_, unitid)
	if unitid == "player" and UnitIsAFK("player") then
		self:CleanData()
	end
end

function DeathNote:PLAYER_LOGOUT()
	if not DeathNoteData.keep_data then
		self:ResetData(true)
	end
end

local function IsFiltered(sourceFlags, destFlags)
	for i = 1, #unit_filters do
		local f = unit_filters[i]
		if bit_band(f, sourceFlags) == f or bit_band(f, destFlags) == f then
			return true
		end
	end
	
	return false
end

function DeathNote:COMBAT_LOG_EVENT_UNFILTERED(_, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
	local handler = event_handler_table[event]
	if handler and IsFiltered(sourceFlags, destFlags) then
		local hp = destName and UnitHealth(destName) or 0
		local hpmax = destName and UnitHealthMax(destName) or 0
		local entry = { hp, hpmax, timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ... }
		
		local t = floor(timestamp)
		
		if not log[t] then
			log[t] = {}
		end
		
		tinsert(log[t], entry)
		
		if handler ~= true then
			handler(timestamp, event, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, ...)
		end
	end
end
