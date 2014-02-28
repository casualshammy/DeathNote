local L

local debug = false
--@debug@
debug = true
--@end-debug@

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "enUS", true, not debug)

if L then
L["General"] = true
L["Show in the unit popup menu (requires a UI reload)"] = true
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = true
L["%s|r has died of a heart attack"] = true
L["You were killed by"] = true
L["%s|r was killed by"] = true
L["%s's|r %s"] = true -- <source>'s <spell>
L["%i more deaths were not announced"] = true
L["Data has been reset"] = true
L["Data optimization done in %.02f ms"] = true
L["Death Note"] = true
L["Show target deaths"] = true
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = true
L["Death Note: Death report for %s at %s"] = true
L["Limiting report to %i lines"] = true
L["<Refresh>"] = true
L["<Break>"] = true
L["<Dispel>"] = true
L["<Dispel failed>"] = true
L["<Steal>"] = true
L["<Interrupt>"] = true
L["Miss"] = true
L["Death"] = true
L["None"] = true
L["Unknown"] = true
L["(%i more lines not shown)"] = true
L["-%s (%i hits) (%s)"] = true
L["+%s (%i heals) (%s)"] = true
L["(%s overkill)"] = true
L["<+%i buffs>"] = true
L["<+%i debuffs>"] = true
L["<-%i buffs>"] = true
L["<-%i debuffs>"] = true
L["Data capture"] = true
L["Maximum number of deaths"] = true
L["Seconds to keep before each death (for the unit killed)"] = true
L["Seconds to keep before each death (for other units)"] = true
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = true
L["Units filters"] = true
L["Check the units you are interested in. Data for the units not filtered is discarded."] = true
L["Group players"] = true
L["Party and raid members, including yourself"] = true
L["Your pet"] = true
L["Other pets"] = true
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = true
L["Friendly players"] = true
L["All friendly players, including those not in your group"] = true
L["Enemy players"] = true
L["Friendly NPCs"] = true
L["Enemy NPCs"] = true
L["Keep data between sessions"] = true
L["Enable this if you want the data to persist after logging out or after a reload ui.\nKeep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times."] = true
L["Reset data"] = true
L["Announce"] = true
L["Announce deaths"] = true
L["Announce deaths with an unknown cause"] = true
L["Announces/10 seconds limit"] = true
L["Output channel"] = true
L["Chat frame"] = true
L["Say"] = true
L["Party"] = true
L["Raid"] = true
L["Battleground"] = true
L["Group (party or raid)"] = true
L["Raid Warning"] = true
L["Guild"] = true
L["Officer"] = true
L["Whisper"] = true
L["Combat log lines"] = true
L["Formatted"] = true
L["Formatted style options"] = true
L["Include damage"] = true
L["Include amount resisted/blocked/absorbed"] = true
L["Include hit type (critical, crushing, etc)"] = true
L["Include overkill"] = true
L["Filters"] = true
L["Damage"] = true
L["Threshold"] = true
L["Consolidate consecutive hits"] = true
L["Hide misses"] = true
L["Healing"] = true
L["Consolidate consecutive heals"] = true
L["Auras"] = true
L["Buff gains"] = true
L["Buff fades"] = true
L["Debuff gains"] = true
L["Debuff fades"] = true
L["Survival cooldowns"] = true
L["Highlight survival cooldowns"] = true
L["Consolidate consecutive auras"] = true
L["Others"] = true
L["Spell filter"] = true
L["Enter one or more spells, separated by commas.\nCtrl+Click on a spell column to add that spell."] = true
L["Source filter"] = true
L["Enter one or more sources, separated by commas.\nCtrl+Click on a source column to add that source."] = true
L["Reset"] = true
L["Time"] = true
L["HP"] = true
L["Amount"] = true
L["Spell"] = true
L["Source"] = true
L["Setting scale to %i%%"] = true
L["Show Death Note"] = true
L["Report style"] = true
L["Send report from this line"] = true
L["Compact"] = true
L["Whisper target"] = true
L["Channel"] = true
L["Sort deaths by"] = true
L["Time format"] = true
L["Health format"] = true
L["Options"] = true
L["Seconds from death"] = true
L["Real time"] = true
L["Bar"] = true
L["HP %"] = true
L["HP"] = true
L["HP/HPMax"] = true
L["Name"] = true
L["%i deaths"] = true
L["Scale: %i%%"] = true
L["Increase scale"] = true
L["Decrease scale"] = true
end



-- Other translations are added from the WowAce project page
L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "deDE")
if L then
--@localization(locale="deDE", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "esES")
if L then
--@localization(locale="esES", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "esMX")
if L then
--@localization(locale="esMX", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "frFR")
if L then
--@localization(locale="frFR", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "koKR")
if L then
--@localization(locale="koKR", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "ruRU")
if L then
--@localization(locale="ruRU", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "zhCN")
if L then
--@localization(locale="zhCN", format="lua_additive_table", same-key-is-true="true")@
end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "zhTW")
if L then
--@localization(locale="zhTW", format="lua_additive_table", same-key-is-true="true")@
end