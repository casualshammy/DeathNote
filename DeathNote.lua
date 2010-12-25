DeathNote = LibStub("AceAddon-3.0"):NewAddon("DeathNote", "AceEvent-3.0", "AceTimer-3.0")

function DeathNote:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DeathNoteDB", {
		profile = {
			max_deaths = 50,
			death_time = 60,
			
			display = {
				timestamp = 1,
				health = 1,
			},
		},
	})
	
	self.settings = self.db.profile
	
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
				DeathNote:ResetData()
			end
		end,
		OnTooltipShow = function(tooltip)
			tooltip:AddLine("DeathNote")			
			tooltip:AddLine("|cffeda55fClick|r to open DeathNote. |cffeda55fRight-Click|r to show options.", 0.2, 1, 0.2, 1)
		end,
	})
	
	self:DataCapture_Initialize()
end

-- local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage
-- local GetAddOnMemoryUsage = GetAddOnMemoryUsage

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

function DeathNote:OnEnable()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_LOGOUT")
	
	self:ScheduleRepeatingTimer("UpdateLDB", 1)
	
	self:Show()
end

function DeathNote:OnDisable()
	self:UnregisterAllEvents()
end
