DeathNote.SurvivalIDs = {
	[48707] =	{ class = "DEATHKNIGHT", priority = 1 },
	[50461] =	{ class = "DEATHKNIGHT", priority = 2  },
	[48792] =	{ class = "DEATHKNIGHT", priority = 1  },
	[55233] =	{ class = "DEATHKNIGHT", priority = 1  },
	[49028] =	{ class = "DEATHKNIGHT", priority = 1  },
	[194679] =	{ class = "DEATHKNIGHT", priority = 1  },
	[207319] =	{ class = "DEATHKNIGHT", priority = 1  },
	
	[218256] =	{ class = "DEMONHUNTER", priority = 1 },
	[196555] =	{ class = "DEMONHUNTER", priority = 1 },
	[198589] =	{ class = "DEMONHUNTER", priority = 1 },
	[196718] =	{ class = "DEMONHUNTER", priority = 2 },
	[191427] =	{ class = "DEMONHUNTER", priority = 1 },
	[187827] =	{ class = "DEMONHUNTER", priority = 1 },
	
	[22812] =  	{ class = "DRUID", priority = 2 },
	[22842] =  	{ class = "DRUID", priority = 2 },
	[61336] =  	{ class = "DRUID", priority = 2 },
	[200851] = 	{ class = "DRUID", priority = 2 },
	[33891] =  	{ class = "DRUID", priority = 2 },
	[102558] = 	{ class = "DRUID", priority = 2 },
	[102342] = 	{ class = "DRUID", priority = 1 },

	[186265] =	{ class = "HUNTER", priority = 1 },
	
	[45438] = 	{ class = "MAGE", priority = 1 },
	
	[115203] =	{ class = "MONK", priority = 2 },
	[116849] =	{ class = "MONK", priority = 1 },
	[122783] =	{ class = "MONK", priority = 2 },
	[115176] =	{ class = "MONK", priority = 2 },
	[122278] =	{ class = "MONK", priority = 2 },

	[86659] = 	{ class = "PALADIN", priority = 2 },
	[31850] = 	{ class = "PALADIN", priority = 2 },
	[498] =   	{ class = "PALADIN", priority = 2 },
	[642] =   	{ class = "PALADIN", priority = 2 },
	[1022] =  	{ class = "PALADIN", priority = 1 },
	[6940] =  	{ class = "PALADIN", priority = 1 },
	[205191] =	{ class = "PALADIN", priority = 2 },
	[204150] =	{ class = "PALADIN", priority = 3 },
	[204018] =	{ class = "PALADIN", priority = 1 },

	[47585] = 	{ class = "PRIEST", priority = 2 },
	[33206] = 	{ class = "PRIEST", priority = 1 },
	[47788] = 	{ class = "PRIEST", priority = 1 },
	[81782] = 	{ class = "PRIEST", priority = 3 },

	[31224] = 	{ class = "ROGUE", priority = 1 },
	[1966] =  	{ class = "ROGUE", priority = 1 },
	[5277] =  	{ class = "ROGUE", priority = 1 },
	[199754] =	{ class = "ROGUE", priority = 1 },

	[108271] = 	{ class = "SHAMAN", priority = 1 },
	[98008] =  	{ class = "SHAMAN", priority = 2 },

	[104773] =	{ class = "WARLOCK", priority = 1 },
	
	[12975] = 	{ class = "WARRIOR", priority = 2 },
	[2565] =  	{ class = "WARRIOR", priority = 2 },
	[871] =   	{ class = "WARRIOR", priority = 2 },
	[97463] = 	{ class = "WARRIOR", priority = 3 },
	[184364] =	{ class = "WARRIOR", priority = 2 },
	[213915] =	{ class = "WARRIOR", priority = 3 },
	[197690] =	{ class = "WARRIOR", priority = 2 },
	[23920] = 	{ class = "WARRIOR", priority = 2 },
	[118038] =	{ class = "WARRIOR", priority = 2 },
	[122973] =	{ class = "WARRIOR", priority = 1 },

};

DeathNote.SurvivalColors = { };
for class, color in pairs(RAID_CLASS_COLORS) do
	local class_color = RAID_CLASS_COLORS[class];
	local color = { r = class_color.r, g  = class_color.g, b = class_color.b, a = 0.2 };
	DeathNote.SurvivalColors[class] = color;
end