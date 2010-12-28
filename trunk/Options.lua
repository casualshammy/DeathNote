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
					min = 5,
					max = 500,
					step = 1,
					width = "full",
					get = function() return DeathNote.settings.max_deaths end,
					set = function(_, v) DeathNote.settings.max_deaths = v end,
				},
				
				death_time = {
					order = 2,
					name = "Seconds to keep before each death (for the unit killed)",
					type = "range",
					min = 5,
					max = 120,
					step = 1,
					width = "full",
					get = function() return DeathNote.settings.death_time end,
					set = function(_, v)
						DeathNote.settings.death_time = v
						DeathNote.settings.others_death_time = math.min(v, DeathNote.settings.others_death_time)
					end,
				},
				
				others_death_time = {
					order = 3,
					name = "Seconds to keep before each death (for other units)",
					type = "range",
					min = 0,
					max = 120,
					step = 1,
					width = "full",
					get = function() return DeathNote.settings.others_death_time end,
					set = function(_, v)
						DeathNote.settings.others_death_time = v
						DeathNote.settings.death_time = math.max(v, DeathNote.settings.death_time)
					end,
				},

				filter_capture = {
					order = 10,
					name = "Unit filters",
					type = "group",
					inline = true,
					args = {
						group = {
							order = 1,
							type = "toggle",
							name = "Group players",
							width = "full",
							get = function() return DeathNote.settings.unit_filters.group end,
							set = function(_, v) DeathNote:SetUnitFilter("group", v) end,
						},
						
						your_pet = {
							order = 2,
							type = "toggle",
							name = "Your pet",
							get = function() return DeathNote.settings.unit_filters.my_pet end,
							set = function(_, v) DeathNote:SetUnitFilter("my_pet", v) end,
						},
						
						other_pets = {
							order = 3,
							type = "toggle",
							name = "Other pets",
							get = function() return DeathNote.settings.unit_filters.other_pets end,
							set = function(_, v) DeathNote:SetUnitFilter("other_pets", v) end,
						},
						
						friendly_players = {
							order = 4,
							type = "toggle",
							name = "Friendly players",
							get = function() return DeathNote.settings.unit_filters.friendly_players end,
							set = function(_, v) DeathNote:SetUnitFilter("friendly_players", v) end,
						},
						
						enemy_players = {
							order = 5,
							type = "toggle",
							name = "Enemy players",
							get = function() return DeathNote.settings.unit_filters.enemy_players end,
							set = function(_, v) DeathNote:SetUnitFilter("enemy_players", v) end,
						},

						friendly_npcs = {
							order = 6,
							type = "toggle",
							name = "Friendly NPCs",
							get = function() return DeathNote.settings.unit_filters.friendly_npcs end,
							set = function(_, v) DeathNote:SetUnitFilter("friendly_npcs", v) end,
						},
						
						enemy_npcs = {
							order = 7,
							type = "toggle",
							name = "Enemy NPCs",
							get = function() return DeathNote.settings.unit_filters.enemy_npcs end,
							set = function(_, v) DeathNote:SetUnitFilter("enemy_npcs", v) end,
						},
					},
				},

				keep_data = {
					order = 20,
					name = "Keep data between sessions",
					type = "toggle",
					width = "full",
					get = function() return DeathNoteData.keep_data end,
					set = function(_, v) DeathNoteData.keep_data = v end,
				},
				
				reset_data = {
					order = 30,
					name = "Reset data",
					type = "execute",
					func = function() DeathNote:ResetData() end
				},
			},
		},
	},
}
