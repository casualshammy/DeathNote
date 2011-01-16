local tinsert, tremove = table.insert, table.remove

local function CommaNumber(num)
	local found
	
	repeat
		num, found = string.gsub(num, "^(-?%d+)(%d%d%d)", "%1,%2")
	until found == 0
	
	return num
end

local function Capitalize(str)
	return string.gsub(str, "%a", string.upper, 1)
end

local FormatTimestamp = {}
FormatTimestamp[1] = function(timestamp)
	return string.format("%.01f s", floor((timestamp - DeathNote.current_death[1]) * 10 + 0.05) / 10)
end

FormatTimestamp[2] = function(timestamp)
	return string.format("%s.%02i", date("%X", timestamp), (timestamp - floor(timestamp)) * 100)
end

local FormatHealth = {}
FormatHealth[1] = function(hp, hpmax)
	if hpmax == 0 then
		return { 0 }
	else
		return { hp / hpmax }
	end
end

FormatHealth[2] = function(hp, hpmax)
	if hpmax == 0 then
		return "??%"
	else
		return string.format("%i%%", hp / hpmax * 100)
	end
end

FormatHealth[3] = function(hp, hpmax)
	if hpmax == 0 then
		return "??"
	else
		return string.format("%s", CommaNumber(hp))
	end
end

FormatHealth[4] = function(hp, hpmax)
	if hpmax == 0 then
		return "??/??"
	else
		return string.format("%s/%s", CommaNumber(hp), CommaNumber(hpmax))
	end
end

local function FormatHealthFull(hp, hpmax)
	if hpmax == 0 then
		return "??/?? (??%)"
	else
		return string.format("%s/%s (%i%%)", CommaNumber(hp), CommaNumber(hpmax), floor(hp / hpmax * 100))
	end
end

local function GetUnitColor(guid, unit, flags)
	local c
	
	if unit then
		c = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
	end
	
	if not c and guid then
		c = RAID_CLASS_COLORS[select(2, GetPlayerInfoByGUID(guid))]
	end	
	
	if c then
		return string.format("|c%s", CombatLog_Color_FloatToText(c.r, c.g, c.b, 1))
	else
		return "|c" .. CombatLog_Color_ColorStringByUnitType(flags)
	end
end

function DeathNote:FormatUnit(guid, name, flags)
	if not name then
		return ""
	end
	
	if bit.band(flags, COMBATLOG_OBJECT_RAIDTARGET_MASK) > 0 then
		return string.format("%s%s%s|r", CombatLog_String_GetIcon(flags, "dest"), GetUnitColor(guid, name, flags), name)
	else
		return string.format("%s%s|r", GetUnitColor(guid, name, flags), name)
	end
end

local function FormatIcon(icon)
	return string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", icon)
end

local function FormatSpell(spellId, spellName, spellSchool)
	local name, _, icon = GetSpellInfo(spellId)
	local colorArray = CombatLog_Color_ColorArrayBySchool(spellSchool, DEFAULT_COMBATLOG_FILTER_TEMPLATE)
	local colorstr = CombatLog_Color_FloatToText(colorArray.r, colorArray.g, colorArray.b, colorArray.a)

	return string.format("%s|c%s|Hspell:%i|h%s|h|r", FormatIcon(icon), colorstr, spellId, name)
end

local function GetAuraTypeColor(auraType)
	return auraType == "BUFF" and "|cFF00FF00" or "|cFFFF0000"
end

local function GetInverseAuraTypeColor(auraType)
	return auraType == "DEBUFF" and "|cFF00FF00" or "|cFFFF0000"
end

local function FormatAuraType(auraType)
	if auraType == "BUFF" then
		return "Buff"
	elseif auraType == "DEBUFF" then
		return "Debuff"
	else
		return auraType
	end
end

local function FormatAuraApplied(auraType, amount)
	if amount and amount > 0 then
		return string.format("%s<+%s>|r", GetAuraTypeColor(auraType), CommaNumber(amount))
	else
		return string.format("%s+%s|r", GetAuraTypeColor(auraType), FormatAuraType(auraType))
	end
end

local function FormatAuraRemoved(auraType, amount)
	if amount and amount > 0 then
		return string.format("%s<-%s>|r", GetInverseAuraTypeColor(auraType), CommaNumber(amount))
	else
		return string.format("%s-%s|r", GetInverseAuraTypeColor(auraType), FormatAuraType(auraType))
	end
end

local function FormatAuraRefresh(auraType)
	return string.format("%s<Refresh>|r", GetAuraTypeColor(auraType))
end

local function FormatAuraBroken(auraType)
	return string.format("%s<Break>|r", GetAuraTypeColor(auraType))
end

local function FormatDispel(auraType)
	return string.format("%s<Dispel>|r", GetInverseAuraTypeColor(auraType))
end

local function FormatDispelFailed(auraType)
	return string.format("%s<Dispel failed>|r", GetAuraTypeColor(auraType))
end

local function FormatStolen(auraType)
	return string.format("%s<Steal>|r", GetInverseAuraTypeColor(auraType))	
end

local function FormatInterrupt()
	return "|cFFFF0000<Interrupt>|r"
end

local function FormatSwing()
	local colorArray = CombatLog_Color_ColorArrayBySchool(SCHOOL_MASK_PHYSICAL, DEFAULT_COMBATLOG_FILTER_TEMPLATE)
	local colorstr = CombatLog_Color_FloatToText(colorArray.r, colorArray.g, colorArray.b, colorArray.a)
	return "|c" .. colorstr .. ACTION_SWING .. "|r"
end

local function FormatDamage(amount, critical)
	if critical then
		return "|cFFFF0000*" .. CommaNumber(amount)
	else
		return "|cFFFF0000-" .. CommaNumber(amount)
	end
end

local function FormatHeal(amount, critical)
	if critical then
		return "|cFF00FF00*" .. CommaNumber(amount)
	else
		return "|cFF00FF00+" .. CommaNumber(amount)
	end
end

local function FormatMiss(missType)
	return Capitalize(_G["ACTION_SPELL_MISSED_" .. missType] or "Miss")
end

-- ListBox formatters
local function SpellDamage(spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical)
	return FormatDamage(amount, critical), FormatSpell(spellId, spellName, spellSchool)
end

local function SpellMissed(spellId, spellName, spellSchool, missType)
	return FormatMiss(missType), FormatSpell(spellId, spellName, spellSchool)
end

local function SpellInstakill(spellId, spellName, spellSchool)
	return "|cFFFF0000" .. Capitalize(ACTION_SPELL_INSTAKILL), FormatSpell(spellId, spellName, spellSchool)
end

local function SwingDamage(amount, overkill, school, resisted, blocked, absorbed, critical)
	return FormatDamage(amount, critical), FormatSwing()
end

local function SwingMissed(missType)
	return FormatMiss(missType), FormatSwing()
end

local function EnvironmentalDamage(environmentalType, amount)
	return FormatDamage(amount), _G["STRING_ENVIRONMENTAL_DAMAGE_" .. environmentalType]
end

local function SpellHeal(spellId, spellName, spellSchool, amount, overhealing, absorbed, critical)
	return FormatHeal(amount, critical), FormatSpell(spellId, spellName, spellSchool)
end

local function AuraApplied(spellId, spellName, spellSchool, auraType, amount)
	return FormatAuraApplied(auraType, amount), FormatSpell(spellId, spellName, spellSchool)
end

local function AuraRemoved(spellId, spellName, spellSchool, auraType, amount)
	return FormatAuraRemoved(auraType, amount), FormatSpell(spellId, spellName, spellSchool)
end

local function AuraRefresh(spellId, spellName, spellSchool, auraType, amount)
	return FormatAuraRefresh(auraType), FormatSpell(spellId, spellName, spellSchool)
end

local function AuraBrokenSpell(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType)
	return FormatAuraBroken(auraType), FormatSpell(spellId, spellName, spellSchool)
end

local function Dispel(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType)
	return FormatDispel(auraType), FormatSpell(extraSpellId, extraSpellName, extraSpellSchool)
end

local function DispelFailed(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType)
	return FormatDispelFailed(auraType), FormatSpell(extraSpellId, extraSpellName, extraSpellSchool)
end

local function Stolen(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool, auraType)
	return FormatStolen(auraType), FormatSpell(extraSpellId, extraSpellName, extraSpellSchool)
end

local function Interrupt(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSpellSchool)
	return FormatInterrupt(), FormatSpell(extraSpellId, extraSpellName, extraSpellSchool)
end

local function UnitDied()
	return "|cFFFF0000Death|r", ""
end

local function CastStart(spellId, spellName, spellSchool)
	return "<Cast start>", FormatSpell(spellId, spellName, spellSchool)
end

local function CastFailed(spellId, spellName, spellSchool)
	return "<Cast failed>", FormatSpell(spellId, spellName, spellSchool)
end

-- Chat formatters
local function SpellChat(spellId, spellName, spellSchool)
	return GetSpellLink(spellId)
end

local function SwingChat()
	return ACTION_SWING
end

local function EnvironmentalChat(environmentalType, amount)
	return _G["STRING_ENVIRONMENTAL_DAMAGE_" .. environmentalType]
end

local function UnitDiedChat()
	return "Death"
end

local function ExtraSpellChat(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool)
	return GetSpellLink(extraSpellId)
end

-- Tooltip formatters
local function SpellTooltip(spellId, spellName, spellSchool)
	GameTooltip:SetSpellByID(spellId)
	return true
end

local function SwingTooltip()
	return false
end

local function EnvironmentalTooltip(environmentalType, amount)
	return false
end

local function ExtraSpellTooltip(spellId, spellName, spellSchool, extraSpellId, extraSpellName, extraSchool)
	GameTooltip:SetSpellByID(extraSpellId)
	return true
end

local function UnitDiedTooltip()
	return false
end

-- Formatter table
local event_formatter_table = {
	["SPELL_DAMAGE"] 			= { SpellDamage, SpellChat, SpellTooltip },
	["SPELL_PERIODIC_DAMAGE"] 	= { SpellDamage, SpellChat, SpellTooltip },
	["SPELL_BUILDING_DAMAGE"] 	= { SpellDamage, SpellChat, SpellTooltip },
	["RANGE_DAMAGE"] 			= { SpellDamage, SpellChat, SpellTooltip },
	["DAMAGE_SHIELD"] 			= { SpellDamage, SpellChat, SpellTooltip },
	["DAMAGE_SPLIT"] 			= { SpellDamage, SpellChat, SpellTooltip },

	["SPELL_MISSED"] 			= { SpellMissed, SpellChat, SpellTooltip },
	["SPELL_PERIODIC_MISSED"] 	= { SpellMissed, SpellChat, SpellTooltip },
	["SPELL_BUILDING_MISSED"] 	= { SpellMissed, SpellChat, SpellTooltip },
	["DAMAGE_SHIELD_MISSED"] 	= { SpellMissed, SpellChat, SpellTooltip },

	["SWING_DAMAGE"] 			= { SwingDamage, SwingChat, SwingTooltip },

	["SWING_MISSED"] 			= { SwingMissed, SwingChat, SwingTooltip },

	["ENVIRONMENTAL_DAMAGE"] 	= { EnvironmentalDamage, EnvironmentalChat, EnvironmentalTooltip },

	["SPELL_HEAL"] 				= { SpellHeal, SpellChat, SpellTooltip },
	["SPELL_PERIODIC_HEAL"] 	= { SpellHeal, SpellChat, SpellTooltip },
	["SPELL_BUILDING_HEAL"] 	= { SpellHeal, SpellChat, SpellTooltip },
	
	["SPELL_AURA_APPLIED"]		= { AuraApplied, SpellChat, SpellTooltip },
	["SPELL_AURA_REMOVED"]		= { AuraRemoved, SpellChat, SpellTooltip },
	["SPELL_AURA_APPLIED_DOSE"]	= { AuraApplied, SpellChat, SpellTooltip },
	["SPELL_AURA_REMOVED_DOSE"]	= { AuraRemoved, SpellChat, SpellTooltip },
	["SPELL_AURA_REFRESH"]		= { AuraRefresh, SpellChat, SpellTooltip },
	["SPELL_AURA_BROKEN"]		= { AuraRemoved, SpellChat, SpellTooltip },
	["SPELL_AURA_BROKEN_SPELL"]	= { AuraBrokenSpell, SpellChat, SpellTooltip },
	
	["SPELL_DISPEL"]			= { Dispel, ExtraSpellChat, ExtraSpellTooltip },
	["SPELL_DISPEL_FAILED"]		= { DispelFailed, ExtraSpellChat, ExtraSpellTooltip },
	["SPELL_STOLEN"]			= { Stolen, SpellChat, SpellTooltip },

	["SPELL_INTERRUPT"] 		= { Interrupt, ExtraSpellChat, ExtraSpellTooltip },
	
	["SPELL_INSTAKILL"]			= { SpellInstakill, SpellChat, SpellTooltip },

	["SPELL_CAST_START"]		= { CastStart, SpellChat, SpellTooltip },
	["SPELL_CAST_SUCCESS"]		= { CastSuccess, SpellChat, SpellTooltip },

	["UNIT_DIED"] 				= { UnitDied, UnitDiedChat, UnitDiedTooltip },
}

-- Name List
function DeathNote:FormatNameListEntry(v)
	return string.format("[%s] %s", date("%X", v[1]), self:FormatUnit(v[2], v[3], v[4]))
end

-- Chat
function DeathNote:FormatChatTimestamp(entry)
	return FormatTimestamp[self.settings.display.timestamp](entry[3])
end

function DeathNote:FormatChatHealth(entry)
	return FormatHealthFull(entry[1], entry[2])
end

local iconBitMap = {
	[COMBATLOG_OBJECT_RAIDTARGET1] = "{rt1}",
	[COMBATLOG_OBJECT_RAIDTARGET2] = "{rt2}",
	[COMBATLOG_OBJECT_RAIDTARGET3] = "{rt3}",
	[COMBATLOG_OBJECT_RAIDTARGET4] = "{rt4}",
	[COMBATLOG_OBJECT_RAIDTARGET5] = "{rt5}",
	[COMBATLOG_OBJECT_RAIDTARGET6] = "{rt6}",
	[COMBATLOG_OBJECT_RAIDTARGET7] = "{rt7}",
	[COMBATLOG_OBJECT_RAIDTARGET8] = "{rt8}",
}

function DeathNote:CleanForChat(text)
	return text:
		gsub("(|c........)", ""):
		gsub("(|r)", ""):
		gsub("(|T.-|t", ""):
		gsub("(|Hunit.-|h(.-)|h)", "%2"):
		gsub("(|Hicon:(.-):.-|h.-|h)", function(_, iconBit) return iconBitMap[tonumber(iconBit)] or "" end):
		gsub("(|Hspell:(%d*).-|h.-|h)", function(_, id) return GetSpellLink(id) end)
end

function DeathNote:FormatCombatLog(entry)
	return CombatLog_OnEvent(DEFAULT_COMBATLOG_FILTER_TEMPLATE, unpack(entry, 3))
end

function DeathNote:FormatChatAmount(entry)
	return self:CleanForChat(self:FormatCombatLog(entry))
end

function DeathNote:FormatChatSpell(entry)
	local event = entry[4]
	local formatter = event_formatter_table[event]
	
	if formatter and formatter[2] then
		return formatter[2](unpack(entry, 11))
	else
		return ""
	end
end

function DeathNote:FormatChatSource(entry)
	return self:CleanForChat(self:FormatUnit(entry[5], entry[6], entry[7]))
end

-- Tooltip
function DeathNote:FormatTooltipTimestamp(entry)
	local text = FormatTimestamp[self.settings.display.timestamp % #FormatTimestamp + 1](entry[3])
	GameTooltip:SetText(text, 1, .82, 0, 1)
	return true
end

function DeathNote:FormatTooltipHealth(entry)
	GameTooltip:SetText(FormatHealthFull(entry[1], entry[2]))
	return true
end

function DeathNote:FormatTooltipAmount(entry)
	local text, r, g, b = CombatLog_OnEvent(DEFAULT_COMBATLOG_FILTER_TEMPLATE, unpack(entry, 3))
	GameTooltip:SetText(text, r, g, b)
	return true
end

function DeathNote:FormatTooltipSpell(entry)
	local event = entry[4]
	local formatter = event_formatter_table[event]
	
	if formatter and formatter[3] then
		return formatter[3](unpack(entry, 11))
	else
		return false
	end
end

function DeathNote:FormatTooltipSource(entry)
	if entry[5] and entry[6] and entry[7] then
		GameTooltip:SetHyperlink(format(TEXT_MODE_A_STRING_SOURCE_UNIT, "", entry[5], entry[6], entry[7]))
		return true
	else
		return false
	end
end

function DeathNote:CycleTimestampDisplay()
	self.settings.display.timestamp = self.settings.display.timestamp % #FormatTimestamp + 1
end

function DeathNote:CycleHealthDisplay()
	self.settings.display.health = self.settings.display.health % #FormatHealth + 1
end

function DeathNote:FormatEntrySpell(entry)
	local event = entry[4]
	local formatter = event_formatter_table[event]
	local spell
	
	if formatter and formatter[1] then
		_, spell, _ = formatter[1](unpack(entry, 11))
	else
		return nil
	end
	
	return spell
end

function DeathNote:FormatEntry(entry)
	if entry.type then
		return self:FormatGroupEntry(entry)
	end
	
	local event = entry[4]
	local formatter = event_formatter_table[event]
	local amount, spell, source
	
	if formatter and formatter[1] then
		amount, spell, source = formatter[1](unpack(entry, 11))
	else
		amount, spell, source = "No handler", event, ""
	end
	
	return {
		FormatTimestamp[self.settings.display.timestamp](entry[3]),
		FormatHealth[self.settings.display.health](entry[1], entry[2]),
		amount,
		spell, 
		source or self:FormatUnit(entry[5], entry[6], entry[7]),
	}
end

-- group stuff. move later
local function FormatGroupTimestamp(group)
	local first = group[1]
	local last = group[#group]
	
	if first[3] == last[3] then
		return FormatTimestamp[DeathNote.settings.display.timestamp](last[3])
	else
		return string.format("%s|cFFFFFFFF .. |r%s", FormatTimestamp[DeathNote.settings.display.timestamp](last[3]), FormatTimestamp[DeathNote.settings.display.timestamp](first[3]))
	end
end

local function FormatGroupHealth(group)
	local entry = group[1]
	return FormatHealth[DeathNote.settings.display.health](entry[1], entry[2])
end

local function FormatGroup(group)
	local func = DeathNote:GetAmountFunc(group.type)
	
	local spells = {}
	local sources = {}
	
	for i = 1, #group do
		local entry = group[i]
		local event = entry[4]
		local formatter = event_formatter_table[event]		
		if formatter and formatter[1] then
			local _, spell, source = formatter[1](unpack(entry, 11))
			source = source or DeathNote:FormatUnit(entry[5], entry[6], entry[7])
			local amount = func and func(DeathNote, entry) or 0

			if spell and spell ~= "" then
				local spellv = spells[spell] or { amount = 0, hits = 0 }
				spellv.amount = spellv.amount + amount
				spellv.hits = spellv.hits + 1
				spells[spell] = spellv
			end
			
			if source and source ~= "" then
				local srcv = sources[source] or { amount = 0, hits = 0 }
				srcv.amount = srcv.amount + amount
				srcv.hits = srcv.hits + 1
				sources[source] = srcv
			end
		end
	end
	
	local sorted_spells = {}
	local sorted_sources = {}
	
	for s, a in pairs(spells) do
		local v = { a, a.hits == 1 and s or string.format("%s (x%i)", s, a.hits) }
		tinsert(sorted_spells, v)
	end
	
	for s, a in pairs(sources) do
		local v = { a, a.hits == 1 and s or string.format("%s (x%i)", s, a.hits) }
		tinsert(sorted_sources, v)
	end

	table.sort(sorted_spells, function(a, b) return a[1].amount > b[1].amount end)
	table.sort(sorted_sources, function(a, b) return a[1].amount > b[1].amount end)

	local spellsstr
	for i, s in ipairs(sorted_spells) do
		spellsstr = spellsstr and (spellsstr .. ", " .. s[2]) or s[2]
	end
	
	local sourcesstr
	for i, s in ipairs(sorted_sources) do
		sourcesstr = sourcesstr and (sourcesstr .. ", " .. s[2]) or s[2]
	end

	return spellsstr, sourcesstr
end

local function FormatGroupAmount(group)
	local self = DeathNote

	if group.type == "DAMAGE" then
		return string.format("(x%i) %s", #group, FormatDamage(self:GetGroupAmount(group)))
	elseif group.type == "HEAL" then
		return string.format("(x%i) %s", #group, FormatHeal(self:GetGroupAmount(group)))
	elseif group.type == "AURA" then
		local auras = {
			BUFF = { gain = 0, fade = 0 },
			DEBUFF = { gain = 0, fade = 0 },
		}
		
		for i = 1, #group do
			local entry = group[i]
			
			local auraGain, auraType = self:GetEntryAura(entry)
			
			if auraGain then
				auras[auraType].gain = auras[auraType].gain + 1
			else
				auras[auraType].fade = auras[auraType].fade + 1
			end
		end
		
		local rlist = {}
		if auras.BUFF.gain > 0 then
			tinsert(rlist, string.format("%s<+%i>|r", GetAuraTypeColor("BUFF"), auras.BUFF.gain))
		end
			
		if auras.DEBUFF.gain > 0 then
			tinsert(rlist, string.format("%s<+%i>|r", GetAuraTypeColor("DEBUFF"), auras.DEBUFF.gain))
		end
		
		if auras.BUFF.fade > 0 then
			tinsert(rlist, string.format("%s<-%i>|r", GetInverseAuraTypeColor("BUFF"), auras.BUFF.fade))
		end
			
		if auras.DEBUFF.fade > 0 then
			tinsert(rlist, string.format("%s<-%i>|r", GetInverseAuraTypeColor("DEBUFF"), auras.DEBUFF.fade))
		end
		
		return table.concat(rlist, " ")
	else
		return group.type
	end
end

function DeathNote:FormatGroupEntry(group)
	if #group == 1 then
		return self:FormatEntry(group[1])
	end

	local spell, source = FormatGroup(group)
	
	return {
		FormatGroupTimestamp(group),
		FormatGroupHealth(group),
		FormatGroupAmount(group),
		spell,
		source,
	}
end
