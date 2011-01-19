DeathNote.Options = {
	type = "group",
	args = {
		data_capture = {
			order = 1,
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

				--[[
				TODO: Reenable this once implemented
				
				others_death_time = {
					order = 3,
					name = "Seconds to keep before each death (for other units)",
					desc = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory.",
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
				]]

				filter_capture = {
					order = 10,
					name = "Units filters",
					type = "group",
					inline = true,
					args = {
						help = {
							order = 0,
							type = "description",
							name = "Check the units you are interested in. Data for the units not filtered is discarded.",
						},

						group = {
							order = 1,
							type = "toggle",
							name = "Group players",
							desc = "Party and raid members, including yourself",
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
							desc = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated.",
							get = function() return DeathNote.settings.unit_filters.other_pets end,
							set = function(_, v) DeathNote:SetUnitFilter("other_pets", v) end,
						},

						friendly_players = {
							order = 4,
							type = "toggle",
							name = "Friendly players",
							desc = "All friendly players, including those not in your group",
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
					desc = "Enable this if you want the data to persist after logging out or after a reload ui.\nKeep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.",
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

		announce = {
			order = 2,
			name = "Announce",
			type = "group",
			args = {
				announce = {
					order = 10,
					name = "Announce deaths",
					type = "toggle",
					width = "full",
					get = function() return DeathNote.settings.announce.enable end,
					set = function(_, v) DeathNote.settings.announce.enable = v end,
				},

				announce_unknown = {
					order = 11,
					name = "Announce deaths with an unknown cause",
					type = "toggle",
					width = "full",
					disabled = function() return not DeathNote.settings.announce.enable end,
					get = function() return DeathNote.settings.announce.announce_unknown end,
					set = function(_, v) DeathNote.settings.announce.announce_unknown = v end,
				},

				announce_limit = {
					order = 12,
					name = "Announces/10 seconds limit",
					type = "range",
					min = 1,
					softMax = 10,
					step = 1,
					width = "full",
					disabled = function() return not DeathNote.settings.announce.enable end,
					get = function() return DeathNote.settings.announce.limit end,
					set = function(_, v) DeathNote.settings.announce.limit = v end,
				},

				channel = {
					order = 20,
					name = "Output channel",
					type = "select",
					disabled = function() return not DeathNote.settings.announce.enable end,
					values = {
						["CHATFRAME"] = "Chat frame",
						["SAY"] = "Say",
						["PARTY"] = "Party",
						["RAID"] = "Raid",
						["BATTLEGROUND"] = "Battleground",
						["GROUP"] = "Group (party or raid)",
						["RW"] = "Raid Warning",
						["GUILD"] = "Guild",
						["OFFICER"] = "Officer",
						["WHISPER"] = "Whisper",
					},
					get = function() return DeathNote.settings.announce.channel end,
					set = function(_, v) DeathNote.settings.announce.channel = v end,
				},

				format = {
					order = 30,
					name = "Style",
					type = "select",
					style = "radio",
					disabled = function() return not DeathNote.settings.announce.enable end,
					values = {
						["COMBAT_LOG"] = "Combat log line",
						["FORMATTED"] = "Formatted",
					},
					get = function() return DeathNote.settings.announce.style end,
					set = function(_, v) DeathNote.settings.announce.style = v end,
				},

				format_style = {
					order = 40,
					name = "Formatted options",
					type = "group",
					inline = true,
					disabled = function() return not DeathNote.settings.announce.enable or DeathNote.settings.announce.style ~= "FORMATTED" end,
					args = {
						format_damage = {
							order = 10,
							name = "Include damage",
							type = "toggle",
							get = function() return DeathNote.settings.announce.format_damage end,
							set = function(_, v) DeathNote.settings.announce.format_damage = v end,
						},

						format_resisted = {
							order = 20,
							name = "Include amount resisted/blocked/absorbed",
							type = "toggle",
							width = "double",
							get = function() return DeathNote.settings.announce.format_resist end,
							set = function(_, v) DeathNote.settings.announce.format_resist = v end,
						},

						format_hittype = {
							order = 30,
							name = "Include hit type (critical, crushing, etc)",
							type = "toggle",
							width = "double",
							get = function() return DeathNote.settings.announce.format_hittype end,
							set = function(_, v) DeathNote.settings.announce.format_hittype = v end,
						},

						format_overkill = {
							order = 40,
							name = "Include overkill",
							type = "toggle",
							get = function() return DeathNote.settings.announce.format_overkill end,
							set = function(_, v) DeathNote.settings.announce.format_overkill = v end,
						},
					},
				},
			},
		},
	},
}
