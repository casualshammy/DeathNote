local function CommaNumber(num)
	local found
	
	repeat
		num, found = string.gsub(num, "(%d)(%d%d%d)$", "%1,%2")
	until found == 0
	
	return num
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

local function FormatUnit(guid, name, flags)
	if not name then
		return ""
	end
	
	if bit.band(flags, COMBATLOG_OBJECT_RAIDTARGET_MASK) > 0 then
		return string.format("%s%s%s", CombatLog_String_GetIcon(flags, "dest"), GetUnitColor(guid, name, flags), name)
	else
		return string.format("%s%s", GetUnitColor(guid, name, flags), name)
	end
end

local function FormatIcon(icon)
	return string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", icon)
end

local function FormatSpell(spellId, spellName, spellSchool)
	local name, _, icon = GetSpellInfo(spellId)
	local colorArray = CombatLog_Color_ColorArrayBySchool(spellSchool, DEFAULT_COMBATLOG_FILTER_TEMPLATE)
	local colorstr = CombatLog_Color_FloatToText(colorArray.r, colorArray.g, colorArray.b, colorArray.a)

	return string.format("%s |c%s%s", FormatIcon(icon), colorstr, name)
end

local function GetAuraTypeColor(auraType)
	return auraType == "BUFF" and "|cFF00FF00" or "|cFFFF0000"
end

local function FormatAuraGain(spellId, spellName, spellSchool, auraType)
	local name, _, icon = GetSpellInfo(spellId)
	return string.format("%s %s+%s", FormatIcon(icon), GetAuraTypeColor(auraType), name)
end

local function FormatAuraFade(spellId, spellName, spellSchool, auraType)
	local name, _, icon = GetSpellInfo(spellId)
	return string.format("%s %s-%s", FormatIcon(icon), GetAuraTypeColor(auraType), name)
end

local function FormatAuraAmount(auraType, amount)
	return string.format("%s%s%s", GetAuraTypeColor(auraType), amount > 0 and "+" or "", CommaNumber(amount))
end

local function FormatSwing()
	local colorArray = CombatLog_Color_ColorArrayBySchool(SCHOOL_MASK_PHYSICAL, DEFAULT_COMBATLOG_FILTER_TEMPLATE)
	local colorstr = CombatLog_Color_FloatToText(colorArray.r, colorArray.g, colorArray.b, colorArray.a)
	return "|c" .. colorstr .. ACTION_SWING
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
	return _G["ACTION_SPELL_MISSED_" .. missType]
end

-- ListBox formatters
local function SpellDamage(spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical)
	return FormatDamage(amount, critical), FormatSpell(spellId, spellName, spellSchool)
end

local function SpellMissed(spellId, spellName, spellSchool, missType)
	return FormatMiss(missType), FormatSpell(spellId, spellName, spellSchool)
end

local function SpellInstakill(spellId, spellName, spellSchool)
	return "|cFFFF0000" .. ACTION_SPELL_INSTAKILL, FormatSpell(spellId, spellName, spellSchool)
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
	return amount and FormatAuraAmount(auraType, amount) or "", FormatAuraGain(spellId, spellName, spellSchool, auraType)
end

local function AuraRemoved(spellId, spellName, spellSchool, auraType, amount)
	return amount and FormatAuraAmount(auraType, -amount) or "", FormatAuraFade(spellId, spellName, spellSchool, auraType)
end

local function UnitDied()
	return "|cFFFF0000Death", ""
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

local function UnitDiedTooltip()
	return false
end

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
	
	["SPELL_CAST_START"]		= { CastStart, SpellChat, SpellTooltip },
	["SPELL_CAST_FAILED"]		= { CastFailed, SpellChat, SpellTooltip },
	["SPELL_CAST_SUCCESS"]		= { CastSuccess, SpellChat, SpellTooltip },
	
	-- ["SPELL_INTERRUPT"] 		= { SpellInterrupt, SpellChat, SpellTooltip },
	
	["SPELL_INSTAKILL"]			= { SpellInstakill, SpellChat, SpellTooltip },

	["UNIT_DIED"] 				= { UnitDied, UnitDiedChat, UnitDiedTooltip },
}

function DeathNote:CycleTimestampDisplay()
	self.settings.display.timestamp = self.settings.display.timestamp % #FormatTimestamp + 1
end

function DeathNote:CycleHealthDisplay()
	self.settings.display.health = self.settings.display.health % #FormatHealth + 1
end

function DeathNote:FormatEntry(entry)
	local event = entry[4]
	local formatter = event_formatter_table[event]
	local amount, spell, source
	
	if formatter and formatter[1] then
		amount, spell, source = formatter[1](unpack(entry, 11))
	else
		amount, spell, source = "No handler", event, nil
		return nil
	end
	
	return {
		FormatTimestamp[self.settings.display.timestamp](entry[3]),
		FormatHealth[self.settings.display.health](entry[1], entry[2]),
		amount,
		spell, 
		source or FormatUnit(entry[5], entry[6], entry[7]),
	}
end

-- Name List
function DeathNote:FormatNameListEntry(v)
	return string.format("[%s] %s", date("%X", v[1]), FormatUnit(v[2], v[3], v[4]))
end

-- Chat
function DeathNote:FormatChatTimestamp(entry)
	return FormatTimestamp[self.settings.display.timestamp](entry[3])
end

function DeathNote:FormatChatHealth(entry)
	return FormatHealthFull(entry[1], entry[2])
end

function DeathNote:FormatChatAmount(entry)
	local text = CombatLog_OnEvent(DEFAULT_COMBATLOG_FILTER_TEMPLATE, unpack(entry, 3))
	text = gsub(text, "(|c........)", "")
	text = gsub(text, "(|r)", "")
	text = gsub(text, "(|Hunit.-|h(.-)|h)", "%2")
	text = gsub(text, "(|Hicon.-|h.-|h)", "")
	text = gsub(text, "(|Hspell:(.-):.-|h.-|h)", function(_, id) return GetSpellLink(id) end)
	-- TODO: item links
	return text
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
	return FormatUnit(entry[5], entry[6], entry[7])
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
