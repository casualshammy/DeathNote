function DeathNote:AnnounceDeath(death)
	if not self.settings.announce.enabled then
		return
	end
	
	local entry, damage, overkill, school, resisted, blocked, absorbed, critical, glancing, crushing =  DeathNote:GetKillingBlow(death)
	
	local isoutputchat = self.settings.announce.channel ~= "CHATFRAME"	
	local text
	
	if not entry then
		if self.settings.announce.announce_unknown then
			text = string.format("%s|r has died of a heart attack", self:FormatUnit(death[2], death[3], death[4]))
		else
			return
		end
	else
		
		if self.settings.announce.style == "COMBAT_LOG" then
			text = self:FormatCombatLog(entry)
		elseif self.settings.announce.style == "FORMATTED" then
			local source = self:FormatUnit(entry[5], entry[6], entry[7])
			local spell = isoutputchat and self:FormatChatSpell(entry) or self:FormatEntrySpell(entry)
			
			if source ~= "" then
				text = string.format("%s|r was killed by %s's|r %s", self:FormatUnit(death[2], death[3], death[4]), source, spell)
			else
				text = string.format("%s|r was killed by %s", self:FormatUnit(death[2], death[3], death[4]), spell)
			end
			
			if self.settings.announce.format_damage then
				if damage > 0 then
					text = text .. string.format(" (%i %s", damage, DAMAGE)
				end
			end
			
			if self.settings.announce.format_hittype then
				if critical then
					text = text .. " " .. TEXT_MODE_A_STRING_RESULT_CRITICAL
				end
				if glancing then
					text = text .. " " .. TEXT_MODE_A_STRING_RESULT_GLANCING
				end
				if crushing then
					text = text .. " " .. TEXT_MODE_A_STRING_RESULT_CRUSHING
				end
			end

			if self.settings.announce.format_damage then
				text = text .. ") "
			end
			
			if self.settings.announce.format_resisted then
				if resisted and resisted > 0 then
					text = text .. string.format(TEXT_MODE_A_STRING_RESULT_RESIST, resisted) .. " "
				end
				if blocked and blocked > 0 then
					text = text .. string.format(TEXT_MODE_A_STRING_RESULT_BLOCK, blocked) .. " "
				end
				if absorbed and absorbed > 0 then
					text = text .. string.format(TEXT_MODE_A_STRING_RESULT_ABSORB, absorbed) .. " "
				end
			end
			
			if self.settings.announce.format_overkill then
				if overkill and overkill > 0 then
					text = text .. string.format(TEXT_MODE_A_STRING_RESULT_OVERKILLING, overkill)
				end
			end
			
			text = string.gsub(text, "^%s*(.-)%s*$", "%1") -- trim spaces
		end
	end
	
	if isoutputchat then
		text = self:CleanForChat(text)
	end
	
	self:Print(text)
end