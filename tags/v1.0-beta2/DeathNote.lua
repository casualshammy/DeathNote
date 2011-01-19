DeathNote = LibStub("AceAddon-3.0"):NewAddon("DeathNote", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0", "AceConsole-3.0")

BINDING_HEADER_DEATH_NOTE = "Death Note"
BINDING_NAME_DEATH_NOTE_SHOW_TARGET_DEATH = "Show target deaths"

function DeathNote:OnInitialize()
	-- AceDB options
	self.db = LibStub("AceDB-3.0"):New("DeathNoteDB", {
		profile = {
			debugging = false,
			max_deaths = 50,
			death_time = 30,
			others_death_time = 0,

			unit_filters = {
				group = true,
				my_pet = false,
				other_pets = false,
				friendly_players = false,
				enemy_players = false,
				friendly_npcs = false,
				enemy_npcs = false,
			},

			display = {
				x = 0, y = 0, w = 700, h = 500,
				namelist_width = 220,
				namelist = 1,
				timestamp = 1,
				health = 1,
				scale = 1,
				columns = { 60, 90, 60, 100 },
			},

			display_filters = {
				damage_threshold = 0,
				hide_misses = false,
				consolidate_damage = false,

				heal_threshold = 0,
				consolidate_heals = false,

				buff_gains = true,
				buff_fades = true,
				debuff_gains = true,
				debuff_fades = true,
				survival_buffs = true,
				highlight_survival = true,
				consolidate_auras = false,

				spell_filter = {},
				source_filter = {},
			},

			announce = {
				enable = false,
				announce_unknown = false,
				limit = 3,
				channel = "CHATFRAME",
				style = "FORMATTED",
				format_damage = true,
				format_resist = true,
				format_overkill = true,
				format_hittype = true,
			},
			
			report = {
				max_lines = 15,
				style = "COMBAT_LOG",
			},
		},
	})

	self.settings = self.db.profile
	
	-- Clean options -- TODO: remove this when implemented
	self.settings.others_death_time = 0

	-- Register options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Death Note", self.Options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Death Note", "Death Note")

	-- Register LDB object
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("DeathNote", {
		type = "data source",
		label = "|cFF8F8F8FDeath Note|r",
		text = "|cFF8F8F8FDeath Note|r",
		icon = [[Interface\AddOns\DeathNote\Textures\icon.tga]],
		OnClick = function(self, button)
			if button == "LeftButton" then
				if IsShiftKeyDown() then
					DeathNote:CleanData(true)
					collectgarbage("collect")
					DeathNote:UpdateLDB()
				elseif IsControlKeyDown() then
					DeathNote:ResetData()
					DeathNote:UpdateLDB()
				else
					DeathNote:ShowUnit(UnitName("target"))
				end
			elseif button == "RightButton" then
				InterfaceOptionsFrame_OpenToCategory("Death Note")
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("DeathNote")
			tooltip:AddLine("|cffeda55fClick|r to open DeathNote. |cffeda55fRight-Click|r to show options. |cffeda55fShift-Click|r to optimize data. |cffeda55fCtrl-Click|r to reset data.", 0.2, 1, 0.2, 1)
		end,
	})

	self:DataCapture_Initialize()
end

function DeathNote:OnEnable()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")

	self:AddToUnitPopup()

	self:ScheduleRepeatingTimer("UpdateLDB", 5)

	if self.settings.debugging then
		self:Show()
	end
end

function DeathNote:OnDisable()
	self:RemoveFromUnitPopup()
	self:UnregisterAllEvents()
	self:CancelAllTimers()
end

function DeathNote:Debug(...)
	if self.settings.debugging then
		self:Print(...)
	end
end

local lt = GetTime()
function DeathNote:UpdateLDB()
	UpdateAddOnMemoryUsage()
	self.ldb.text = string.format("%i deaths - %i KB", #DeathNoteData.deaths, floor(GetAddOnMemoryUsage("DeathNote") + 0.5))

	lt = GetTime()
end

------------------------------------------------------------------------------
-- Reports
------------------------------------------------------------------------------

function DeathNote:SendReport(channel, arg)
	local target
	if channel == "WHISPER" then
		target = UnitName("target")
		if not target then
			return
		end
	elseif channel == "CHANNEL" then
		target = arg
	end

	local func
	if self.settings.report.style == "COMBAT_LOG" then
		func = self.FormatReportCombatLog
	else
		func = self.FormatReportCompact
	end

	local msg = string.format("DeathNote: Death report for %s at %s", self.current_death[3], date("%X", self.current_death[1]))
	SendChatMessage(msg, channel, nil, target)

	self.report_line_count = 0
	for i = self.dropdown_line, 1, -1 do
		if self.report_line_count >= self.settings.report.max_lines then
			self:Print(string.format("Limiting report to %i lines", self.settings.report.max_lines))
			break
		end

		local entry = self.logframe:GetLineUserdata(i)

		func(self, entry, channel, target)
	end
	self.report_line_count = nil
end
