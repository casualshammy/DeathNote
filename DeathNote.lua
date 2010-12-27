DeathNote = LibStub("AceAddon-3.0"):NewAddon("DeathNote", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")

function DeathNote:OnInitialize()
	-- AceDB options
	self.db = LibStub("AceDB-3.0"):New("DeathNoteDB", {
		profile = {
			max_deaths = 50,
			death_time = 60,
			
			display = {
				namelist = 1,
				timestamp = 1,
				health = 1,
			},
		},
	})
	
	self.settings = self.db.profile
	
	-- Register options
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Death Note", self.Options)	
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Death Note", "Death Note")
	
	-- Register LDB object
	self.ldb = LibStub("LibDataBroker-1.1"):NewDataObject("DeathNote", {
		type = "launcher",
		label = "|cFF8F8F8FDeath Note|r",
		text = "|cFF8F8F8FDeath Note|r",
		icon = [[Interface\AddOns\DeathNote\Textures\icon.tga]],
		OnClick = function(self, button)
			if button == "LeftButton" then
				DeathNote:Show()
			elseif button == "RightButton" then
				-- DeathNote:ResetData()
				InterfaceOptionsFrame_OpenToCategory("Death Note")
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("DeathNote")
			tooltip:AddLine("|cffeda55fClick|r to open DeathNote. |cffeda55fRight-Click|r to show options.", 0.2, 1, 0.2, 1)
		end,
	})
	
	-- UnitPopupMenu support
	UnitPopupButtons["SHOW_DEATH_NOTE"] = {
		text = "Show Death Note",
		icon = [[Interface\AddOns\DeathNote\Textures\icon.tga]],
		dist = 0,
	}

	self:DataCapture_Initialize()
end

function DeathNote:OnEnable()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_FLAGS_CHANGED")
	self:RegisterEvent("PLAYER_LOGOUT")
	
	self:AddToUnitPopup()
	
	self:ScheduleRepeatingTimer("UpdateLDB", 5)
end

function DeathNote:AddToUnitPopup()
	local types = { "PET", "RAID_PLAYER", "PARTY", "SELF", "TARGET", "PLAYER" }
	
	for i, v in ipairs(types) do
		tinsert(UnitPopupMenus[v], #UnitPopupMenus[v], "SHOW_DEATH_NOTE")
	end
	
	self:SecureHook("UnitPopup_ShowMenu")
end

function DeathNote:OnDisable()
	-- TODO: remove from UnitPopup
	self:UnregisterAllEvents()
end

local lt = GetTime()
function DeathNote:UpdateLDB()
	UpdateAddOnMemoryUsage()
	--self.ldb.value = floor(GetAddOnMemoryUsage("DeathNote") + 0.5)
	--self.ldb.suffix = "KB"
	self.ldb.text = string.format("%i KB - %i E/S", floor(GetAddOnMemoryUsage("DeathNote") + 0.5), floor(self.captured_events / (GetTime() - lt) + 0.5))
	-- self.ldb.text = string.format("%i E/s", floor(self.captured_events / (GetTime() - lt) + 0.5))
	
	lt = GetTime()
	
	self.captured_events = 0
end

function DeathNote:SendReport(channel)
	-- TODO: ChatThrottleLib
	local target
	
	if channel == "WHISPER" then
		target = UnitName("target")
	end
	
	local msg  = string.format("DeathNote: Death report for %s at %s", self.current_death[3], date("%X", self.current_death[1]))
	SendChatMessage(msg, channel, nil, target)
	
	for i = self.dropdown_line, 1, -1 do
		local entry = self.logframe:GetLineUserdata(i)
		local timestamp = entry[3]
	
		local msg = string.format("[%.01f s] %s", floor((timestamp - self.current_death[1]) * 10 + 0.05) / 10, self:FormatChatAmount(entry))
		SendChatMessage(msg, channel, nil, target)
	end	
end

function DeathNote:UnitPopup_OnClick(f)
	if f.value == "SHOW_DEATH_NOTE" then
		self:Show()
	end
end
