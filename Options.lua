DeathNote.Options = {
	type = "group",
	inline = true,
	args = {
		graphics = {
			name = "Data capture",
			type = "group",
			args = {
				max_deaths = {
					order = 1,
					name = "Maximum number of deaths",
					type = "range",
					min = 25,
					max = 500,
					step = 1,
					width = "full",
					get = function() return DeathNote.settings.max_deaths end,
					set = function(_, v) DeathNote.settings.max_deaths = v end,
				},
				
				death_time = {
					order = 2,
					name = "Time to keep",
					type = "range",
					min = 10,
					max = 120,
					step = 1,
					width = "full",
					get = function() return DeathNote.settings.death_time end,
					set = function(_, v) DeathNote.settings.death_time = v end,
				},
				
				filter_capture = {
					order = 3,
					name = "Unit filters",
					type = "group",
					inline = true,
					args = {
						group = {
							order = 1,
							type = "toggle",
							name = "Group members",
							width = "full",
							-- COMBATLOG_OBJECT_AFFILIATION_PARTY or COMBATLOG_OBJECT_AFFILIATION_RAID
						},
						
						friendly_players = {
							order = 4,
							type = "toggle",
							name = "Friendly players",
							-- COMBATLOG_OBJECT_TYPE_PLAYER and COMBATLOG_OBJECT_REACTION_FRIENDLY
						},
						
						enemy_players = {
							order = 5,
							type = "toggle",
							name = "Enemy players",
							-- COMBATLOG_OBJECT_TYPE_PLAYER and COMBATLOG_OBJECT_REACTION_HOSTILE
						},

						your_pet = {
							order = 2,
							type = "toggle",
							name = "Your pet",
							-- COMBATLOG_OBJECT_AFFILIATION_MINE and COMBATLOG_OBJECT_TYPE_PET
						},
						
						other_pets = {
							order = 3,
							type = "toggle",
							name = "Other pets",
							-- group/friendly/enemy/fnpc/enpc and COMBATLOG_OBJECT_TYPE_PET
						},
						
						friendly_npcs = {
							order = 6,
							type = "toggle",
							name = "Friendly NPCs",
							-- COMBATLOG_OBJECT_REACTION_FRIENDLY and COMBATLOG_OBJECT_TYPE_NPC
						},
						
						enemy_npcs = {
							order = 7,
							type = "toggle",
							name = "Enemy NPCs",
							-- COMBATLOG_OBJECT_REACTION_HOSTILE and COMBATLOG_OBJECT_TYPE_NPC
						},
					},
				},

				keep_data = {
					order = 4,
					name = "Keep data between sessions",
					type = "toggle",
					width = "full",
					get = function() return DeathNoteData.keep_data end,
					set = function(_, v) DeathNoteData.keep_data = v end,
				},				
			},
		},
	},
}
