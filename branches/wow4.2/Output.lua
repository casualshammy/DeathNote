local L = LibStub("AceLocale-3.0"):GetLocale("DeathNote")

local outputs = {}

function DeathNote:O_RegisterOutput(output)
	outputs[output.key] = output
end

function DeathNote:O_IsChatOutput(key)
	return outputs[key].is_chat
end

function DeathNote:O_Send(key, msg)
	local output = outputs[key]
	output.func(msg, output.arg)
end

do
	local function printmessage(msg)
		DeathNote:Print(msg)
	end

	local function chatmessage(msg, arg)
		local ispvp = select(2, IsInInstance()) == "pvp"
		local israid = GetNumRaidMembers() > 0
		local isparty = GetNumPartyMembers() > 0
		
		if (arg == "PARTY" and not isparty) or
		   (arg == "RAID" and not israid) or		   
		   (arg == "BATTLEGROUND" and not ispvp) or
		   (arg == "RAID_WARNING" and not IsPartyLeader()) then
			return
		end
		
		SendChatMessage(msg, arg)
	end

	local function groupmessage(msg)
		if GetNumRaidMembers() > 0 then
			SendChatMessage(msg, "RAID")
		elseif GetNumPartyMembers() > 0 then
			SendChatMessage(msg, "PARTY")
		end
	end
	
	local function whispermessage(msg)
		if UnitExists(msg[1]) then
			SendChatMessage(msg[2], "WHISPER", nil, msg[1])
		end
	end
	
	DeathNote:O_RegisterOutput {
		key = "CHATFRAME",
		name = L["Chat frame"],
		func = printmessage
	}

	DeathNote:O_RegisterOutput {
		key = "SAY",
		name = L["Say"],
		is_chat = true,
		func = chatmessage,
		arg = "SAY",
	}

	DeathNote:O_RegisterOutput {
		key = "PARTY",
		name = L["Party"],
		is_chat = true,
		func = chatmessage,
		arg = "PARTY",
	}

	DeathNote:O_RegisterOutput {
		key = "RAID",
		name = L["Raid"],
		is_chat = true,
		func = chatmessage,
		arg = "RAID",
	}

	DeathNote:O_RegisterOutput {
		key = "BATTLEGROUND",
		name = L["Battleground"],
		is_chat = true,
		func = chatmessage,
		arg = "BATTLEGROUND",
	}

	DeathNote:O_RegisterOutput {
		key = "GROUP",
		name = L["Group (party or raid)"],
		is_chat = true,
		func = groupmessage,
	}

	DeathNote:O_RegisterOutput {
		key = "RW",
		name = L["Raid Warning"],
		is_chat = true,
		func = chatmessage,
		arg = "RAID_WARNING",
	}

	DeathNote:O_RegisterOutput {
		key = "GUILD",
		name = L["Guild"],
		is_chat = true,
		func = chatmessage,
		arg = "GUILD",
	}

	DeathNote:O_RegisterOutput {
		key = "OFFICER",
		name = L["Officer"],
		is_chat = true,
		func = chatmessage,
		arg = "OFFICER",
	}
	
	DeathNote:O_RegisterOutput {
		key = "WHISPER",
		name = L["Whisper"],
		is_chat = true,
		func = whispermessage,
	}
end
