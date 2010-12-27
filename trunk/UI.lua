local WindowBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local PaneBackdrop  = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
}

local DraggerBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = nil,
	tile = true, tileSize = 16, edgeSize = 0,
	insets = { left = 3, right = 3, top = 7, bottom = 7 }
}

function DeathNote:Show()
	if not self.frame then
		local frame = CreateFrame("Frame", "DeathNoteFrame", UIParent)
		
		frame:SetWidth(700)
		frame:SetHeight(500)
		frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		frame:SetBackdrop(WindowBackdrop)
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:SetBackdropBorderColor(0.4, 0.4, 0.4)		

		frame:EnableMouse()
		frame:SetMovable(true)
		frame:SetResizable(true)
		frame:SetFrameStrata("DIALOG")
		
		-- titlebar
		local titlebar = frame:CreateTexture(nil, "BACKGROUND")
		--titlebar:SetTexture(0.3, 0.3, 0.3, 1.0)
		titlebar:SetTexture(1, 1, 1, 1)
		titlebar:SetGradient("HORIZONTAL", 0.6, 0.6, 0.6, 0.3, 0.3, 0.3)
		titlebar:SetPoint("TOPLEFT", 4, -4)
		titlebar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -28)
		
		local titlebarframe = CreateFrame("Frame", nil, frame)
		titlebarframe:SetAllPoints(titlebar)
		titlebarframe:EnableMouse()
		titlebarframe:SetScript("OnMouseDown", function()
			self.logframe.content:Hide() -- HACK: for now, either this or huge performance problem
			frame:StartMoving() 
		end)
		titlebarframe:SetScript("OnMouseUp", function()
			self.logframe.content:Show()
			frame:StopMovingOrSizing() 
		end)		

		local titleicon = frame:CreateTexture(nil, "ARTWORK")
		titleicon:SetTexture([[Interface\AddOns\DeathNote\Textures\icon.tga]])
		titleicon:SetPoint("TOPLEFT", titlebar, "TOPLEFT", 2, -2)
		titleicon:SetWidth(22)
		titleicon:SetHeight(22)
		
		local titletext = frame:CreateFontString(nil, "ARTWORK")
		titletext:SetFontObject(GameFontNormal)
		titletext:SetTextColor(0.6, 0.6, 0.6)
		--titletext:SetAllPoints(titlebar)
		titletext:SetPoint("TOPLEFT", titlebar, "TOPLEFT", 26, 0)
		titletext:SetPoint("BOTTOMRIGHT", titlebar)
		
		titletext:SetHeight(28)
		titletext:SetText("Death Note")
		titletext:SetJustifyH("LEFT")
		titletext:SetJustifyV("MIDDLE")
		
		-- close button
		local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
		close:SetPoint("TOPRIGHT", 0, 0)
		close:SetFrameLevel(3)
		close:SetScript("OnClick", function() frame:Hide() end)
		
		-- resizer
		local sizer_se = CreateFrame("Frame", nil, frame)
		sizer_se:SetPoint("BOTTOMRIGHT", -3, 3)
		sizer_se:SetWidth(16)
		sizer_se:SetHeight(16)
		sizer_se:SetScript("OnMouseDown", function()
			-- DeathNote.logframe.content:Hide()
			
			frame:SetMinResize(self.name_list_border:GetWidth() + 100, 200)
			frame:SetMaxResize(2000, 2000)
			
			frame:StartSizing() 
		end)
		sizer_se:SetScript("OnMouseUp", function()
			-- DeathNote.logframe.content:Show()
			frame:StopMovingOrSizing()
		end)

		local sizer_se_tex = frame:CreateTexture(nil, "BORDER")
		sizer_se_tex:SetTexture([[Interface\AddOns\DeathNote\Textures\resize.tga]])
		sizer_se_tex:SetAllPoints(sizer_se)
		
		-- filters
		local filters = CreateFrame("Frame", nil, frame)
		filters:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -34)
		filters:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -10, -63)
		filters:SetBackdrop(PaneBackdrop)
		filters:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
		filters:SetBackdropBorderColor(0.4, 0.4, 0.4)
		
		local filters_label = filters:CreateFontString(nil, "OVERLAY")
		filters_label:SetPoint("TOPLEFT", 12, -8)
		filters_label:SetFontObject(GameFontNormal)
		filters_label:SetText("|T" .. [[Interface\AddOns\DeathNote\Textures\tri-closed.tga]] .. ":12|tFilters")
		
		-- name list
		local name_list_border = CreateFrame("Frame", nil, frame)
		--name_list_border:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -100)
		name_list_border:SetPoint("TOPLEFT", filters, "BOTTOMLEFT", 0, 0)
		name_list_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 220, 10)
		
		name_list_border:SetBackdrop(PaneBackdrop)
		name_list_border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
		name_list_border:SetBackdropBorderColor(0.4, 0.4, 0.4)
		name_list_border:SetResizable(true)
		name_list_border:SetMinResize(50, 50)
		name_list_border:SetMaxResize(2000, 2000)
		
		local name_list = CreateFrame("ScrollFrame", nil, name_list_border)
		name_list:SetPoint("TOPLEFT", 8, -8)
		name_list:SetPoint("BOTTOMRIGHT", -8, 8)
		name_list:EnableMouseWheel(true)
		
		-- name list scrollbar
		local name_scroll = CreateFrame("Slider", nil, name_list, "UIPanelScrollBarTemplate")
		name_scroll:SetPoint("BOTTOMRIGHT", 0, 16)
		name_scroll:SetPoint("TOPRIGHT", 0, -16)
		name_scroll:SetMinMaxValues(0, 1000)
		name_scroll:SetValueStep(1)
		name_scroll:SetValue(0)
		name_scroll:SetWidth(16)
		name_scroll:Show()
		
		local name_scrollbg = name_scroll:CreateTexture(nil, "BACKGROUND")
		name_scrollbg:SetAllPoints()
		name_scrollbg:SetTexture(0, 0, 0, 1)

		local name_content = CreateFrame("Frame", nil, name_list)
		name_content:SetPoint("TOPLEFT")
		name_content:SetPoint("TOPRIGHT")		
		name_list:SetScrollChild(name_content)
		
		name_list:SetScript("OnMouseWheel", function(frame, value)
			local l, h = name_scroll:GetMinMaxValues()
			name_scroll:SetValue(min(max(name_scroll:GetValue() - value*45, l), h))
		end)
		
		name_scroll:SetScript("OnValueChanged", function(frame, value)
			name_content:SetPoint("TOPLEFT", 0, value)
			name_content:SetPoint("TOPRIGHT", -16, value)
		end)
		
		self.name_list_border = name_list_border
		self.name_list = name_list
		self.name_content = name_content
		self.name_scroll = name_scroll
		self.name_items = {}
		
		name_list:SetScript("OnSizeChanged", function() self:NameList_SizeChanged() end)
		
		-- dragger
		local dragger = CreateFrame("Frame", nil, name_list_border)
		dragger:SetWidth(8)
		dragger:SetPoint("TOP", name_list_border, "TOPRIGHT")
		dragger:SetPoint("BOTTOM", name_list_border, "BOTTOMRIGHT")
		dragger:SetBackdrop(DraggerBackdrop)
		dragger:SetBackdropColor(1, 1, 1, 0)
		dragger:EnableMouse(true)

		local function Dragger_OnLeave(frame)
			frame:SetBackdropColor(1, 1, 1, 0)
		end

		local function Dragger_OnEnter(frame)
			frame:SetBackdropColor(1, 1, 1, 0.8)
		end

		local function Dragger_OnMouseDown(frame)
			name_list_border:StartSizing("RIGHT")
		end

		local function Dragger_OnMouseUp()
			name_list_border:StopMovingOrSizing()
			name_list_border:SetUserPlaced(false)
			
			local width = name_list_border:GetWidth()
			name_list_border:ClearAllPoints()
			name_list_border:SetPoint("TOPLEFT", filters, "BOTTOMLEFT", 0, 0)
			name_list_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", width + 10, 10)
		end

		dragger:SetScript("OnEnter", Dragger_OnEnter)
		dragger:SetScript("OnLeave", Dragger_OnLeave)
		dragger:SetScript("OnMouseDown", Dragger_OnMouseDown)
		dragger:SetScript("OnMouseUp", Dragger_OnMouseUp)

		-- logframe
		local logframe = self:CreateListBox(frame)
		logframe.frame:SetPoint("TOPLEFT", name_list_border, "TOPRIGHT")
		logframe.frame:SetPoint("BOTTOM", name_list_border, "BOTTOM")
		logframe.frame:SetPoint("RIGHT", frame, "RIGHT", -10, 0	)
		logframe.frame:SetWidth(450)
		
		self.logframe = logframe
		
		logframe:AddColumn("Time", "RIGHT", 60)
		logframe:AddColumn("HP", "RIGHT", 90)
		logframe:AddColumn("Amount", "RIGHT", 60)
		logframe:AddColumn("Spell", "LEFT", 100)
		logframe:AddColumn("Source", "LEFT")
		
		logframe:SetMouseCallbacks(
			function(button, line, column, userdata)
				if IsModifiedClick("CHATLINK") then
					if column == 1 then -- Time
						ChatEdit_InsertLink(self:FormatChatTimestamp(userdata))
					elseif column == 2 then -- HP
						ChatEdit_InsertLink(self:FormatChatHealth(userdata))
					elseif column == 3 then -- Amount
						ChatEdit_InsertLink(self:FormatChatAmount(userdata))
					elseif column == 4 then -- Spell
						ChatEdit_InsertLink(self:FormatChatSpell(userdata))
					elseif column == 5 then -- Source
						ChatEdit_InsertLink(self:FormatChatSource(userdata))
					end
				elseif button == "LeftButton" then
					if column == 1 then
						self:CycleTimestampDisplay()
					elseif column == 2 then
						self:CycleHealthDisplay()
					elseif column == 3 then
					elseif column == 4 then
					elseif column == 5 then
					end
					
					self:RefreshDeath()
				elseif button == "RightButton" then
					-- menu
					self.dropdown_line = line
					self:ShowDropDownMenu()
				end
			end,
			function(column, userdata)
				local have_tip = false
				GameTooltip:SetOwner(logframe.frame, "ANCHOR_NONE")
				GameTooltip:SetPoint("BOTTOMLEFT", logframe.frame, "BOTTOMRIGHT")

				if column == 1 then -- Time
					have_tip = self:FormatTooltipTimestamp(userdata)
				elseif column == 2 then -- HP
					have_tip = self:FormatTooltipHealth(userdata)
				elseif column == 3 then -- Amount
					have_tip = self:FormatTooltipAmount(userdata)
				elseif column == 4 then -- Spell
					have_tip = self:FormatTooltipSpell(userdata)
				elseif column == 5 then -- Source
					have_tip = self:FormatTooltipSource(userdata)
				end				
				
				if have_tip then
					GameTooltip:Show()
				end
			end,
			function(column, userdata)
				GameTooltip:Hide()
			end)

			-- hide on escape
			local org_CloseSpecialWindows = CloseSpecialWindows
			CloseSpecialWindows = function()
				if not org_CloseSpecialWindows() then
					local found = frame:IsShown() and 1
					frame:Hide()
					return found
				end
			end
		
		self.frame = frame
	end

	self.frame:Show()
	self:UpdateNameList()
end

function DeathNote:ShowUnit(name)
	self:Show()
	
	for i = 1, #self.name_items do
		if self.name_items[i]:IsShown() then
			local userdata = self.name_items[i].userdata
			if userdata[3] == name then
				self.name_scroll:SetValue((i - 1) * 18)
				-- self:ShowDeath(userdata)
				self.name_items[i]:Click()
				return
			end
		end
	end
end

function DeathNote.UnitPopupClick()
	DeathNote:ShowUnit(UnitName(UIDROPDOWNMENU_INIT_MENU.unit))
end

function DeathNote:UnitPopup_ShowMenu(dropdownMenu, which, unit, name, userData, ...)
	local button
	for i=1, UIDROPDOWNMENU_MAXBUTTONS do
		button = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL.."Button"..i];
		if button.value == "SHOW_DEATH_NOTE" then
		    button.func = DeathNote.UnitPopupClick
		end
	end
end

function DeathNote.LogFrameDropDownInitialize(self, level)
	local info = {}
	
	if not level then return end

	if level == 1 then
		info.text = "Report from this line"
		info.hasArrow = 1
		info.value = "REPORT"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
	elseif level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "REPORT" then
			info.text = "Say"
			info.func = function() DeathNote:SendReport("SAY") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = "Party"
			info.func = function() DeathNote:SendReport("PARTY") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = "Raid"
			info.func = function() DeathNote:SendReport("RAID") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = "Guild"
			info.func = function() DeathNote:SendReport("GUILD") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = "Officer"
			info.func = function() DeathNote:SendReport("OFFICER") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = "Whisper target"
			info.func = function() DeathNote:SendReport("WHISPER") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end
	end

end

function DeathNote:ShowDropDownMenu(line)
	if not self.dropdownframe then
		self.dropdownframe = CreateFrame("Frame", nil, nil, "UIDropDownMenuTemplate")		
		self.dropdownframe.displayMode = "MENU"
		self.dropdownframe.initialize = self.LogFrameDropDownInitialize				
	end
	
	ToggleDropDownMenu(1, nil, self.dropdownframe, "cursor")
end

-- NameList stuff
function DeathNote:NameList_SizeChanged()
	local content_height = self.name_content:GetHeight()
	local height = self.name_list:GetHeight()
		
	if height >= content_height then
		self.name_content:SetPoint("TOPRIGHT")
		self.name_scroll:SetMinMaxValues(0, 0)
		self.name_scroll:Hide()
	else	
		self.name_content:SetPoint("TOPRIGHT", -16, 0)
		self.name_scroll:SetMinMaxValues(0, content_height - height)
		self.name_scroll:Show()
	end
end

local function NameList_OnClick(frame, button)
	if button == "LeftButton" then
		DeathNote:ShowDeath(frame.userdata)

		for i = 1, #DeathNote.name_items do
			DeathNote.name_items[i]:UnlockHighlight() 
		end

		frame:LockHighlight()
	elseif button == "RightButton" then
		DeathNote:CycleNameListDisplay()
		DeathNote:UpdateNameList()
	end
end

local GetSortedDeathList = {}

function SortDeathsByNameFunc(a, b)
	return a[3] > b[3] or (a[3] == b[3] and a[1] < b[1])
end

GetSortedDeathList[1] = function()
	-- by name
	local deaths = {}
	for _, v in ipairs(DeathNoteData.deaths) do
		table.insert(deaths, v)
	end
	
	table.sort(deaths, SortDeathsByNameFunc)
	
	return deaths
end

GetSortedDeathList[2] = function()
	-- by time
	return DeathNoteData.deaths
end

function DeathNote:CycleNameListDisplay()
	self.settings.display.namelist = self.settings.display.namelist % #GetSortedDeathList + 1
end

function DeathNote:UpdateNameList()
	if not self.frame or not self.frame:IsShown() then
		return
	end
	
	for i = 1, #self.name_items do
		self.name_items[i].userdata = nil
		self.name_items[i]:Hide()
	end
	
	local deaths = GetSortedDeathList[self.settings.display.namelist]()

	local count = #deaths
	for i = 1, count do
		local v = deaths[count - i + 1]
		
		if not self.name_items[i] then
			local button = CreateFrame("Button", "DeathNoteNameListButton" .. i, self.name_content, "OptionsListButtonTemplate")
			
			button:SetNormalFontObject(GameFontNormal)
			button:SetHighlightFontObject(GameFontHighlight)

			button:SetScript("OnClick", NameList_OnClick)
			
			button:SetPoint("TOPLEFT", 0, -18 * (i - 1))
			button:SetPoint("RIGHT")
			
			button:SetScript("OnDoubleClick", nil)
			button:SetScript("OnEnter", nil) -- ttip
			button:SetScript("OnLeave", nil)
			
			self.name_items[i] = button
		end
		
		local btn = self.name_items[i]
		
		btn.userdata = v
		btn:GetFontString():SetText(self:FormatNameListEntry(v))
		if self.current_death == v then
			btn:LockHighlight()
		else
			btn:UnlockHighlight()
		end
				
		btn:Show()
	end

	self.name_content:SetHeight(18 * count)
	self:NameList_SizeChanged()
end

------------------------------------------------------------------------------
-- ListBox
------------------------------------------------------------------------------
local function ListBox_Column_Dragger_OnLeave(frame)
	frame:SetBackdropColor(1, 1, 1, 0.8)
end

local function ListBox_Column_Dragger_OnEnter(frame)
	frame:SetBackdropColor(1, 1, 1, 1)
end

local function ListBox_Column_Dragger_OnMouseDown(frame)
	local lastcol = frame.obj.columns[#frame.obj.columns]
	
	frame.prev:SetMaxResize(frame.prev:GetWidth() + lastcol:GetWidth(), 1)

	frame.prev:StartSizing("RIGHT")
end

local function ListBox_PlaceColumn(self, column, prev, width)	
	column:ClearAllPoints()
	
	if not prev then
		column:SetPoint("TOPLEFT", self.iframe, "TOPLEFT", 8, -8)
		column:SetPoint("BOTTOMRIGHT", self.iframe, "BOTTOMLEFT", width + 8, 8)
	else
		column:SetPoint("TOPLEFT", prev, "TOPRIGHT")
		if width then
			column:SetPoint("RIGHT", prev, "RIGHT", width, 0)
		else
			column:SetPoint("RIGHT", self.content, "RIGHT", 0, 0)
		end
	end
	
	column:SetPoint("BOTTOM", self.scrollframe, "BOTTOM")
end

local function ListBox_Column_Dragger_OnMouseUp(frame)
	local prev = frame.prev
	local prevprev = frame.prevprev
	
	prev:StopMovingOrSizing()
	prev:SetUserPlaced(false)
	
	ListBox_PlaceColumn(frame.obj, prev, prevprev, prev:GetWidth())
end

local function ListBox_AddColumn(self, label, align, width)
	local column = CreateFrame("Frame", nil, self.iframe)
	column.align = align
	column:SetResizable(true)
	column:SetMinResize(10, 1)
	
	local prev = self.columns[#self.columns]

	ListBox_PlaceColumn(self, column, prev, width)

	local fs = column:CreateFontString(nil, "OVERLAY")
	fs:SetFontObject(GameFontNormal)
	fs:SetPoint("TOPLEFT", column, "TOPLEFT", 3, 0)
	fs:SetPoint("BOTTOMRIGHT", column, "TOPRIGHT", -3, -18)
	fs:SetText(label)
	
	if prev then
		local dragger = CreateFrame("Frame", nil, self.iframe)
		dragger:SetWidth(2)
		dragger:SetPoint("TOP", prev, "TOPRIGHT")
		dragger:SetPoint("BOTTOM", prev, "BOTTOM")

		dragger.background = dragger:CreateTexture(nil, "OVERLAY")
		dragger.background:SetAllPoints()
		dragger.background:SetTexture(0.7, 0.7, 0.7, 0.8)
		
		dragger.obj = self
		dragger.prev = prev
		dragger.prevprev = self.columns[#self.columns - 1]

		dragger:EnableMouse(true)		
		dragger:SetScript("OnMouseDown", ListBox_Column_Dragger_OnMouseDown)
		dragger:SetScript("OnMouseUp", ListBox_Column_Dragger_OnMouseUp)
		dragger:SetScript("OnEnter", ListBox_Column_Dragger_OnEnter)
		dragger:SetScript("OnLeave", ListBox_Column_Dragger_OnLeave)
	end
	
	table.insert(self.columns, column)
end

function ListBox_SetMouseCallbacks(self, onmouseup, onenter, onleave)
	self.column_onmouseup = onmouseup
	self.column_onenter = onenter
	self.column_onleave = onleave
end

function ListBox_Column_OnMouseUp(frame, button)
	if frame.line.obj.column_onmouseup then
		frame.line.obj.column_onmouseup(button, frame.nline, frame.column, frame.line.userdata)
	end
end

function ListBox_Column_OnEnter(frame)
	frame.line.hili:Show()
	
	if frame.line.obj.column_onenter then
		frame.line.obj.column_onenter(frame.column, frame.line.userdata)
	end
end

function ListBox_Column_OnLeave(frame)
	frame.line.hili:Hide()
	
	if frame.line.obj.column_onleave then
		frame.line.obj.column_onleave(frame.column, frame.line.userdata)
	end
end

local function ListBox_CreateLine(self)
	local nline = #self.lines + 1
	local line = self.line_cache[nline]
	
	if not line then
		line = CreateFrame("Frame", nil, self.content)
		line:Hide()
		line:SetHeight(12)
		line.obj = self
		
		local hili = line:CreateTexture(nil, "OVERLAY")
		hili:SetAllPoints()
		hili:SetBlendMode("ADD")
		hili:SetTexture(0, 0.2, 0.8, 0.5)
		hili:Hide()
		line.hili = hili
		
		line.columns = {}
		for i, c in ipairs(self.columns) do
			local f = CreateFrame("Frame", nil, line)
			f.nline = nline
			f.line = line
			f.column = i
			f:SetPoint("TOP", line, "TOP")
			f:SetPoint("BOTTOM", line, "BOTTOM")
			f:SetPoint("LEFT", c, "LEFT", 3, 0)
			f:SetPoint("RIGHT", c, "RIGHT", -3, 0)
			f:SetScript("OnMouseUp", ListBox_Column_OnMouseUp)
			f:SetScript("OnEnter", ListBox_Column_OnEnter)
			f:SetScript("OnLeave", ListBox_Column_OnLeave)
			
			line.columns[i] = f
		end
		
		self.line_cache[nline] = line
	end

	table.insert(self.lines, line)
	
	return line
end

local function ListBox_AddLine(self, values, userdata)
	local line = self:CreateLine()
	
	line.userdata = userdata

	self:UpdateLine(#self.lines, values)
end

function ListBox_UpdateComplete(self)
	for nline = #self.lines, 1, -1 do
		local line = self.lines[nline]
		local prev = self.lines[nline + 1]

		if not prev then
			line:SetPoint("TOPLEFT", self.content, "TOPLEFT", 0, -4)
			line:SetPoint("RIGHT", self.content, "RIGHT", 0, 0)
		else
			line:SetPoint("TOPLEFT", prev, "BOTTOMLEFT")
			line:SetPoint("RIGHT", prev, "RIGHT")
		end
	end

	ListBox_OnSizeChanged(self.frame)

	for nline = 1, #self.lines do
		self.lines[nline]:Show()
	end
end

local function ListBox_ClearAllLines(self)
	for i = 1, #self.lines do
		self.lines[i].userdata = nil
		self.lines[i]:Hide()
	end
	
	wipe(self.lines)
end

function ListBox_OnSizeChanged(frame, width, height)
	local self = frame.obj
	
	-- Update Scrollbar	
	local height = self.scrollframe:GetHeight()
	local content_height = #self.lines * 12 + 8
	
	self.content:SetHeight(content_height)
	
	if height >= content_height then
		self.content:SetPoint("TOPRIGHT")
		self.scrollbar:SetMinMaxValues(0, 0)
		self.scrollbar:Hide()
	else	
		self.content:SetPoint("TOPRIGHT", -20, 0)
		self.scrollbar:SetMinMaxValues(0, content_height - height)
		self.scrollbar:Show()
	end
end

local function ListBox_ScrollFrame_OnMouseWheel(frame, value)
	local self = frame.obj
	
	local l, h = self.scrollbar:GetMinMaxValues()
	self.scrollbar:SetValue(min(max(self.scrollbar:GetValue() - value*45, l), h))
end
	
local function ListBox_ScrollBar_OnValueChanged(frame, value)
	local self = frame.obj

	self.content:SetPoint("TOPLEFT", 0, value)
	self.content:SetPoint("TOPRIGHT", -20, value)
end

local function ListBox_ScrollToBottom(self)
	if self.scrollbar:IsShown() then
		self.scrollbar:SetValue(select(2, self.scrollbar:GetMinMaxValues()))
	end
end

local function ListBox_GetLineCount(self)
	return #self.lines
end

local function ListBox_GetLineUserdata(self, line)
	return self.lines[line].userdata
end

local function ListBox_Line_Column_OnSizeChanged(frame)
	if frame.barframe and frame.barframe:IsShown() then
		local width = (frame:GetWidth() - 6) * frame.value
		if width == 0 then
			frame.barframe:Hide()
		else
			frame.barframe:SetWidth(width)
		end
	end
end

local function ListBox_UpdateLine(self, nline, values)
	local line = self.lines[nline]
	
	for i, c in ipairs(self.columns) do
		if type(values[i]) == "table" then
			if line.columns[i].fs then
				line.columns[i].fs:Hide()
			end
			
			if not line.columns[i].barframe then
				line.columns[i].barframe = CreateFrame("Frame", nil, line.columns[i])
				line.columns[i].barframe:SetPoint("TOPLEFT", line.columns[i], "TOPLEFT", 3, -3)
				line.columns[i].barframe:SetPoint("BOTTOM", line.columns[i], "BOTTOM", 0, 3)
				
				line.columns[i].bartex = line.columns[i].barframe:CreateTexture(nil, "OVERLAY")
				line.columns[i].bartex:SetAllPoints()
				line.columns[i].bartex:SetTexture(1, 0, 0)
			end
			
			line.columns[i].barframe:Show()
			line.columns[i].value = values[i][2]
			ListBox_Line_Column_OnSizeChanged(line.columns[i])
			line.columns[i]:SetScript("OnSizeChanged", ListBox_Line_Column_OnSizeChanged)
		else
			if line.columns[i].barframe then
				line.columns[i]:SetScript("OnSizeChanged", nil)
				line.columns[i].barframe:Hide()
			end
			
			if not line.columns[i].fs then
				local fs = line.columns[i]:CreateFontString(nil, "OVERLAY")
				fs:SetAllPoints(line.columns[i])
				fs:SetFontObject(GameFontNormalSmall)
				fs:SetJustifyH(c.align)
				line.columns[i].fs = fs
			end
			
			line.columns[i].fs:Show()
			line.columns[i].fs:SetText(values[i])
		end
	end
end
	
function DeathNote:CreateListBox(parent)
	local frame = CreateFrame("ScrollFrame", nil, parent)	
	
	local iframe = CreateFrame("Frame", nil, frame)
	iframe:SetBackdrop(PaneBackdrop)
	iframe:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
	iframe:SetBackdropBorderColor(0.4, 0.4, 0.4)
	
	frame:SetScrollChild(iframe)
	iframe:SetAllPoints()
	
	local scrollframe = CreateFrame("ScrollFrame", nil, iframe)
	scrollframe:SetPoint("TOPLEFT", 8, -32)
	scrollframe:SetPoint("BOTTOMRIGHT", -8, 8)
	scrollframe:EnableMouseWheel(true)
	scrollframe:SetScript("OnMouseWheel", ListBox_ScrollFrame_OnMouseWheel)
		
	local scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate")
	scrollbar:SetPoint("BOTTOMRIGHT",  0, 16)
	scrollbar:SetPoint("TOPRIGHT", 0, -16)
	scrollbar:SetMinMaxValues(0, 0)
	scrollbar:SetValueStep(1)
	scrollbar:SetValue(0)
	scrollbar:SetWidth(16)
	scrollbar:SetScript("OnValueChanged", ListBox_ScrollBar_OnValueChanged)
	scrollbar:Hide()
	
	local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND")
	scrollbg:SetAllPoints()
	scrollbg:SetTexture(0, 0, 0, 1)		

	local content = CreateFrame("Frame", nil, scrollframe)
	scrollframe:SetScrollChild(content)
	content:SetPoint("TOPLEFT")
	content:SetPoint("TOPRIGHT", -16, 0)
	content:SetHeight(1000)
	
	local headersep = CreateFrame("Frame", nil, iframe)
	headersep:SetHeight(16)
	headersep:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -22)
	headersep:SetPoint("RIGHT")
	headersep:SetBackdrop(DraggerBackdrop)
	headersep:SetBackdropColor(1, 1, 1, 1)

	--local pin = CreateFrame("Button", nil, frame)
	--pin:SetNormalTexture([[Interface\AddOns\DeathNote\Textures\pin.tga]]) 
	--pin:SetPushedTexture(texture)
	--pin:SetWidth(16 * UIParent:GetScale())
	--pin:SetHeight(16 * UIParent:GetScale())
	--pin:SetPoint("TOPRIGHT", -8, -8)
		
	--local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	--close:SetPoint("TOPRIGHT", 0, 0)
	
	frame:SetScript("OnSizeChanged", ListBox_OnSizeChanged)
	
	local listbox = {
		AddColumn = ListBox_AddColumn,
		AddLine = ListBox_AddLine,
		ClearAllLines = ListBox_ClearAllLines,
		SetMouseCallbacks = ListBox_SetMouseCallbacks,
		CreateLine = ListBox_CreateLine,
		ScrollToBottom = ListBox_ScrollToBottom,
		GetLineCount = ListBox_GetLineCount,
		GetLineUserdata = ListBox_GetLineUserdata,
		UpdateLine = ListBox_UpdateLine,
		UpdateComplete = ListBox_UpdateComplete,

		frame = frame,
		iframe = iframe,
		content = content,
		scrollbar = scrollbar,
		scrollframe = scrollframe,

		columns = {},
		lines = {},
		line_cache = {},
	}
	
	frame.obj = listbox
	scrollbar.obj = listbox
	scrollframe.obj = listbox
	
	return listbox
end

---------------------------------------------------------------

function DeathNote:ShowDeath(death)
	debugprofilestart()

	self.logframe:ClearAllLines()

	self.current_death = death
	
	local guid = death[2]
	local timestamp = floor(death[1])
	local t = timestamp
	local death_found = 0
	
	while t >= (timestamp - self.settings.death_time) and death_found <= 1 do
		local l = DeathNoteData.log[t]
		if l then
			for i = #l, 1, -1 do
				local entry = l[i]
				if entry[8] == guid and entry[3] <= death[1] then
					if entry[4] == "UNIT_DIED" then
						death_found = death_found + 1
						if death_found > 1 then
							break
						end
					end
					
					self:AddEntry(entry)
				end
			end
		end
		t = t - 1
	end
	
	self.logframe:UpdateComplete()
	self.logframe:ScrollToBottom()
	
	print(string.format("DeathNote: Death shown in %.02f ms", debugprofilestop()))
end

function DeathNote:AddEntry(entry)
	local line = self:FormatEntry(entry)
	
	if line then
		self.logframe:AddLine(line, entry)
	end
end

function DeathNote:RefreshDeath()
	local count = self.logframe:GetLineCount()
	
	for i = 1, count do
		self.logframe:UpdateLine(i, self:FormatEntry(self.logframe:GetLineUserdata(i)))
	end
end
