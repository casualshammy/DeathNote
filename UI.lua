local L = LibStub("AceLocale-3.0"):GetLocale("DeathNote")
local LibDDE = LibStub("LibDropDownExtension-1.0", true);

local WindowBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local TooltipBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true, tileSize = 16, edgeSize = 16,
	insets = { left = 5, right = 5, top = 5, bottom = 5 }
}

local PaneBackdrop = {
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

local filters_label_open =   "|TInterface\\AddOns\\DeathNote\\Textures\\tri-open.tga:0|t " .. L["Filters"]
local filters_label_closed = "|TInterface\\AddOns\\DeathNote\\Textures\\tri-closed.tga:0|t " .. L["Filters"]
local normal_hilight = { r = 0.5, g = 0.5, b = 0.5, a = 0.4 }
local spell_hilight = { r = 0.25, g = 0.25, b = 0.5, a = 0.4 }
local source_hilight = { r = 0, g = 0, b = 0.6, a = 0.4 }

local tinsert, tremove, string_find, string_format = table.insert, table.remove, string.find, format;

local LocalizedClassList = { };
FillLocalizedClassList(LocalizedClassList);

local function table_contains_value(t, v)
	for _, value in pairs(t) do
		if (value == v) then
			return true;
		end
	end
	return false;
end

local function GUICreateCheckBoxEx(text, func)
	local checkBox = CreateFrame("CheckButton");
	checkBox:SetHeight(20);
	checkBox:SetWidth(20);
	checkBox:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up");
	checkBox:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down");
	checkBox:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight");
	checkBox:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled");
	checkBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	checkBox.textFrame = CreateFrame("frame", nil, checkBox);
	checkBox.textFrame:SetPoint("LEFT", checkBox, "RIGHT", 0, 0);
	checkBox.textFrame:EnableMouse(true);
	checkBox.textFrame:HookScript("OnEnter", function(self, ...) checkBox:LockHighlight(); end);
	checkBox.textFrame:HookScript("OnLeave", function(self, ...) checkBox:UnlockHighlight(); end);
	checkBox.textFrame:Show();
	checkBox.textFrame:HookScript("OnMouseDown", function(self) checkBox:SetButtonState("PUSHED"); end);
	checkBox.textFrame:HookScript("OnMouseUp", function(self) checkBox:SetButtonState("NORMAL"); checkBox:Click(); end);
	checkBox.Text = checkBox.textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	checkBox.Text:SetPoint("LEFT", 0, 0);
	checkBox.SetText = function(self, _text)
		checkBox.Text:SetText(_text);
		checkBox.textFrame:SetWidth(checkBox.Text:GetStringWidth() + checkBox:GetWidth());
		checkBox.textFrame:SetHeight(max(checkBox.Text:GetStringHeight(), checkBox:GetHeight()));
	end;
	local handlersToBeCopied = { "OnEnter", "OnLeave" };
	hooksecurefunc(checkBox, "HookScript", function(self, script, proc) if (table_contains_value(handlersToBeCopied, script)) then checkBox.textFrame:HookScript(script, proc); end end);
	hooksecurefunc(checkBox, "SetScript",  function(self, script, proc) if (table_contains_value(handlersToBeCopied, script)) then checkBox.textFrame:SetScript(script, proc); end end);
	checkBox:SetText(text);
	checkBox:EnableMouse(true);
	checkBox:SetScript("OnClick", func);
	checkBox:Hide();
	return checkBox;
end

local function CreateSearchBox(parentFrame)
	parentFrame.searchLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
	parentFrame.searchLabel:SetPoint("TOPLEFT", parentFrame, "BOTTOMLEFT", 5, -10);
	parentFrame.searchLabel:SetJustifyH("LEFT");
	parentFrame.searchLabel:SetText(L["ui:quick-spell-search"]);
	
	parentFrame.searchBox = CreateFrame("EditBox", nil, parentFrame, "InputBoxTemplate");
	parentFrame.searchBox:SetAutoFocus(false);
	parentFrame.searchBox:SetFontObject(GameFontHighlightSmall);
	parentFrame.searchBox:SetPoint("LEFT", parentFrame.searchLabel, "RIGHT", 10, 0);
	parentFrame.searchBox:SetPoint("RIGHT", parentFrame, "RIGHT", -160, 0);
	parentFrame.searchBox:SetHeight(20);
	parentFrame.searchBox:SetWidth(175);
	parentFrame.searchBox:SetJustifyH("LEFT");
	parentFrame.searchBox:EnableMouse(true);
	parentFrame.searchBox:SetScript("OnEscapePressed", function() parentFrame.searchBox:ClearFocus(); end);
	parentFrame.searchBox:SetScript("OnTextChanged", function(this)
		local text = this:GetText();
		DeathNote.settings.searchbox_text = text;
		DeathNote:RefreshFilters();
		DeathNote:RefreshHighlight();
	end);
	parentFrame.searchBox:HookScript("OnShow", function(this) this:SetText(""); end);
	
	parentFrame.QuickSpellSearchMode = CreateFrame("Frame", "DeathNote:UI:QuickSpellSearchMode", parentFrame.searchBox, "UIDropDownMenuTemplate");
	UIDropDownMenu_SetWidth(parentFrame.QuickSpellSearchMode, 130);
	parentFrame.QuickSpellSearchMode:SetPoint("LEFT", parentFrame.searchBox, "RIGHT", -5, -3);
	local info = {};
	parentFrame.QuickSpellSearchMode.initialize = function()
		wipe(info);
		for _, value in pairs({ L["ui:quick-spell-search:mode:only-found-spells"], L["ui:quick-spell-search:mode:highlight"] }) do
			info.text = value;
			info.value = value;
			info.func = function(self)
				DeathNote.settings.quick_spell_search.only_hl = (self.value == L["ui:quick-spell-search:mode:highlight"]);
				DeathNote:RefreshFilters();
				DeathNote:RefreshHighlight();
				_G[parentFrame.QuickSpellSearchMode:GetName().."Text"]:SetText(self:GetText());
			end
			info.checked = (info.value == (DeathNote.settings.quick_spell_search.only_hl and L["ui:quick-spell-search:mode:highlight"] or L["ui:quick-spell-search:mode:only-found-spells"]));
			UIDropDownMenu_AddButton(info);
		end
	end
	_G[parentFrame.QuickSpellSearchMode:GetName().."Text"]:SetText(DeathNote.settings.quick_spell_search.only_hl and L["ui:quick-spell-search:mode:highlight"] or L["ui:quick-spell-search:mode:only-found-spells"]);
	parentFrame.QuickSpellSearchMode:Show();
end

local function GUICreateButton(parentFrame, text)
		-- After creation we need to set up :SetWidth, :SetHeight, :SetPoint, :SetScript
		local button = CreateFrame("Button", nil, parentFrame);
		button.Background = button:CreateTexture(nil, "BORDER");
		button.Background:SetPoint("TOPLEFT", 1, -1);
		button.Background:SetPoint("BOTTOMRIGHT", -1, 1);
		button.Background:SetColorTexture(0, 0, 0, 1);

		button.Border = button:CreateTexture(nil, "BACKGROUND");
		button.Border:SetPoint("TOPLEFT", 0, 0);
		button.Border:SetPoint("BOTTOMRIGHT", 0, 0);
		button.Border:SetColorTexture(unpack({0.73, 0.26, 0.21, 1}));

		button.Normal = button:CreateTexture(nil, "ARTWORK");
		button.Normal:SetPoint("TOPLEFT", 2, -2);
		button.Normal:SetPoint("BOTTOMRIGHT", -2, 2);
		button.Normal:SetColorTexture(unpack({0.38, 0, 0, 1}));
		button:SetNormalTexture(button.Normal);

		button.Disabled = button:CreateTexture(nil, "OVERLAY");
		button.Disabled:SetPoint("TOPLEFT", 3, -3);
		button.Disabled:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Disabled:SetColorTexture(0.6, 0.6, 0.6, 0.2);
		button:SetDisabledTexture(button.Disabled);

		button.Highlight = button:CreateTexture(nil, "OVERLAY");
		button.Highlight:SetPoint("TOPLEFT", 3, -3);
		button.Highlight:SetPoint("BOTTOMRIGHT", -3, 3);
		button.Highlight:SetColorTexture(0.6, 0.6, 0.6, 0.2);
		button:SetHighlightTexture(button.Highlight);

		button.Text = button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		button.Text:SetPoint("CENTER", 0, 0);
		button.Text:SetJustifyH("CENTER");
		button.Text:SetTextColor(1, 0.82, 0, 1);
		button.Text:SetText(text);

		button:SetScript("OnMouseDown", function(self) self.Text:SetPoint("CENTER", 1, -1) end);
		button:SetScript("OnMouseUp", function(self) self.Text:SetPoint("CENTER", 0, 0) end);
		
		button.SetGray = function(self, gray)
			button.Normal:SetColorTexture(unpack(gray and {0, 0, 0, 1} or {0.38, 0, 0, 1}));
		end
		
		return button;
	end

local selectorEx;
local function GetSelectorEx()
	if (not selectorEx) then
		selectorEx = CreateFrame("Frame", nil, UIParent);
		selectorEx:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
		selectorEx:SetSize(350, 300);
		selectorEx.texture = selectorEx:CreateTexture();
		selectorEx.texture:SetAllPoints(selectorEx);
		selectorEx.texture:SetColorTexture(0, 0, 0, 1);
		
		selectorEx.searchLabel = selectorEx:CreateFontString(nil, "OVERLAY", "GameFontNormal");
		selectorEx.searchLabel:SetPoint("TOPLEFT", 5, -10);
		selectorEx.searchLabel:SetJustifyH("LEFT");
		selectorEx.searchLabel:SetText(L["selector:search"]);
		
		selectorEx.searchBox = CreateFrame("EditBox", nil, selectorEx, "InputBoxTemplate");
		selectorEx.searchBox:SetAutoFocus(false);
		selectorEx.searchBox:SetFontObject(GameFontHighlightSmall);
		selectorEx.searchBox:SetPoint("LEFT", selectorEx.searchLabel, "RIGHT", 10, 0);
		selectorEx.searchBox:SetPoint("RIGHT", selectorEx, "RIGHT", -10, 0);
		selectorEx.searchBox:SetHeight(20);
		selectorEx.searchBox:SetWidth(175);
		selectorEx.searchBox:SetJustifyH("LEFT");
		selectorEx.searchBox:EnableMouse(true);
		selectorEx.searchBox:SetScript("OnEscapePressed", function() selectorEx.searchBox:ClearFocus(); end);
		selectorEx.searchBox:SetScript("OnTextChanged", function(self)
			local text = self:GetText();
			if (text == "") then
				selectorEx.SetList(selectorEx.list);
			else
				local t = { };
				for _, value in pairs(selectorEx.list) do
					if (string_find(value.text:lower(), text:lower())) then
						tinsert(t, value);
					end
				end
				selectorEx.SetList(t, true);
				selectorEx.scrollArea:SetVerticalScroll(0);
			end
		end);
		selectorEx:HookScript("OnHide", function() selectorEx.searchBox:SetText(""); end);
		
		selectorEx.scrollArea = CreateFrame("ScrollFrame", nil, selectorEx, "UIPanelScrollFrameTemplate");
		selectorEx.scrollArea:SetPoint("TOPLEFT", selectorEx, "TOPLEFT", 5, -30);
		selectorEx.scrollArea:SetPoint("BOTTOMRIGHT", selectorEx, "BOTTOMRIGHT", -25, 5);
		selectorEx.scrollArea:Show();
		
		local scrollAreaChildFrame = CreateFrame("Frame", nil, selectorEx.scrollArea);
		selectorEx.scrollArea:SetScrollChild(scrollAreaChildFrame);
		--scrollAreaChildFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 1);
		scrollAreaChildFrame:SetWidth(288);
		scrollAreaChildFrame:SetHeight(288);
		
		selectorEx.buttons = { };
		selectorEx.list = { };
		
		local function GetButton(counter)
			if (selectorEx.buttons[counter] == nil) then
				local button = GUICreateButton(scrollAreaChildFrame, "");
				button.font, button.fontSize, button.fontFlags = button.Text:GetFont();
				button:SetWidth(295);
				button:SetHeight(20);
				button:SetPoint("TOPLEFT", 23, -counter * 22 + 20);
				button.Icon = button:CreateTexture();
				button.Icon:SetPoint("RIGHT", button, "LEFT", -3, 0);
				button.Icon:SetWidth(20);
				button.Icon:SetHeight(20);
				button.Icon:SetTexCoord(0.07, 0.93, 0.07, 0.93);
				button:Hide();
				selectorEx.buttons[counter] = button;
				return button;
			else
				return selectorEx.buttons[counter];
			end
		end
		
		-- value.text, value.font, value.icon, value.func, value.onEnter, value.onLeave, value.disabled, value.dontCloseOnClick
		selectorEx.SetList = function(t, dontUpdateInternalList)
			for _, button in pairs(selectorEx.buttons) do
				button:SetGray(false);
				button:Hide();
				button.Icon:SetTexture();
				button.Text:SetFont(button.font, button.fontSize, button.fontFlags);
				button:SetScript("OnClick", nil);
			end
			local counter = 1;
			for _, value in pairs(t) do
				local button = GetButton(counter);
				button.Text:SetText(value.text);
				if (value.font ~= nil) then
					button.Text:SetFont(value.font, button.fontSize, button.fontFlags);
				end
				if (value.disabled) then
					button:SetGray(true);
				end
				button.Icon:SetTexture(value.icon);
				button:SetScript("OnClick", function()
					value:func();
					if (not value.dontCloseOnClick) then
						selectorEx:Hide();
					end
				end);
				button:SetScript("OnEnter", value.onEnter);
				button:SetScript("OnLeave", value.onLeave);
				button:Show();
				counter = counter + 1;
			end
			if (not dontUpdateInternalList) then
				selectorEx.list = t;
			end
		end
		
		selectorEx.GetButtonByText = function(text)
			for _, button in pairs(selectorEx.buttons) do
				if (button.Text:GetText() == text) then
					return button;
				end
			end
			return nil;
		end
		
		selectorEx.SetList({});
		selectorEx:Hide();
		selectorEx:HookScript("OnShow", function(self) self:SetFrameStrata("TOOLTIP"); self.scrollArea:SetVerticalScroll(0); end);
	end
	
	return selectorEx;
end

function DeathNote:Show()
	if not self.frame then
		local AceGUI = LibStub("AceGUI-3.0")
		local AceConfig = LibStub("AceConfig-3.0")
		local AceConfigDialog = LibStub("AceConfigDialog-3.0")

		local frame = CreateFrame("Frame", "DeathNoteFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

		frame:SetWidth(self.settings.display.w)
		frame:SetHeight(self.settings.display.h)
		frame:SetPoint("CENTER", UIParent, "CENTER", self.settings.display.x, self.settings.display.y)
		frame:SetBackdrop(WindowBackdrop)
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:SetBackdropBorderColor(0.4, 0.4, 0.4)

		frame:EnableMouse()
		frame:SetMovable(true)
		frame:SetResizable(true)
		frame:SetClampedToScreen(true)
		frame:SetFrameStrata("HIGH")

		-- titlebar
		local titlebar = frame:CreateTexture(nil, "BACKGROUND")
		titlebar:SetColorTexture(0.5, 0.5, 0.5)
		--titlebar:SetGradient("HORIZONTAL", CreateColor(0.6, 0.6, 0.6), CreateColor(0.3, 0.3, 0.3))
		titlebar:SetPoint("TOPLEFT", 4, -4)
		titlebar:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -4, -28)

		local titlebarframe = CreateFrame("Frame", nil, frame)
		titlebarframe:SetAllPoints(titlebar)
		titlebarframe:EnableMouse()

		local titleicon = frame:CreateTexture(nil, "ARTWORK")
		titleicon:SetTexture([[Interface\AddOns\DeathNote\Textures\icon.tga]])
		titleicon:SetPoint("TOPLEFT", titlebar, "TOPLEFT", 2, -2)
		titleicon:SetWidth(20)
		titleicon:SetHeight(20)

		local titletext = frame:CreateFontString(nil, "ARTWORK")
		titletext:SetFontObject(GameFontNormal)
		titletext:SetTextColor(0.6, 0.6, 0.6)
		titletext:SetPoint("TOPLEFT", titlebar, "TOPLEFT", 26, 0)
		titletext:SetPoint("BOTTOMRIGHT", titlebar)

		titletext:SetHeight(28)
		titletext:SetText(L["Death Note"])
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

		local sizer_se_tex = frame:CreateTexture(nil, "BORDER")
		sizer_se_tex:SetTexture([[Interface\AddOns\DeathNote\Textures\resize.tga]])
		sizer_se_tex:SetVertexColor(0.4, 0.4, 0.4, 1)
		sizer_se_tex:SetAllPoints(sizer_se)

		local function save_frame_rect()
			local _, _, sw, sh = UIParent:GetRect()
			local x, y, w, h = frame:GetRect()
			self.settings.display.x, self.settings.display.y, self.settings.display.w, self.settings.display.h =
				x + w/2 - sw/2, y + h/2 - sh/2, w, h
		end

		titlebarframe:SetScript("OnMouseDown", function()
			self.logframe.content:Hide() -- HACK: for now, either this or huge performance problem
			frame:StartMoving()
		end)
		titlebarframe:SetScript("OnMouseUp", function()
			self.logframe.content:Show()
			frame:StopMovingOrSizing()

			save_frame_rect()
		end)

		sizer_se:SetScript("OnEnter", function()
			sizer_se_tex:SetVertexColor(0.8, 0.8, 0.8, 1)
		end)

		sizer_se:SetScript("OnLeave", function()
			sizer_se_tex:SetVertexColor(0.4, 0.4, 0.4, 1)
		end)

		sizer_se:SetScript("OnMouseDown", function()
			frame:SetResizeBounds(600, 270, 2000, 2000)

			frame:StartSizing()
		end)

		sizer_se:SetScript("OnMouseUp", function()
			frame:StopMovingOrSizing()

			save_frame_rect()
		end)

		-- filters
		local filters_frame = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
		filters_frame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
		filters_frame:SetPoint("RIGHT", frame, "RIGHT", -10, 0)
		filters_frame:SetHeight(30)
		filters_frame:SetFrameStrata("DIALOG"); -- todo: quick fix

		filters_frame:SetBackdrop(PaneBackdrop)
		filters_frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
		filters_frame:SetBackdropBorderColor(0.4, 0.4, 0.4)

		local filters_label = filters_frame:CreateFontString(nil, "OVERLAY")
		filters_label:SetPoint("LEFT", 8, 0)
		filters_label:SetPoint("TOP", 0, -6)
		filters_label:SetPoint("BOTTOM", filters_frame, "TOP", 0, -25)
		filters_label:SetFontObject(GameFontNormal)
		filters_label:SetText(filters_label_closed)

		local filters_title = CreateFrame("Frame", nil, filters_frame)
		filters_title:SetAllPoints(filters_label)
		filters_title:EnableMouse()

		-- tab group
		local filters_tab = CreateFrame("Frame", "DeathNoteFilters", filters_frame)
		filters_tab:Hide()
		filters_tab:SetPoint("TOP", filters_title, "BOTTOM", 0, -20)
		filters_tab:SetPoint("LEFT", 5, 0)
		filters_tab:SetPoint("RIGHT", -5, 0)
		filters_tab:SetPoint("BOTTOM", 0, 5)

		-- manual backdrop ftl
		local topleft = filters_tab:CreateTexture(nil, "BORDER")
		topleft:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		topleft:SetVertexColor(0.4, 0.4, 0.4)
		topleft:SetSize(16, 16)
		topleft:SetTexCoord(0.5, 0.625, 0, 1)
		topleft:SetPoint("TOPLEFT")

		local topright = filters_tab:CreateTexture(nil, "BORDER")
		topright:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		topright:SetVertexColor(0.4, 0.4, 0.4)
		topright:SetSize(16, 16)
		topright:SetTexCoord(0.625, 0.75, 0, 1)
		topright:SetPoint("TOPRIGHT")

		local bottomleft = filters_tab:CreateTexture(nil, "BORDER")
		bottomleft:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		bottomleft:SetVertexColor(0.4, 0.4, 0.4)
		bottomleft:SetSize(16, 16)
		bottomleft:SetTexCoord(0.75, 0.875, 0, 1)
		bottomleft:SetPoint("BOTTOMLEFT")

		local bottomright = filters_tab:CreateTexture(nil, "BORDER")
		bottomright:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		bottomright:SetVertexColor(0.4, 0.4, 0.4)
		bottomright:SetSize(16, 16)
		bottomright:SetTexCoord(0.875, 1, 0, 1)
		bottomright:SetPoint("BOTTOMRIGHT")

		local left = filters_tab:CreateTexture(nil, "BORDER")
		left:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		left:SetVertexColor(0.4, 0.4, 0.4)
		left:SetTexCoord(0, 0.125, 0, 1)
		left:SetPoint("TOPLEFT", topleft, "BOTTOMLEFT")
		left:SetPoint("BOTTOMRIGHT", bottomleft, "TOPRIGHT")

		local right = filters_tab:CreateTexture(nil, "BORDER")
		right:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		right:SetVertexColor(0.4, 0.4, 0.4)
		right:SetTexCoord(0.125, 0.25, 0, 1)
		right:SetPoint("TOPLEFT", topright, "BOTTOMLEFT")
		right:SetPoint("BOTTOMRIGHT", bottomright, "TOPRIGHT")

		local bottom = filters_tab:CreateTexture(nil, "BORDER")
		bottom:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		bottom:SetVertexColor(0.4, 0.4, 0.4)
		bottom:SetTexCoord(0.8125, 0.875, 0, 1)
		bottom:SetPoint("BOTTOMLEFT", bottomleft, "BOTTOMRIGHT")
		bottom:SetPoint("BOTTOMRIGHT", bottomright, "BOTTOMLEFT")

		-- damage tab
		local damage_tab_button = CreateFrame("Button", "DeathNoteFiltersTab1", filters_tab, "OptionsFrameTabButtonTemplate")
		damage_tab_button.ntab = 1
		damage_tab_button:SetPoint("BOTTOMLEFT", filters_tab, "TOPLEFT", 6, -3)
		damage_tab_button:SetText(L["Damage"])
		damage_tab_button:SetFrameLevel(2)

		local tabtext = DeathNoteFiltersTab1Text
		tabtext:ClearAllPoints()
		tabtext:SetPoint("LEFT", 14, -3)
		tabtext:SetPoint("RIGHT", -12, -3)

		local damage_tab_spacer1 = filters_tab:CreateTexture(nil, "BORDER")
		damage_tab_spacer1:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		damage_tab_spacer1:SetVertexColor(0.4, 0.4, 0.4)
		damage_tab_spacer1:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		damage_tab_spacer1:SetPoint("TOPLEFT", damage_tab_button, "BOTTOMRIGHT", -10, 3)
		damage_tab_spacer1:SetPoint("TOPRIGHT", topright, "TOPLEFT")

		local damage_options = {
			type = "group",
			inline = true,
			args = {
				tgroup = {
					order = 1,
					name = L["Threshold"],
					type = "group",
					inline = true,
					args = {
						threshold = {
							order = 1,
							name = "",
							type = "range",
							width = "full",
							min = 0,
							softMax = 200000,
							step = 1,
							get = function() return DeathNote.settings.display_filters.damage_threshold end,
							set = function(_, v) DeathNote:SetDisplayFilter("damage_threshold", v) end,
						},
					},
				},
				consolidate = {
					order = 2,
					name = L["Consolidate consecutive hits"],
					type = "toggle",
					width = "double",
					get = function() return DeathNote.settings.display_filters.consolidate_damage end,
					set = function(_, v) DeathNote:SetDisplayFilter("consolidate_damage", v) end,
				},
				misses = {
					order = 3,
					name = L["Hide misses"],
					type = "toggle",
					width = "normal",
					get = function() return DeathNote.settings.display_filters.hide_misses end,
					set = function(_, v) DeathNote:SetDisplayFilter("hide_misses", v) end,
				},
			},
		}

		local damage_tab = AceGUI:Create("SimpleGroup")
		damage_tab.frame:SetParent(filters_tab)
		damage_tab.frame:SetScale(0.9)
		damage_tab.frame:Hide()
		damage_tab:SetPoint("TOPLEFT", 8, -8)
		damage_tab:SetPoint("BOTTOMRIGHT", -8, 8)
		AceConfig:RegisterOptionsTable("Death Note - Damage", damage_options)
		AceConfigDialog:Open("Death Note - Damage", damage_tab)

		-- healing tab
		local healing_tab_button = CreateFrame("Button", "DeathNoteFiltersTab2", filters_tab, "OptionsFrameTabButtonTemplate")
		healing_tab_button.ntab = 2
		healing_tab_button:SetPoint("TOPLEFT", damage_tab_button, "TOPRIGHT", -16, 0)
		healing_tab_button:SetText(L["Healing"])
		healing_tab_button:SetFrameLevel(2)

		tabtext = DeathNoteFiltersTab2Text
		tabtext:ClearAllPoints()
		tabtext:SetPoint("LEFT", 14, -3)
		tabtext:SetPoint("RIGHT", -12, -3)

		local healing_tab_spacer1 = filters_tab:CreateTexture(nil, "BORDER")
		healing_tab_spacer1:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		healing_tab_spacer1:SetVertexColor(0.4, 0.4, 0.4)
		healing_tab_spacer1:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		healing_tab_spacer1:SetPoint("TOPLEFT", topleft, "TOPRIGHT")
		healing_tab_spacer1:SetPoint("TOPRIGHT", healing_tab_button, "BOTTOMLEFT", 10, 0)

		local healing_tab_spacer2 = filters_tab:CreateTexture(nil, "BORDER")
		healing_tab_spacer2:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		healing_tab_spacer2:SetVertexColor(0.4, 0.4, 0.4)
		healing_tab_spacer2:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		healing_tab_spacer2:SetPoint("TOPLEFT", healing_tab_button, "BOTTOMRIGHT", -10, 3)
		healing_tab_spacer2:SetPoint("TOPRIGHT", topright, "TOPLEFT")

		local healing_options = {
			type = "group",
			inline = true,
			args = {
				tgroup = {
					order = 1,
					name = L["Threshold"],
					type = "group",
					inline = true,
					args = {
						threshold = {
							order = 1,
							name = "",
							type = "range",
							width = "full",
							min = 0,
							softMax = 200000,
							step = 1,
							get = function() return DeathNote.settings.display_filters.heal_threshold end,
							set = function(_, v) DeathNote:SetDisplayFilter("heal_threshold", v) end,
						},
					},
				},
				consolidate = {
					order = 2,
					name = L["Consolidate consecutive heals"],
					type = "toggle",
					width = "full",
					get = function() return DeathNote.settings.display_filters.consolidate_heals end,
					set = function(_, v) DeathNote:SetDisplayFilter("consolidate_heals", v) end,
				},
			},
		}

		local healing_tab = AceGUI:Create("SimpleGroup")
		healing_tab.frame:SetParent(filters_tab)
		healing_tab.frame:SetScale(0.9)
		healing_tab.frame:Hide()
		healing_tab:SetPoint("TOPLEFT", 8, -8)
		healing_tab:SetPoint("BOTTOMRIGHT", -8, 8)
		AceConfig:RegisterOptionsTable("Death Note - Healing", healing_options)
		AceConfigDialog:Open("Death Note - Healing", healing_tab)

		-- auras tab
		local auras_tab_button = CreateFrame("Button", "DeathNoteFiltersTab3", filters_tab, "OptionsFrameTabButtonTemplate")
		auras_tab_button.ntab = 3
		auras_tab_button:SetPoint("TOPLEFT", healing_tab_button, "TOPRIGHT", -16, 0)
		auras_tab_button:SetText(L["Auras"])
		auras_tab_button:SetFrameLevel(2)

		tabtext = DeathNoteFiltersTab3Text
		tabtext:ClearAllPoints()
		tabtext:SetPoint("LEFT", 14, -3)
		tabtext:SetPoint("RIGHT", -12, -3)

		local auras_tab_spacer1 = filters_tab:CreateTexture(nil, "BORDER")
		auras_tab_spacer1:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		auras_tab_spacer1:SetVertexColor(0.4, 0.4, 0.4)
		auras_tab_spacer1:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		auras_tab_spacer1:SetPoint("TOPLEFT", topleft, "TOPRIGHT")
		auras_tab_spacer1:SetPoint("TOPRIGHT", auras_tab_button, "BOTTOMLEFT", 10, 0)

		local auras_tab_spacer2 = filters_tab:CreateTexture(nil, "BORDER")
		auras_tab_spacer2:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		auras_tab_spacer2:SetVertexColor(0.4, 0.4, 0.4)
		auras_tab_spacer2:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		auras_tab_spacer2:SetPoint("TOPLEFT", auras_tab_button, "BOTTOMRIGHT", -10, 3)
		auras_tab_spacer2:SetPoint("TOPRIGHT", topright, "TOPLEFT")

		local auras_options = {
			type = "group",
			inline = true,
			args = {
				display = {
					order = 1,
					name = L["Auras"],
					type = "group",
					inline = true,
					args = {
						buff_gains = {
							order = 1,
							type = "toggle",
							name = L["Buff gains"],
							get = function() return DeathNote.settings.display_filters.buff_gains end,
							set = function(_, v) DeathNote:SetDisplayFilter("buff_gains", v) end,
						},
						buff_fades = {
							order = 2,
							type = "toggle",
							name = L["Buff fades"],
							get = function() return DeathNote.settings.display_filters.buff_fades end,
							set = function(_, v) DeathNote:SetDisplayFilter("buff_fades", v) end,
						},
						debuff_gains = {
							order = 3,
							type = "toggle",
							name = L["Debuff gains"],
							get = function() return DeathNote.settings.display_filters.debuff_gains end,
							set = function(_, v) DeathNote:SetDisplayFilter("debuff_gains", v) end,
						},
						debuff_fades = {
							order = 4,
							type = "toggle",
							name = L["Debuff fades"],
							get = function() return DeathNote.settings.display_filters.debuff_fades end,
							set = function(_, v) DeathNote:SetDisplayFilter("debuff_fades", v) end,
						},
						survival_buffs = {
							order = 5,
							type = "toggle",
							name = L["Survival cooldowns"],
							get = function() return DeathNote.settings.display_filters.survival_buffs end,
							set = function(_, v) DeathNote:SetDisplayFilter("survival_buffs", v) end,
						},
						highlight_survival = {
							order = 6,
							name = L["Highlight survival cooldowns"],
							type = "toggle",
							-- width = "double",
							get = function() return DeathNote.settings.display_filters.highlight_survival end,
							set = function(_, v) DeathNote:SetDisplayFilter("highlight_survival", v) end,
						},
						highlight_survival_selection = {
							order = 7,
							name = L["ui:filters:select-cds"],
							type = "execute",
							func = function()
								local selector = GetSelectorEx();
								if (selector:IsVisible()) then
									selector:Hide();
								else
									selector:SetParent(GetMouseFocus());
									selector:SetPoint("TOP", GetMouseFocus(), "BOTTOM", 0, 0);
									-- value.text, value.font, value.icon, value.func, value.onEnter, value.onLeave
									local t = { };
									for spellID, spellInfo in pairs(DeathNote.SurvivalIDs) do
										local spellName = GetSpellInfo(spellID);
										if (not spellName) then error("Unknown survival spellID: "..spellID) end
										tinsert(t, {
											text = string_format("[%s] %s", LocalizedClassList[spellInfo.class], spellName),
											font = nil,
											icon = GetSpellTexture(spellID),
											dontCloseOnClick = true,
											disabled = DeathNote.settings.display_filters.ignored_highlight_survival[spellID],
											func = function(buttonInfo)
												local btn = selector.GetButtonByText(string_format("[%s] %s", LocalizedClassList[buttonInfo.class], GetSpellInfo(buttonInfo.spellID)));
												if (btn) then
													buttonInfo.disabled = not buttonInfo.disabled;
													btn:SetGray(buttonInfo.disabled);
													DeathNote.settings.display_filters.ignored_highlight_survival[buttonInfo.spellID] = buttonInfo.disabled and true or nil; -- // because we don't need a lot of false values in this table
													DeathNote:RefreshHighlight();
												end
											end,
											onEnter = function(self)
												GameTooltip:SetOwner(selector, "ANCHOR_RIGHT");
												GameTooltip:SetSpellByID(spellID);
												GameTooltip:Show();
											end,
											onLeave = function() GameTooltip:Hide(); end,
											spellID = spellID,
											class = spellInfo.class,
										});
									end
									table.sort(t, function(first, second) return first.text < second.text end);
									selector.SetList(t);
									selector:Show();
								end
							end,
						},
					},
				},
				consolidate = {
					order = 2,
					name = L["Consolidate consecutive auras"],
					type = "toggle",
					width = "double",
					get = function() return DeathNote.settings.display_filters.consolidate_auras end,
					set = function(_, v) DeathNote:SetDisplayFilter("consolidate_auras", v) end,
				},
			},
		}

		local auras_tab = AceGUI:Create("SimpleGroup")
		auras_tab.frame:SetParent(filters_tab)
		auras_tab.frame:SetScale(0.9)
		auras_tab:SetPoint("TOPLEFT", 8, -8)
		auras_tab:SetPoint("BOTTOMRIGHT", -8, 8)
		AceConfig:RegisterOptionsTable("Death Note - Auras", auras_options)
		AceConfigDialog:Open("Death Note - Auras", auras_tab)

		-- others tab
		local others_tab_button = CreateFrame("Button", "DeathNoteFiltersTab4", filters_tab, "OptionsFrameTabButtonTemplate")
		others_tab_button.ntab = 4
		others_tab_button:SetPoint("TOPLEFT", auras_tab_button, "TOPRIGHT", -16, 0)
		others_tab_button:SetText(L["Others"])
		others_tab_button:SetFrameLevel(2)

		tabtext = DeathNoteFiltersTab4Text
		tabtext:ClearAllPoints()
		tabtext:SetPoint("LEFT", 14, -3)
		tabtext:SetPoint("RIGHT", -12, -3)

		local others_tab_spacer1 = filters_tab:CreateTexture(nil, "BORDER")
		others_tab_spacer1:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		others_tab_spacer1:SetVertexColor(0.4, 0.4, 0.4)
		others_tab_spacer1:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		others_tab_spacer1:SetPoint("TOPLEFT", topleft, "TOPRIGHT")
		others_tab_spacer1:SetPoint("TOPRIGHT", others_tab_button, "BOTTOMLEFT", 10, 0)

		local others_tab_spacer2 = filters_tab:CreateTexture(nil, "BORDER")
		others_tab_spacer2:SetTexture([[Interface\Tooltips\UI-Tooltip-Border]])
		others_tab_spacer2:SetVertexColor(0.4, 0.4, 0.4)
		others_tab_spacer2:SetTexCoord(0.625-0.0625, 0.628, 0, 1)
		others_tab_spacer2:SetPoint("TOPLEFT", others_tab_button, "BOTTOMRIGHT", -10, 3)
		others_tab_spacer2:SetPoint("TOPRIGHT", topright, "TOPLEFT")

		local function format_filter(f)
			local t = {}
			for k, v in pairs(f) do
				tinsert(t, v)
			end
			table.sort(t)
			return table.concat(t, ",")
		end

		local others_options = {
			type = "group",
			inline = true,
			args = {
				spell = {
					order = 1,
					name = L["Spell filter"],
					desc = L["Enter one or more spells, separated by commas.\nCtrl+Click on a spell column to add that spell."],
					type = "input",
					width = "full",
					get = function() return format_filter(DeathNote.settings.display_filters.spell_filter) end,
					set = function(_, v) DeathNote:SetDisplayFilter("spell_filter", v) end,
				},
				source = {
					order = 2,
					name = L["Source filter"],
					desc = L["Enter one or more sources, separated by commas.\nCtrl+Click on a source column to add that source."],
					type = "input",
					width = "full",
					get = function() return format_filter(DeathNote.settings.display_filters.source_filter) end,
					set = function(_, v) DeathNote:SetDisplayFilter("source_filter", v) end,
				},
				reset = {
					order = 3,
					name = L["Reset"],
					type = "execute",
					width = "half",
					func = function() DeathNote:SetDisplayFilter("spell_filter", "") DeathNote:SetDisplayFilter("source_filter", "") end,
				},
			},
		}

		local others_tab = AceGUI:Create("SimpleGroup")
		others_tab.frame:SetParent(filters_tab)
		others_tab.frame:SetScale(0.9)
		others_tab:SetPoint("TOPLEFT", 8, -8)
		others_tab:SetPoint("BOTTOMRIGHT", -8, 8)
		AceConfig:RegisterOptionsTable("Death Note - Others", others_options)
		AceConfigDialog:Open("Death Note - Others", others_tab)

		-- final tab setup
		self.filters_label = filters_label
		self.filters_frame = filters_frame
		self.filters_tab = filters_tab

		self.damage_tab = damage_tab
		self.healing_tab = healing_tab
		self.auras_tab = auras_tab
		self.others_tab = others_tab

		self.damage_tab_spacer1 = damage_tab_spacer1
		self.healing_tab_spacer1 = healing_tab_spacer1
		self.healing_tab_spacer2 = healing_tab_spacer2
		self.auras_tab_spacer1 = auras_tab_spacer1
		self.auras_tab_spacer2 = auras_tab_spacer2
		self.others_tab_spacer1 = others_tab_spacer1
		self.others_tab_spacer2 = others_tab_spacer2

		PanelTemplates_SetNumTabs(filters_tab, 4)

		filters_tab:SetScript("OnSizeChanged", function(frame, width, height)
				damage_tab:SetWidth(width - 16)
				damage_tab:SetHeight(height - 16)

				healing_tab:SetWidth(width - 16)
				healing_tab:SetHeight(height - 16)

				auras_tab:SetWidth(width - 16)
				auras_tab:SetHeight(height - 16)

				others_tab:SetWidth(width - 16)
				others_tab:SetHeight(height - 16)
			end)

		local function Tab_OnClick(frame)
			DeathNote:SetFiltersTab(frame.ntab)
		end

		damage_tab_button:SetScript("OnClick", Tab_OnClick)
		healing_tab_button:SetScript("OnClick", Tab_OnClick)
		auras_tab_button:SetScript("OnClick", Tab_OnClick)
		others_tab_button:SetScript("OnClick", Tab_OnClick)

		Tab_OnClick(damage_tab_button)

		self.collapsed = true
		filters_title:SetScript("OnMouseUp", function() DeathNote:ToggleFiltersFrame() end)

		-- tools frame
		local tools_frame = CreateFrame("Frame", nil, filters_frame)
		tools_frame:SetPoint("TOPRIGHT", -8, -9)
		tools_frame:SetWidth(12)
		tools_frame:SetHeight(12)
		tools_frame:EnableMouse()

		local tools_icon = tools_frame:CreateTexture(nil, "OVERLAY")
		tools_icon:SetAllPoints()
		tools_icon:SetTexture([[Interface\AddOns\DeathNote\Textures\gear.tga]])

		self.tools_frame = tools_frame
		tools_frame:SetScript("OnMouseUp", function() self:ShowToolsMenu() end)

		-- name list
		local name_list_border = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
		name_list_border:SetPoint("TOPLEFT", filters_frame, "BOTTOMLEFT", 0, 0)
		name_list_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", self.settings.display.namelist_width, 10)

		name_list_border:SetBackdrop(PaneBackdrop)
		name_list_border:SetBackdropColor(0.1, 0.1, 0.1, 0.5)
		name_list_border:SetBackdropBorderColor(0.4, 0.4, 0.4)
		name_list_border:SetResizable(true)
		name_list_border:SetResizeBounds(400, 200, 2000, 2000);

		local name_list = CreateFrame("ScrollFrame", nil, name_list_border)
		name_list:SetPoint("TOPLEFT", 8, -8)
		name_list:SetPoint("BOTTOMRIGHT", -8, 8)
		name_list:EnableMouseWheel(true)

		-- name list scrollbar
		local name_scroll = CreateFrame("Slider", nil, name_list, "UIPanelScrollBarTemplate")
		name_scroll:SetPoint("BOTTOMRIGHT", name_list_border, "BOTTOMRIGHT", -8, 24)
		name_scroll:SetPoint("TOPRIGHT", name_list_border, "TOPRIGHT", -8, -24)
		name_scroll:SetMinMaxValues(0, 1000)
		name_scroll:SetValueStep(1)
		name_scroll:SetValue(0)
		name_scroll:SetWidth(16)
		name_scroll:SetFrameLevel(6)
		name_scroll:Hide()

		local name_scrollbg = name_scroll:CreateTexture(nil, "BACKGROUND")
		name_scrollbg:SetAllPoints()
		name_scrollbg:SetColorTexture(0, 0, 0, 1)

		local name_content = CreateFrame("Frame", nil, name_list)
		name_list:SetScrollChild(name_content)
		name_content:SetPoint("TOPLEFT")
		name_content:SetPoint("TOPRIGHT")

		name_list:SetScript("OnMouseWheel", function(frame, value)
			local l, h = name_scroll:GetMinMaxValues()
			name_scroll:SetValue(min(max(name_scroll:GetValue() - value*45, l), h))
		end)

		name_scroll:SetScript("OnValueChanged", function(frame, value)
			name_content:SetPoint("TOPLEFT", 0, value)
			name_content:SetPoint("TOPRIGHT", 0, value)
		end)

		self.name_list_border = name_list_border
		self.name_list = name_list
		self.name_content = name_content
		self.name_scroll = name_scroll
		self.name_items = {}

		name_list:SetScript("OnSizeChanged", function() self:NameList_SizeChanged() end)

		-- dragger
		local dragger = CreateFrame("Frame", nil, name_list_border, BackdropTemplateMixin and "BackdropTemplate")
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

			local width = name_list_border:GetWidth() + 10
			name_list_border:ClearAllPoints()
			name_list_border:SetPoint("TOPLEFT", filters_frame, "BOTTOMLEFT", 0, 0)
			name_list_border:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", width, 10)
			self.settings.display.namelist_width = width
		end

		dragger:SetScript("OnEnter", Dragger_OnEnter)
		dragger:SetScript("OnLeave", Dragger_OnLeave)
		dragger:SetScript("OnMouseDown", Dragger_OnMouseDown)
		dragger:SetScript("OnMouseUp", Dragger_OnMouseUp)

		-- logframe
		local logframe = self:CreateListBox(frame, self.settings.display.scale)
		logframe.frame:SetPoint("TOPLEFT", name_list_border, "TOPRIGHT")
		logframe.frame:SetPoint("BOTTOM", name_list_border, "BOTTOM", 0, 30)
		logframe.frame:SetPoint("RIGHT", frame, "RIGHT", -10, 0)

		self.logframe = logframe

		logframe:AddColumn(L["Time"], "RIGHT", self.settings.display.columns[1])
		logframe:AddColumn(L["HP"], "CENTER", self.settings.display.columns[2])
		logframe:AddColumn(L["Amount"], "RIGHT", self.settings.display.columns[3])
		logframe:AddColumn(L["Spell"], "LEFT", self.settings.display.columns[4])
		logframe:AddColumn(L["Source"], "LEFT")

		logframe:SetSettingsCallback(
			function(columns)
				self.settings.display.columns = columns
			end,
			function(scale)
				self:Print(string.format(L["Setting scale to %i%%"], floor(scale * 100 + 0.5)))
				self.settings.display.scale = scale
			end)

		-- logframe searchbox
		CreateSearchBox(logframe.frame);

		logframe:SetMouseCallbacks(
			function(button, nline, column, userdata)
				CloseDropDownMenus()

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
					if IsControlKeyDown() then
						if column == 4 then
							self:AddSpellFilter(userdata)
						elseif column == 5 then
							self:AddSourceFilter(userdata)
						end
					else
						if column == 1 then
							self:CycleTimestampDisplay()
						elseif column == 2 then
							self:CycleHealthDisplay()
						elseif column == 3 then
						elseif column == 4 then
							self:SetSpellHilight(userdata)
						elseif column == 5 then
							self:SetSourceHilight(userdata)
						else
							return
						end

						self:RefreshDeath()
					end
				elseif button == "RightButton" then
					self.dropdown_line = nline
					self.dropdown_line_prevhili = logframe:SetLineHighlight(nline, normal_hilight)
					self:ShowLineMenu()
				end
			end,
			function(column, userdata)
				GameTooltip:SetOwner(logframe.frame, "ANCHOR_NONE")
				GameTooltip:SetPoint("BOTTOMLEFT", logframe.frame, "BOTTOMRIGHT")

				local have_tip = false

				if column == 1 then -- Time
					have_tip = self:FormatTooltipTimestamp(GameTooltip, userdata)
				elseif column == 2 then -- HP
					have_tip = self:FormatTooltipHealth(GameTooltip, userdata)
				elseif column == 3 then -- Amount
					have_tip = self:FormatTooltipAmount(GameTooltip, userdata)
				elseif column == 4 then -- Spell
					have_tip = self:FormatTooltipSpell(GameTooltip, userdata)
				elseif column == 5 then -- Source
					have_tip = self:FormatTooltipSource(GameTooltip, userdata)
				end

				if (have_tip) then
					have_tip:Show()
				end
			end,
			function(column, userdata)
				GameTooltip:Hide()
			end)

			-- hide on escape
			local org_CloseAllWindows = CloseAllWindows
			CloseAllWindows = function(ignoreCenter)
				local ret = org_CloseAllWindows(ignoreCenter)
				if not ignoreCenter then
					if frame:IsShown() then
						frame:Hide()
						ret = true
					end
				end
				return ret
			end

		self.frame = frame
	end

	self.frame:Show()
	self:UpdateNameList()
end

-- Filters UI
function DeathNote:SetFiltersTab(ntab)
	self.filters_tab.selectedTab = ntab
	--PanelTemplates_UpdateTabs(self.filters_tab)

	-- this shouldn't be hardcoded
	if ntab == 1 then
		self.damage_tab_spacer1:Show()
		self.healing_tab_spacer1:Hide()
		self.healing_tab_spacer2:Hide()
		self.auras_tab_spacer1:Hide()
		self.auras_tab_spacer2:Hide()
		self.others_tab_spacer1:Hide()
		self.others_tab_spacer2:Hide()

		self.damage_tab.frame:Show()
		self.healing_tab.frame:Hide()
		self.auras_tab.frame:Hide()
		self.others_tab.frame:Hide()
	elseif ntab == 2 then
		self.damage_tab_spacer1:Hide()
		self.healing_tab_spacer1:Show()
		self.healing_tab_spacer2:Show()
		self.auras_tab_spacer1:Hide()
		self.auras_tab_spacer2:Hide()
		self.others_tab_spacer1:Hide()
		self.others_tab_spacer2:Hide()

		self.damage_tab.frame:Hide()
		self.healing_tab.frame:Show()
		self.auras_tab.frame:Hide()
		self.others_tab.frame:Hide()
	elseif ntab == 3 then
		self.damage_tab_spacer1:Hide()
		self.healing_tab_spacer1:Hide()
		self.healing_tab_spacer2:Hide()
		self.auras_tab_spacer1:Show()
		self.auras_tab_spacer2:Show()
		self.others_tab_spacer1:Hide()
		self.others_tab_spacer2:Hide()

		self.damage_tab.frame:Hide()
		self.healing_tab.frame:Hide()
		self.auras_tab.frame:Show()
		self.others_tab.frame:Hide()
	elseif ntab == 4 then
		self.damage_tab_spacer1:Hide()
		self.healing_tab_spacer1:Hide()
		self.healing_tab_spacer2:Hide()
		self.auras_tab_spacer1:Hide()
		self.auras_tab_spacer2:Hide()
		self.others_tab_spacer1:Show()
		self.others_tab_spacer2:Show()

		self.damage_tab.frame:Hide()
		self.healing_tab.frame:Hide()
		self.auras_tab.frame:Hide()
		self.others_tab.frame:Show()
	end
end

function DeathNote:ToggleFiltersFrame(show)
	if show ~= nil then
		self.collapsed = show
	end

	if self.collapsed then
		self.filters_label:SetText(filters_label_open)
		self.filters_frame:SetHeight(175)
		self.filters_tab:Show()
	else
		self.filters_label:SetText(filters_label_closed)
		self.filters_frame:SetHeight(30)
		self.filters_tab:Hide()
	end

	self.collapsed = not self.collapsed
end

function DeathNote:ShowFiltersTab(ntab)
	self:SetFiltersTab(ntab)
	self:ToggleFiltersFrame(true)
end

------------------------------------------------------------------------------
-- UnitPopup support
------------------------------------------------------------------------------

local selectedDropdownUnit = nil;

local function UnitPopupClick()
	if (selectedDropdownUnit == nil) then
		return;
	end
	local name, server = UnitName(selectedDropdownUnit)

	if not name then
		return
	end

	if server and server ~= "" then
		name = name .. "-" .. server
	end

	DeathNote:Debug("unit:", selectedDropdownUnit, "name:", selectedDropdownUnit, "result:", name)

	DeathNote:ShowUnit(name)
end

local dropdownOptions = {
	{
		text = L["Show Death Note"],
		func = UnitPopupClick,
	},
}

function DeathNote:ShowUnit(name)
	self:Show()

	for i = 1, #self.name_items do
		if self.name_items[i]:IsShown() then
			local userdata = self.name_items[i].userdata
			if userdata.name == name then
				self.name_scroll:SetValue((i - 3) * self:GetNameButtonHeight())
				self.name_items[i]:Click()
				return
			end
		end
	end
end

local function OnEvent(dropdown, event, options)
	if (event == "OnShow") then
		selectedDropdownUnit = dropdown.unit;
		if (DeathNote.settings.unit_menu) then
			for index, value in pairs(options) do
				print(index, value);
			end
			for i = 1, #dropdownOptions do
				options[i] = dropdownOptions[i]
			end
		end
		return true
	elseif (event == "OnHide") then
		for i = #options, 1, -1 do
			options[i] = nil
		end
	end
end

LibDDE:RegisterEvent("OnShow OnHide", OnEvent, 1);

------------------------------------------------------------------------------
-- Display stuff
------------------------------------------------------------------------------

function DeathNote:SetNameListDisplay(n)
	self.settings.display.namelist = n
	DeathNote:UpdateNameList()
	DeathNote:ScrollNameListToCurrentDeath()
end

function DeathNote:SetTimestampDisplay(n)
	self.settings.display.timestamp = n
	self:RefreshDeath()
end

function DeathNote:SetHealthDisplay(n)
	self.settings.display.health = n
	self:RefreshDeath()
end

------------------------------------------------------------------------------
-- Line drop down menu
------------------------------------------------------------------------------

function DeathNote:ShowLineMenu(line)
	if not self.line_dropdownframe then
		self.line_dropdownframe = CreateFrame("Frame", nil, nil, "UIDropDownMenuTemplate")
		self.line_dropdownframe.displayMode = "MENU"
		self.line_dropdownframe.initialize = self.LineDropDownInitialize
		self.line_dropdownframe.onHide =
			function(level)
				if level == 2 then
					self.logframe:SetLineHighlight(self.dropdown_line, self.dropdown_line_prevhili)
				end
			end
	end

	ToggleDropDownMenu(1, nil, self.line_dropdownframe, "cursor")
end

local function GetChatColor(tag)
	--[[
	local r, g, b = GetMessageTypeColor(tag)

	-- totally unscientific hack to prevent black text over black background
	if not r or (0.2126*r + 0.7152*g + 0.0722*b) < 0.2 then
		r, g, b = 1, 1, 1
	end

	return "|c" .. CombatLog_Color_FloatToText(r, g, b)
	]]
end

local function GetGuildRankFlag(nflag)
	if not GetGuildInfo("player") then
		return false
	end
	return true; -- // this is temporary workaround because now we cannot get the list of privilegies programmatically
	-- local rank = select(3, GetGuildInfo("player")) + 1
	-- GuildControlSetRank(rank)
	-- return select(nflag, GuildControlGetRankFlags())
end

local function CanSpeakGuildChat()
	return GetGuildRankFlag(2)
end

local function CanSpeakOfficerChat()
	return GetGuildRankFlag(4)
end

function DeathNote.LineDropDownInitialize(self, level)
	local info = {}

	if not level then return end

	if level == 1 then
		info.text = L["Report style"]
		info.hasArrow = 1
		info.value = "REPORT_FORMAT"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Send report from this line"]
		info.hasArrow = 1
		info.value = "REPORT"
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)
	elseif level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "REPORT_FORMAT" then
			info.text = L["Compact"]
			info.checked = function() return DeathNote.settings.report.style == "FORMATTED" end
			info.func = function() DeathNote.settings.report.style = "FORMATTED" end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Combat log lines"]
			info.checked = function() return DeathNote.settings.report.style == "COMBAT_LOG" end
			info.func = function() DeathNote.settings.report.style = "COMBAT_LOG" end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == "REPORT" then
			info.colorCode = GetChatColor("SAY")
			info.text = L["Say"]
			info.func = function() DeathNote:SendReport("SAY") end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			if GetNumGroupMembers() > 0 then
				info.colorCode = GetChatColor("PARTY")
				info.text = L["Party"]
				info.func = function() DeathNote:SendReport("PARTY") end
				UIDropDownMenu_AddButton(info, level)
			end

			if IsInRaid() then
				info.colorCode = GetChatColor("RAID")
				info.text = L["Raid"]
				info.func = function() DeathNote:SendReport("RAID") end
				UIDropDownMenu_AddButton(info, level)
			end

			if CanSpeakGuildChat() then
				info.colorCode = GetChatColor("GUILD")
				info.text = L["Guild"]
				info.func = function() DeathNote:SendReport("GUILD") end
				UIDropDownMenu_AddButton(info, level)
			end

			if CanSpeakOfficerChat() then
				info.colorCode = GetChatColor("OFFICER")
				info.text = L["Officer"]
				info.func = function() DeathNote:SendReport("OFFICER") end
				UIDropDownMenu_AddButton(info, level)
			end

			info.colorCode = GetChatColor("WHISPER")
			info.text = L["Whisper target"]
			info.func = function() DeathNote:SendReport("WHISPER") end
			UIDropDownMenu_AddButton(info, level)

			if #DeathNote:O_GetPlayerChannels() > 0 then
				info.colorCode = nil
				info.text = L["Channel"]
				info.hasArrow = 1
				info.value = "CHANNEL"
				UIDropDownMenu_AddButton(info, level)
			end
		end
	elseif level == 3 then
		if UIDROPDOWNMENU_MENU_VALUE == "CHANNEL" then
			for _, c in ipairs(DeathNote:O_GetPlayerChannels()) do
				info.colorCode = GetChatColor("CHANNEL" .. c.id)
				info.text = string.format("%i. %s", c.id, c.name)
				info.notCheckable = 1
				info.func = function() DeathNote:SendReport("CHANNEL", c.id) end
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

------------------------------------------------------------------------------
-- Tools menu
------------------------------------------------------------------------------

function DeathNote:ShowToolsMenu()
	if not self.tools_dropdownframe then
		self.tools_dropdownframe = CreateFrame("Frame", nil, nil, "UIDropDownMenuTemplate")
		self.tools_dropdownframe.displayMode = "MENU"
		self.tools_dropdownframe.initialize = self.ToolsDropDownInitialize
	end

	ToggleDropDownMenu(1, nil, self.tools_dropdownframe, self.tools_frame, 0, 0)
 end

function DeathNote.ToolsDropDownInitialize(self, level)
 	local info = {}

	if not level then return end

	if level == 1 then
		info.text = L["Sort deaths by"]
		info.value = "DL_ORDER"
		info.hasArrow = 1
		info.notCheckable = 1
		info.func = function() DeathNote:ResetData() end
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.text = L["Time format"]
		info.value = "COL_TIME"
		info.hasArrow = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.text = L["Health format"]
		info.value = "COL_HEALTH"
		info.hasArrow = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		info.text = string.format(L["Scale: %i%%"], floor(DeathNote.settings.display.scale * 100 + 0.5))
		info.value = "COL_SCALE"
		info.hasArrow = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.text = L["Options"]
		info.value = "OPTIONS"
		info.notCheckable = 1
		info.func = function() InterfaceOptionsFrame_OpenToCategory(L["Death Note"]) end
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.disabled = 1
		info.notCheckable = 1
		UIDropDownMenu_AddButton(info, level)

		wipe(info)
		info.text = L["Reset data"]
		info.value = "RESETDATA"
		info.notCheckable = 1
		info.func = function() DeathNote:ResetData() end
		UIDropDownMenu_AddButton(info, level)
	elseif level == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "DL_ORDER" then
			info.text = L["Name"]
			info.checked = function() return DeathNote.settings.display.namelist == 1 end
			info.func = function() DeathNote:SetNameListDisplay(1) end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Time"]
			info.checked = function() return DeathNote.settings.display.namelist == 2 end
			info.func = function() DeathNote:SetNameListDisplay(2) end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == "COL_TIME" then
			info.text = L["Seconds from death"]
			info.checked = function() return DeathNote.settings.display.timestamp == 1 end
			info.func = function() DeathNote:SetTimestampDisplay(1) end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Real time"]
			info.checked = function() return DeathNote.settings.display.timestamp == 2 end
			info.func = function() DeathNote:SetTimestampDisplay(2) end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == "COL_HEALTH" then
			info.text = L["Bar"]
			info.checked = function() return DeathNote.settings.display.health == 1 end
			info.func = function() DeathNote:SetHealthDisplay(1) end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["HP %"]
			info.checked = function() return DeathNote.settings.display.health == 2 end
			info.func = function() DeathNote:SetHealthDisplay(2) end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["HP"]
			info.checked = function() return DeathNote.settings.display.health == 3 end
			info.func = function() DeathNote:SetHealthDisplay(3) end
			UIDropDownMenu_AddButton(info, level)

			info.text = L["HP/HPMax"]
			info.checked = function() return DeathNote.settings.display.health == 4 end
			info.func = function() DeathNote:SetHealthDisplay(4) end
			UIDropDownMenu_AddButton(info, level)
		elseif UIDROPDOWNMENU_MENU_VALUE == "COL_SCALE" then
			info.text = L["Increase scale"]
			info.func = function() 
				local scale = DeathNote.settings.display.scale + 0.05
				if scale >= 0.5 and scale <= 2.0 then
					DeathNote.logframe:SetScale(scale)
				end
			end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)

			info.text = L["Decrease scale"]
			info.func = function() 
				local scale = DeathNote.settings.display.scale - 0.05
				if scale >= 0.5 and scale <= 2.0 then
					DeathNote.logframe:SetScale(scale)
				end
			end
			info.notCheckable = 1
			UIDropDownMenu_AddButton(info, level)
		end
	end
end

------------------------------------------------------------------------------
-- Name list
------------------------------------------------------------------------------

function DeathNote:GetNameButtonHeight()
	-- return 18;
	return 18 + 12;
end

function DeathNote:NameList_SizeChanged()
	local content_height = self.name_content:GetHeight()
	local height = self.name_list:GetHeight()

	if height >= content_height then
		self.name_list:SetPoint("BOTTOMRIGHT", -8, 8)
		self.name_scroll:SetMinMaxValues(0, 0)
		self.name_scroll:Hide()
	else
		self.name_list:SetPoint("BOTTOMRIGHT", -8, 8)
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
		DeathNote:ScrollNameListToCurrentDeath()
	end
end

local function NameList_OnEnter(frame)
	GameTooltip:SetOwner(frame, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT")

	local entry = DeathNote:GetKillingBlow(frame.userdata)

	local have_tip = entry and DeathNote:FormatTooltipAmount(GameTooltip, entry)

	if have_tip then
		GameTooltip:Show()
	end
end

local function NameList_OnLeave(frame)
	GameTooltip:Hide()
end

function DeathNote:ScrollNameListToCurrentDeath()
	if not self.current_death then
		self.name_scroll:SetValue(0)
		return
	end

	for i = 1, #self.name_items do
		if self.name_items[i]:IsShown() then
			local userdata = self.name_items[i].userdata
			if userdata == self.current_death then
				self.name_scroll:SetValue((i - 3) * self:GetNameButtonHeight())
				return
			end
		end
	end
end

local GetSortedDeathList = {}

local function SortDeathsByNameFunc(a, b)
	return a.name > b.name or (a.name == b.name and a.timestamp < b.timestamp)
end

GetSortedDeathList[1] = function()
	-- by name
	local deaths = {}
	for _, v in ipairs(DeathNoteData.deaths) do
		tinsert(deaths, v)
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
	local btnh = self:GetNameButtonHeight()

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
		local death = deaths[count - i + 1]

		if not self.name_items[i] then
			local button = CreateFrame("Button", "DeathNoteNameListButton" .. i, self.name_content, "OptionsListButtonTemplate")

			button:SetNormalFontObject(GameFontNormal)
			button:SetHighlightFontObject(GameFontHighlight)

			button:SetScript("OnClick", NameList_OnClick)
			button:SetScript("OnEnter", NameList_OnEnter)
			button:SetScript("OnLeave", NameList_OnLeave)
			button:SetScript("OnDoubleClick", nil)

			button:SetPoint("TOPLEFT", 0, -btnh * (i - 1))
			button:SetPoint("BOTTOMRIGHT", self.name_content, "TOPRIGHT", 0, -btnh * i)

			-- reason stuff
			local btnfs = button:GetFontString()
			btnfs:SetPoint("TOPLEFT", button, "TOPLEFT", 0, -2)
			btnfs:SetJustifyV("TOP")

			local reasonfs = button:CreateFontString()
			reasonfs:SetFontObject(SystemFont_Tiny)

			reasonfs:SetPoint("TOPLEFT", 0, -17)
			reasonfs:SetPoint("BOTTOMRIGHT")
			reasonfs:SetJustifyH("LEFT")

			button.reasonfs = reasonfs;
			--


			self.name_items[i] = button
		end

		local btn = self.name_items[i]

		btn.userdata = death
		local name, reason = self:FormatNameListEntry(death)
		btn:GetFontString():SetText(name)
		btn.reasonfs:SetText(reason)

		if self.current_death == death then
			btn:LockHighlight()
		else
			btn:UnlockHighlight()
		end

		btn:Show()
	end

	self.name_content:SetHeight(btnh * count)
	self:NameList_SizeChanged()
end

------------------------------------------------------------------------------
-- ShowDeath
------------------------------------------------------------------------------

function DeathNote:IsTypeConsolidated(etype)
	return (etype == "DAMAGE" and self.settings.display_filters.consolidate_damage) or
		(etype == "HEAL" and self.settings.display_filters.consolidate_heals) or
		(etype == "AURA" and self.settings.display_filters.consolidate_auras)
end

local groups = {}

local function AddGroup(etype, entry, highlight_spellid)
	local group = {
		type = etype,
		highlight_spellid = highlight_spellid,
	}

	tinsert(groups, group)
	tinsert(group, entry)
end

function DeathNote:ShowDeath(death)
	if self.settings.debugging then debugprofilestart() end

	wipe(groups)

	self.logframe:ClearAllLines()

	self.current_death = death

	self:ResetFiltering()

	local entriesCount = 0;
	for entry in self:IterateDeath(death, self.settings.death_time) do
		self:ProcessDeathEntry(entry);

		entriesCount = entriesCount + 1;
		if (entriesCount >= self.settings.death_log_entries) then
			break;
		end
	end

	self:ProcessDeathEntry(nil)
	self:RefreshHighlight()

	self.logframe:UpdateComplete()
	self.logframe:ScrollToBottom()

	if self.settings.debugging then self:Debug(string.format("Death shown in %.02f ms (%i lines)", debugprofilestop(), self.logframe:GetLineCount())) end
end

function DeathNote:ProcessDeathEntry(entry)
	if entry then
		local filtered, highlight_spellid = self:IsEntryFiltered(entry)
		if filtered then
			entry.highlight_spellid = highlight_spellid
			local etype = self:GetEntryType(entry)

			assert(etype, "Unknown event type")

			local group = groups[#groups]

			if self:IsTypeConsolidated(etype) then
				if group then
					if group.type == etype then
						-- add to group
						tinsert(group, entry)
					else
						-- start group
						AddGroup(etype, entry, highlight_spellid)
					end
				end
			else
				-- start single group
				if self:IsEntryOverThreshold(entry) then
					AddGroup(etype, entry, highlight_spellid)
				end
			end
		end
	else
		-- if thresholds > 0 and consolidate damage or heal then

		-- sum until barrier
		local prev_barrier
		local tsum = {}
		------------------
		local function barrier(g)
			local group = groups[g]
			if next(tsum) then
				local keep_type

				if group and tsum[group.type] then
					-- choose by barrier type
					keep_type = group.type
				else
					if prev_barrier and tsum[prev_barrier.type] then
						-- choose by PREV barrier type
						keep_type = prev_barrier.type
					else
						-- choose by amount - threshold
						local best_amount, best_type = 0, nil
						for type, amount in pairs(tsum) do
							local at = amount - self:GetTypeThreshold(type)
							if at > best_amount then
								best_amount = at
								best_type = type
							end
						end
						keep_type = best_type
					end
				end

				local gg = g + 1
				while groups[gg] ~= prev_barrier do
					if groups[gg].type ~= keep_type then
						tremove(groups, gg)
					else
						gg = gg + 1
					end
				end
			end
			prev_barrier = group
			wipe(tsum)
		end
		-----------------
		for g = #groups, 1, -1 do
			local group = groups[g]
			if self:IsGroupOverThreshold(group) then
				-- BARRIER!
				barrier(g)
			else
				if not tsum[group.type] then
					tsum[group.type] = 0
				end

				tsum[group.type] = tsum[group.type] + self:GetGroupAmount(group)
			end
		end
		barrier(1)

		-- consolidate again + add
		for g = 1, #groups do
			local group = groups[g]
			if not group then
				-- consolidation can make groups shrink
				break
			end

			if self:IsTypeConsolidated(group.type) then
				while #groups > g and groups[g + 1].type == group.type do
					-- merge, remove
					local group2 = groups[g + 1]
					for i = 1, #group2 do
						tinsert(group, group2[i])
					end
					tremove(groups, g + 1)
				end
			end

			self:AddDeathEntry(group, true)
		end
	end
end

function DeathNote:AddDeathEntry(entry, check_threshold)
	-- ungroup groups with just one entry
	if self:IsEntryGroup(entry) and #entry == 1 then
		entry = entry[1]
	end

	if check_threshold and not self:IsEntryOverThreshold(entry) then
		return
	end

	local line = self:FormatEntry(entry)

	if line then
		local nline = self.logframe:AddLine(line, entry)

		if entry.highlight_spellid then
			local highlight = self.SurvivalColors[self.SurvivalIDs[entry.highlight_spellid].class]
			self.logframe:SetLineHighlight(nline, highlight)
		end
	end
end

function DeathNote:RefreshDeath()
	local count = self.logframe:GetLineCount()

	for i = 1, count do
		self.logframe:UpdateLine(i, self:FormatEntry(self.logframe:GetLineUserdata(i)))
	end
end

function DeathNote:RefreshFilters()
	if self.current_death then
		self:ShowDeath(self.current_death)
	end
end

function DeathNote:AddSpellFilter(entry)
	if self:IsEntryGroup(entry) then
		return
	end

	local _, spellname = self:GetEntrySpell(entry)

	if spellname then
		self.settings.display_filters.spell_filter[string.lower(spellname)] = spellname
		LibStub("AceConfigDialog-3.0"):Open("Death Note - Others", self.others_tab)
		self:RefreshFilters()
		self:ShowFiltersTab(4)
	end
end

function DeathNote:AddSourceFilter(entry)
	if self:IsEntryGroup(entry) then
		return
	end

	local source = entry.sourceName or ""

	self.settings.display_filters.source_filter[string.lower(source)] = source
	LibStub("AceConfigDialog-3.0"):Open("Death Note - Others", self.others_tab)
	self:RefreshFilters()
	self:ShowFiltersTab(4)
end

function DeathNote:SetSpellHilight(entry)
	if self:IsEntryGroup(entry) then
		return
	end

	local spellid = self:GetEntrySpell(entry)

	self.current_source_hilight = nil
	self.current_spell_hilight = self.current_spell_hilight ~= spellid and spellid or nil

	self:RefreshHighlight()
end

function DeathNote:SetSourceHilight(entry)
	if self:IsEntryGroup(entry) then
		return
	end

	local source = entry.sourceGUID

	self.current_source_hilight = self.current_source_hilight ~= source and source or nil
	self.current_spell_hilight = nil

	self:RefreshHighlight()
end

function DeathNote:RefreshHighlight()
	for i = 1, self.logframe:GetLineCount() do
		local entry = self.logframe:GetLineUserdata(i)
		local line_highlight = nil
		if entry.highlight_spellid then
			if (not DeathNote.settings.display_filters.ignored_highlight_survival[entry.highlight_spellid]) then
				line_highlight = self.SurvivalColors[self.SurvivalIDs[entry.highlight_spellid].class];
			end
		end

		if self:IsEntryGroup(entry) then
		else
			local spellid,spellName = self:GetEntrySpell(entry)
			local source = entry.sourceGUID

			if self.current_spell_hilight and self.current_spell_hilight == spellid then
				self.logframe:SetLineHighlight(i, spell_hilight)
			elseif self.current_source_hilight and self.current_source_hilight == source then
				self.logframe:SetLineHighlight(i, source_hilight)
			else
				self.logframe:SetLineHighlight(i, line_highlight)
			end
			if (DeathNote.settings.quick_spell_search.only_hl) then
				if (self.settings.searchbox_text ~= nil and self.settings.searchbox_text ~= "") then
					if (spellName and type(spellName) == "string" and spellName:lower():find(self.settings.searchbox_text:lower())) then
						self.logframe:SetLineHighlight(i, { r = 0.5, g  = 0.5, b = 0.5, a = 0.4 })
					end
				end
			end
		end
	end
end

------------------------------------------------------------------------------
-- Display filters
------------------------------------------------------------------------------

function DeathNote:SetDisplayFilter(filter, value)
	if filter == "spell_filter" or filter == "source_filter" then
		local result = {}
		value = string.gsub(value, "^%s*(.-)%s*$", "%1")
		if #value > 0 then
			for v in string.gmatch(value, "([^,]+),?") do
				local r = string.gsub(v, "^%s*(.-)%s*$", "%1") or ""
				result[string.lower(r)] = r
			end
		end
		value = result
	end

	self.settings.display_filters[filter] = value

	self:RefreshFilters()
end

------------------------------------------------------------------------------
-- ListBox
------------------------------------------------------------------------------

local function ListBox_Column_Dragger_OnLeave(frame)
	frame.background:SetColorTexture(0.7, 0.7, 0.7, 0.8)
end

local function ListBox_Column_Dragger_OnEnter(frame)
	frame.background:SetColorTexture(1, 1, 1, 1)
end

local function ListBox_Column_Dragger_OnMouseDown(frame)
	local lastcol = frame.obj.columns[#frame.obj.columns]

	frame.prev:SetResizeBounds(0, 0, frame.prev:GetWidth() + lastcol:GetWidth(), 1)

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
	local self = frame.obj
	local prev = frame.prev
	local prevprev = frame.prevprev

	prev:StopMovingOrSizing()
	prev:SetUserPlaced(false)

	ListBox_PlaceColumn(self, prev, prevprev, prev:GetWidth())

	if self.columns_callback then
		local t = {}
		for i = 1, #self.columns - 1 do
			tinsert(t, self.columns[i]:GetWidth())
		end
		self.columns_callback(t)
	end
end

local function ListBox_AddColumn(self, label, align, width)
	local column = CreateFrame("Frame", nil, self.iframe)
	column.align = align
	column:SetResizable(true)
	column:SetResizeBounds(10, 1)

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
		dragger.background:SetColorTexture(0.7, 0.7, 0.7, 0.8)

		dragger.obj = self
		dragger.prev = prev
		dragger.prevprev = self.columns[#self.columns - 1]

		dragger:EnableMouse(true)
		dragger:SetScript("OnMouseDown", ListBox_Column_Dragger_OnMouseDown)
		dragger:SetScript("OnMouseUp", ListBox_Column_Dragger_OnMouseUp)
		dragger:SetScript("OnEnter", ListBox_Column_Dragger_OnEnter)
		dragger:SetScript("OnLeave", ListBox_Column_Dragger_OnLeave)
	end

	tinsert(self.columns, column)
end

local function ListBox_SetMouseCallbacks(self, onmouseup, onenter, onleave)
	self.column_onmouseup = onmouseup
	self.column_onenter = onenter
	self.column_onleave = onleave
end

local function ListBox_Column_OnMouseUp(frame, button)
	if frame.line.obj.column_onmouseup then
		frame.line.obj.column_onmouseup(button, frame.nline, frame.column, frame.line.userdata)
	end
end

local function ListBox_Column_OnEnter(frame)
	if not frame.line.static_hili then
		frame.line.hili:Show()
	else
		frame.line.hili:SetColorTexture(normal_hilight.r, normal_hilight.g, normal_hilight.b, normal_hilight.a)
	end

	if frame.line.obj.column_onenter then
		frame.line.obj.column_onenter(frame.column, frame.line.userdata)
	end
end

local function ListBox_Column_OnLeave(frame)
	if not frame.line.static_hili then
		frame.line.hili:Hide()
	else
		frame.line.hili:SetColorTexture(frame.line.static_hili.r, frame.line.static_hili.g, frame.line.static_hili.b, frame.line.static_hili.a)
	end

	if frame.line.obj.column_onleave then
		frame.line.obj.column_onleave(frame.column, frame.line.userdata)
	end
end

local function ListBox_Line_Column_OnSizeChanged(frame)
	if frame.bartex then
		if frame.value and frame.value[1] > 0 then

			local v1 = math.min(1, (frame.value[1] - max(0, frame.value[2])))
			local v2 = abs(frame.value[2])
			local width1 = (frame:GetWidth() - 2) * v1
			local width2 = (frame:GetWidth() - 2) * math.min(1 - v1, v2)

			-- weird stuff happens when setting width = 0
			if width1 == 0 then 
				width1 = 1e-10
			end
			if width2 == 0 then
				width2 = 1e-10
			end

			frame.bartex:SetWidth(width1)
			frame.bartex:Show()


			if width2 > 0 then
				frame.bartex2:SetWidth(width2)
				if frame.value[2] > 0 then
					frame.bartex2:SetColorTexture(0, 1, 0)
				else
					frame.bartex2:SetColorTexture(1, 0, 0)
				end

				frame.bartex2:Show()
			else
				frame.bartex2:Hide()
			end
		else
			frame.bartex:Hide()
			frame.bartex2:Hide()
		end
	end
end

local function ListBox_ScrollFrame_OnSizeChanged(frame)
	local self = frame.obj

	-- Update Scrollbar
	local height = self.scrollframe:GetHeight()
	local content_height = #self.lines * 12 + 8

	self.content:SetHeight(content_height)

	local cscale = self.content:GetScale()

	content_height = content_height * cscale


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

	if IsControlKeyDown() then
		local scale = self.content:GetScale() + 0.05 * -value
		if scale >= 0.5 and scale <= 2.0 then
			self:SetScale(scale)
		end
	else
		local l, h = self.scrollbar:GetMinMaxValues()
		self.scrollbar:SetValue(min(max(self.scrollbar:GetValue() - value * 36 * self.content:GetScale(), l), h))
	end
end

local function ListBox_ScrollBar_OnValueChanged(frame, value)
	local self = frame.obj

	value = value / self.content:GetScale()
	self.content:SetPoint("TOPLEFT", 0, value)
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
		hili:Hide()
		hili:SetColorTexture(normal_hilight.r, normal_hilight.g, normal_hilight.b, normal_hilight.a)
		hili:SetAllPoints()
		hili:SetBlendMode("ADD")
		line.hili = hili

		line.columns = {}
		for i, c in ipairs(self.columns) do
			local f = CreateFrame("Frame", nil, line)
			f.nline = nline
			f.line = line
			f.column = i
			f:SetHeight(12)
			f:SetPoint("TOP", line, "TOP")
			--f:SetPoint("BOTTOM", line, "BOTTOM")
			f:SetPoint("LEFT", c, "LEFT", 3, 0)
			f:SetPoint("RIGHT", c, "RIGHT", -3, 0)
			f:SetScript("OnMouseUp", ListBox_Column_OnMouseUp)
			f:SetScript("OnEnter", ListBox_Column_OnEnter)
			f:SetScript("OnLeave", ListBox_Column_OnLeave)

			line.columns[i] = f
		end

		tinsert(self.line_cache, line)
	end

	tinsert(self.lines, line)

	return line
end

local function ListBox_AddLine(self, values, userdata)
	local line = self:CreateLine()

	line.userdata = userdata

	self:UpdateLine(#self.lines, values)

	return #self.lines
end

local function ListBox_UpdateComplete(self)
	ListBox_ScrollFrame_OnSizeChanged(self.scrollframe)

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

		self.lines[nline]:Show()
	end
end

local function ListBox_UpdateLine(self, nline, values)
	local line = self.lines[nline]

	for i, c in ipairs(self.columns) do
		if type(values[i]) == "table" then
			if line.columns[i].fs then
				line.columns[i].fs:Hide()
			end

			if not line.columns[i].bartex then
				line.columns[i]:SetScript("OnSizeChanged", ListBox_Line_Column_OnSizeChanged)
				line.columns[i].bartex = line.columns[i]:CreateTexture(nil, "BACKGROUND")
				line.columns[i].bartex:SetPoint("TOPLEFT", line.columns[i], "TOPLEFT", 1, -3)
				line.columns[i].bartex:SetPoint("BOTTOM", line.columns[i], "BOTTOM", 0, 3)
				line.columns[i].bartex:SetColorTexture(0, 0.7, 0.9)

				line.columns[i].bartex2 = line.columns[i]:CreateTexture(nil, "BACKGROUND")
				line.columns[i].bartex2:SetPoint("TOPLEFT", line.columns[i].bartex, "TOPRIGHT")
				line.columns[i].bartex2:SetPoint("BOTTOMLEFT", line.columns[i].bartex, "BOTTOMRIGHT")
				line.columns[i].bartex2:Show()
			end

			line.columns[i].bartex:Show()
			line.columns[i].bartex2:Show()
			line.columns[i].value = values[i]
			ListBox_Line_Column_OnSizeChanged(line.columns[i])
			line.columns[i]:SetScript("OnSizeChanged", ListBox_Line_Column_OnSizeChanged)
		else
			if line.columns[i].bartex then
				line.columns[i]:SetScript("OnSizeChanged", nil)
				line.columns[i].bartex:Hide()
				line.columns[i].bartex2:Hide()
				line.columns[i].value = nil
			end

			if not line.columns[i].fs then
				local fs = line.columns[i]:CreateFontString(nil, "OVERLAY")
				fs:SetAllPoints(line.columns[i])
				fs:SetFontObject(GameFontNormalSmall)
				fs:SetShadowColor(0, 0, 0, 0)
				fs:SetJustifyH(c.align)
				line.columns[i].fs = fs
			end

			line.columns[i].fs:Show()
			line.columns[i].fs:SetText(values[i])
		end
	end
end

local function ListBox_SetLineHighlight(self, nline, color)
	local line = self.lines[nline]
	local prev = line.static_hili

	if color then
		line.static_hili = color
		line.hili:SetColorTexture(color.r, color.g, color.b, color.a)
		line.hili:Show()
	elseif line.static_hili then
		line.static_hili = nil
		line.hili:SetColorTexture(normal_hilight.r, normal_hilight.g, normal_hilight.b, normal_hilight.a)
		line.hili:Hide()
	end

	return prev
end

local function ListBox_ClearAllLines(self)
	for i = 1, #self.lines do
		self.lines[i].userdata = nil
		self.lines[i].static_hili = nil
		self.lines[i].hili:SetColorTexture(normal_hilight.r, normal_hilight.g, normal_hilight.b, normal_hilight.a)
		self.lines[i].hili:Hide()
		self.lines[i]:Hide()
	end

	wipe(self.lines)
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

local function ListBox_SetSettingsCallback(self, columns_callback, scale_callback)
	self.columns_callback = columns_callback
	self.scale_callback = scale_callback
end

local function ListBox_SetScale(self, scale)
	self.content:SetScale(scale)

	ListBox_ScrollFrame_OnSizeChanged(self.scrollframe)

	if self.scale_callback then
		self.scale_callback(scale)
	end
end

function DeathNote:CreateListBox(parent, scale)
	local frame = CreateFrame("ScrollFrame", nil, parent)

	local iframe = CreateFrame("Frame", nil, frame, BackdropTemplateMixin and "BackdropTemplate")
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
	scrollframe:SetScript("OnSizeChanged", ListBox_ScrollFrame_OnSizeChanged)

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
	scrollbg:SetColorTexture(0, 0, 0, 1)

	local content = CreateFrame("Frame", nil, scrollframe)
	scrollframe:SetScrollChild(content)
	content:SetPoint("TOPLEFT")
	content:SetPoint("TOPRIGHT", -16, 0)
	content:SetScale(scale)

	local headersep = CreateFrame("Frame", nil, iframe, BackdropTemplateMixin and "BackdropTemplate")
	headersep:SetHeight(16)
	headersep:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, -22)
	headersep:SetPoint("RIGHT")
	headersep:SetBackdrop(DraggerBackdrop)
	headersep:SetBackdropColor(1, 1, 1, 1)

	local listbox = {
		AddColumn = ListBox_AddColumn,
		AddLine = ListBox_AddLine,
		ClearAllLines = ListBox_ClearAllLines,
		SetSettingsCallback = ListBox_SetSettingsCallback,
		SetMouseCallbacks = ListBox_SetMouseCallbacks,
		CreateLine = ListBox_CreateLine,
		ScrollToBottom = ListBox_ScrollToBottom,
		GetLineCount = ListBox_GetLineCount,
		GetLineUserdata = ListBox_GetLineUserdata,
		UpdateLine = ListBox_UpdateLine,
		SetLineHighlight = ListBox_SetLineHighlight,
		UpdateComplete = ListBox_UpdateComplete,
		SetScale = ListBox_SetScale,

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
	iframe.obj = listbox
	scrollbar.obj = listbox
	scrollframe.obj = listbox

	return listbox
end
