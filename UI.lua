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

local ColumnDraggerBackdrop  = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = nil,
	tile = true, tileSize = 16, edgeSize = 0,
	insets = { left = 3, right = 3, top = 0, bottom = 0 }
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
		titlebar:SetPoint("TOPLEFT", 3, -2)
		titlebar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -3, -28)
		
		local titlebarframe = CreateFrame("Frame", nil, frame)
		titlebarframe:SetAllPoints(titlebar)
		titlebarframe:EnableMouse()
		titlebarframe:SetScript("OnMouseDown", function() frame:StartMoving() end)
		titlebarframe:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)		

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
		sizer_se:SetScript("OnMouseDown", function() frame:StartSizing() end)
		sizer_se:SetScript("OnMouseUp", function() frame:StopMovingOrSizing() end)		

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
		name_list_border:SetMinResize(20, 1)
		name_list_border:SetMaxResize(400, 1600)
		
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
		
		self.name_list = name_list
		self.name_content = name_content
		self.name_scroll = name_scroll
		self.name_items = {}
		
		name_list:SetScript("OnSizeChanged", function() self:NameListSizeChanged() end)
		
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
			function(button, column, userdata)
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
				else
					if column == 1 then
						self:CycleTimestampDisplay()
					elseif column == 2 then
						self:CycleHealthDisplay()
					elseif column == 3 then
					elseif column == 4 then
					elseif column == 5 then
					end
					
					self:RefreshDeath()
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
		
		self.frame = frame
	end

	self.frame:Show()
	self:UpdateNameList()
end

function DeathNote:NameListSizeChanged()
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

function DeathNote:UpdateNameList()
	if not self.frame or not self.frame:IsShown() then
		return
	end
	
	for i = 1, #self.name_items do
		self.name_items[i].userdata = nil
		self.name_items[i]:Hide()
	end
	
	local count = #DeathNoteData.deaths
	for i = 1, count do
		local v = DeathNoteData.deaths[count - i + 1]
		
		if not self.name_items[i] then
			local button = CreateFrame("Button", "DeathNoteNameListButton" .. i, self.name_content, "OptionsListButtonTemplate")
			
			button:SetNormalFontObject(GameFontNormal)
			button:SetHighlightFontObject(GameFontHighlight)

			button:SetScript("OnClick", function(frame)
				self:ShowDeath(frame.userdata)

				for i = 1, #self.name_items do
					self.name_items[i]:UnlockHighlight() 
				end

				frame:LockHighlight()
			end)
			
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
		btn:Show()
	end

	self.name_content:SetHeight(18 * count)
	self:NameListSizeChanged()
end

---------- ListBox
local function ListBox_Dragger_OnLeave(frame)
	frame:SetBackdropColor(1, 1, 1, 0.8)
end

local function ListBox_Dragger_OnEnter(frame)
	frame:SetBackdropColor(1, 1, 1, 1)
end

--[[
local function ListBox_PlaceColumn(self, n, width)
	local column = self.columns[n]
	
	if n == 1 then
		column:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 8, -8)
		column:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMLEFT", width, 8)
	end
end
]]

local function ListBox_AddColumn(self, label, align, width)
	local column = CreateFrame("Frame", nil, self.frame)
	column.align = align
	column:SetResizable(true)
	column:SetMinResize(10, 1)
	column:SetMaxResize(500, 1)
	
	local prev = self.columns[#self.columns]	

	if not prev then
		column:SetPoint("TOPLEFT", self.frame, "TOPLEFT", 8, -8)
		column:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMLEFT", width + 8, 8)
	else
		column:SetPoint("TOPLEFT", prev, "TOPRIGHT")
		if width then
			column:SetPoint("RIGHT", prev, "RIGHT", width, 0)
		else
			column:SetPoint("RIGHT", self.content, "RIGHT", 0, 0)
		end
	end
	column:SetPoint("BOTTOM", self.scrollframe, "BOTTOM")

	local fs = column:CreateFontString(nil, "OVERLAY")
	fs:SetFontObject(GameFontNormal)
	fs:SetPoint("TOPLEFT", column, "TOPLEFT", 3, 0)
	fs:SetPoint("BOTTOMRIGHT", column, "TOPRIGHT", -3, -18)
	fs:SetText(label)
	
	if prev then
		local prevprev = self.columns[#self.columns - 1]
		
		local dragger = CreateFrame("Frame", nil, self.frame)
		dragger:SetWidth(8)
		dragger:SetPoint("TOP", prev, "TOPRIGHT")
		dragger:SetPoint("BOTTOM", prev, "BOTTOMRIGHT")
		dragger:SetBackdrop(ColumnDraggerBackdrop)
		dragger:SetBackdropColor(1, 1, 1, 0.8)
		dragger:EnableMouse(true)

		local function ListBox_Dragger_OnMouseDown(frame)
			prev:StartSizing("RIGHT")
		end

		local function ListBox_Dragger_OnMouseUp()
			prev:StopMovingOrSizing()
			prev:SetUserPlaced(false)
			
			local width = prev:GetWidth()
			prev:ClearAllPoints()
			if not prevprev then
				prev:SetPoint("TOPLEFT", prev:GetParent(), "TOPLEFT", 8, -8)
				prev:SetPoint("BOTTOMRIGHT", prev:GetParent(), "BOTTOMLEFT", width + 8, 8)
			else
				prev:SetPoint("TOPLEFT", prevprev, "TOPRIGHT")
				if width then
					prev:SetPoint("BOTTOMRIGHT", prevprev, "BOTTOMRIGHT", width, 0)		
				else
					prev:SetPoint("BOTTOMRIGHT", self.scrollframe, "BOTTOMRIGHT", 0, 0)
				end
			end
		end
		
		dragger:SetScript("OnMouseDown", ListBox_Dragger_OnMouseDown)
		dragger:SetScript("OnMouseUp", ListBox_Dragger_OnMouseUp)
		dragger:SetScript("OnEnter", ListBox_Dragger_OnEnter)
		dragger:SetScript("OnLeave", ListBox_Dragger_OnLeave)
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
		frame.line.obj.column_onmouseup(button, frame.column, frame.line.userdata)
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
		line:SetHeight(12)
		local prev = self.lines[#self.lines]
		if not prev then
			line:SetPoint("TOPLEFT", self.content, "TOPLEFT", 0, -4)
			line:SetPoint("RIGHT", self.content, "RIGHT", 0, 0)
		else
			line:SetPoint("TOPLEFT", prev, "BOTTOMLEFT")
			line:SetPoint("RIGHT", prev, "RIGHT")		
		end	
		line.obj = self
		
		local hili = line:CreateTexture(nil, "OVERLAY")
		hili:SetAllPoints()
		hili:SetBlendMode("ADD")
		hili:SetTexture(0, 0.2, 0.8, 0.5)
		hili:Hide()
		line.hili = hili
		
		line.columns = { }

		for i, c in ipairs(self.columns) do
			local f = CreateFrame("Frame", nil, line)
			f.line = line
			f.column = i
			f:SetPoint("TOP", line, "TOP")
			f:SetPoint("BOTTOM", line, "BOTTOM")
			f:SetPoint("LEFT", c, "LEFT", 3, 0)
			f:SetPoint("RIGHT", c, "RIGHT", -3, 0)
			f:SetScript("OnMouseUp", ListBox_Column_OnMouseUp)
			f:SetScript("OnEnter", ListBox_Column_OnEnter)
			f:SetScript("OnLeave", ListBox_Column_OnLeave)
			
			local fs = line:CreateFontString(nil, "OVERLAY")
			fs:SetAllPoints(f)
			fs:SetFontObject(GameFontNormalSmall)
			fs:SetJustifyH(c.align)
			f.fs = fs
			
			line.columns[i] = f
		end
		
		self.line_cache[nline] = line
	else
		line:Show()
	end
	
	table.insert(self.lines, line)
	
	return line
end

local function ListBox_AddLine(self, values, userdata)
	local line = self:CreateLine()
	
	line.userdata = userdata

	self:UpdateLine(#self.lines, values)
	
	ListBox_OnSizeChanged(self.frame)	
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
	local self = frame:GetParent().obj
	
	local l, h = self.scrollbar:GetMinMaxValues()
	self.scrollbar:SetValue(min(max(self.scrollbar:GetValue() - value*45, l), h))
end
	
local function ListBox_ScrollBar_OnValueChanged(frame, value)
	local self = frame:GetParent():GetParent().obj

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
	local width = (frame:GetWidth() - 6) * frame.value
	if width == 0 then
		frame.barframe:Hide()
	else
		frame.barframe:SetWidth(width)
	end
end

local function ListBox_UpdateLine(self, nline, values)
	local line = self.lines[nline]
	
	for i, c in ipairs(self.columns) do
		if type(values[i]) == "table" then
			line.columns[i].fs:Hide()
			
			if not line.columns[i].barframe then
				line.columns[i].barframe = CreateFrame("Frame", nil, line.columns[i])
				line.columns[i].barframe:SetPoint("TOPLEFT", line.columns[i], "TOPLEFT", 3, -3)
				line.columns[i].barframe:SetPoint("BOTTOM", line.columns[i], "BOTTOM", 0, 3)
				
				line.columns[i].bartex = line.columns[i].barframe:CreateTexture(nil, "OVERLAY")
				line.columns[i].bartex:SetAllPoints()
				line.columns[i].bartex:SetTexture(1, 0, 0)
				
				line.columns[i]:SetScript("OnSizeChanged", ListBox_Line_Column_OnSizeChanged)
			else
				line.columns[i].barframe:Show()
			end
			
			line.columns[i].value = values[i][2]
			ListBox_Line_Column_OnSizeChanged(line.columns[i])
		else
			if line.columns[i].barframe then
				line.columns[i].barframe:Hide()
			end
			
			line.columns[i].fs:Show()
			line.columns[i].fs:SetText(values[i])
		end
	end
end
	
function DeathNote:CreateListBox(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
	frame:SetBackdropBorderColor(0.4, 0.4, 0.4)
	frame:SetResizable(true)
	frame:SetMinResize(100, 1)
	frame:SetMaxResize(400, 1600)
	
	local scrollframe = CreateFrame("ScrollFrame", nil, frame)
	-- scrollframe:SetPoint("TOPLEFT", 8, -8)
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
	content:SetPoint("TOPLEFT", 0, 0)
	content:SetPoint("TOPRIGHT", -16, 0)
	content:SetHeight(1000)
	
	local headersep = CreateFrame("Frame", nil, frame)
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

		frame = frame,
		content = content,
		scrollbar = scrollbar,
		scrollframe = scrollframe,

		columns = {},
		lines = {},
		line_cache = {},
	}
	
	frame.obj = listbox
	
	return listbox
end

---------------------------------------------------------------

function DeathNote:ShowDeath(death)
	self.logframe:ClearAllLines()

	self.current_death = death
	
	local guid = death[2]
	local timestamp = floor(death[1])	
	
	for t = timestamp - self.settings.death_time, timestamp, 1 do
		local l = DeathNoteData.log[t]
		if l then
			for i = 1, #l do
				local entry = l[i]
				if entry[8] == guid and entry[3] <= death[1] then
					self:AddEntry(entry)
				end
			end
		end
	end
	
	self.logframe:ScrollToBottom()
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
