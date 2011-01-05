DeathNote.SurvivalIDs = {
	-- [48707] = "DEATHKNIGHT",	-- Anti-Magic Shell
	[50461] = "DEATHKNIGHT",	-- Anti-Magic Zone
	[49222] = "DEATHKNIGHT",	-- Bone Shield
	[48792] = "DEATHKNIGHT",	-- Icebound Fortitude
	[55233] = "DEATHKNIGHT",	-- Vampiric Blood

	[22812] = "DRUID",			-- Barkskin
	[22842] = "DRUID",			-- Frenzied Regeneration
	[61336] = "DRUID",			-- Survival Instincts

	[45438] = "MAGE",			-- Ice Block

	[86659] = "PALADIN",		-- Guardian of Ancient Kings
	[31850] = "PALADIN",		-- Ardent Defender
	[70940] = "PALADIN",		-- Divine Guardian
	[498] = "PALADIN",			-- Divine Protection
	[64205] = "PALADIN",		-- Divine Sacrifice
	[642] = "PALADIN",			-- Divine Shield
	[1022] = "PALADIN",			-- Hand of Protection
	[6940] = "PALADIN",			-- Hand of Sacrifice

	[47585] = "PRIEST",			-- Dispersion
	[33206] = "PRIEST",			-- Pain Suppression
	[47788] = "PRIEST",			-- Guardian Spirit
	[81782] = "PRIEST",			-- Power Word: Barrier

	[31224] = "ROGUE",			-- Cloak of Shadows
	[1966] = "ROGUE",			-- Feint

	[30823] = "SHAMAN",			-- Shamanistic Rage

	[12975] = "WARRIOR",		-- Last Stand
	[2565] = "WARRIOR",			-- Shield Block
	[871] = "WARRIOR",			-- Shield Wall
}

do
	DeathNote.SurvivalColors = {}
	
	for class, color in pairs(RAID_CLASS_COLORS) do		
		local class_color = RAID_CLASS_COLORS[class]
		local color = { r = class_color.r, g  = class_color.g, b = class_color.b, a = 0.2 }
		DeathNote.SurvivalColors[class] = color
	end
end