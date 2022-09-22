DeathNote.SurvivalIDs = {
	[48707] =	{ class = "DEATHKNIGHT", priority = 1 },
	[50461] =	{ class = "DEATHKNIGHT", priority = 2  },
	[48792] =	{ class = "DEATHKNIGHT", priority = 1  },
	[55233] =	{ class = "DEATHKNIGHT", priority = 1  },
	[49028] =	{ class = "DEATHKNIGHT", priority = 1  },
		
	[22812] =  	{ class = "DRUID", priority = 2 },
	[22842] =  	{ class = "DRUID", priority = 2 },
	[61336] =  	{ class = "DRUID", priority = 2 },
	[33891] =  	{ class = "DRUID", priority = 2 },

	
	[45438] = 	{ class = "MAGE", priority = 1 },
	
	[31850] = 	{ class = "PALADIN", priority = 2 },
	[498] =   	{ class = "PALADIN", priority = 2 },
	[642] =   	{ class = "PALADIN", priority = 2 },
	[1022] =  	{ class = "PALADIN", priority = 1 },
	[6940] =  	{ class = "PALADIN", priority = 1 },

	[47585] = 	{ class = "PRIEST", priority = 2 },
	[33206] = 	{ class = "PRIEST", priority = 1 },
	[47788] = 	{ class = "PRIEST", priority = 1 },

	[31224] = 	{ class = "ROGUE", priority = 1 },
	[1966] =  	{ class = "ROGUE", priority = 1 },
	[5277] =  	{ class = "ROGUE", priority = 1 },
	
	[12975] = 	{ class = "WARRIOR", priority = 2 },
	[2565] =  	{ class = "WARRIOR", priority = 2 },
	[871] =   	{ class = "WARRIOR", priority = 2 },
	[23920] = 	{ class = "WARRIOR", priority = 2 },

};

DeathNote.SurvivalColors = { };
for class, color in pairs(RAID_CLASS_COLORS) do
	local class_color = RAID_CLASS_COLORS[class];
	local color = { r = class_color.r, g  = class_color.g, b = class_color.b, a = 0.2 };
	DeathNote.SurvivalColors[class] = color;
end