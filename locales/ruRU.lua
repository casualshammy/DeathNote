local L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "ruRU");
L = L or {}
--[===[@non-debug@
@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="L")@
--@end-non-debug@]===]
--@debug@
L = L or {}
L["%i deaths"] = "%i смертей"
--[[Translation missing --]]
L["%i more deaths were not announced"] = "%i more deaths were not announced"
--[[Translation missing --]]
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
--[[Translation missing --]]
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
--[[Translation missing --]]
L["%s|r was killed by"] = "%s|r was killed by"
--[[Translation missing --]]
L["%s's|r %s"] = "%s's|r %s"
--[[Translation missing --]]
L["(%i more lines not shown)"] = "(%i more lines not shown)"
--[[Translation missing --]]
L["(%s overkill)"] = "(%s overkill)"
--[[Translation missing --]]
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
--[[Translation missing --]]
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
--[[Translation missing --]]
L["<-%i buffs>"] = "<-%i buffs>"
--[[Translation missing --]]
L["<-%i debuffs>"] = "<-%i debuffs>"
--[[Translation missing --]]
L["<+%i buffs>"] = "<+%i buffs>"
--[[Translation missing --]]
L["<+%i debuffs>"] = "<+%i debuffs>"
--[[Translation missing --]]
L["<Break>"] = "<Break>"
--[[Translation missing --]]
L["<Dispel failed>"] = "<Dispel failed>"
--[[Translation missing --]]
L["<Dispel>"] = "<Dispel>"
--[[Translation missing --]]
L["<Interrupt>"] = "<Interrupt>"
--[[Translation missing --]]
L["<Refresh>"] = "<Refresh>"
--[[Translation missing --]]
L["<Steal>"] = "<Steal>"
--[[Translation missing --]]
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
L["Amount"] = "Количество"
L["Announce"] = "Объявления"
L["Announce deaths"] = "Объявлять смерти"
--[[Translation missing --]]
L["Announce deaths in LFR"] = "Announce deaths in LFR"
L["Announce deaths with an unknown cause"] = "Объявлять смерти по неизвестной причине"
L["Announces/10 seconds limit"] = "Лимит объявлений за период в 10 секунд"
L["Auras"] = "Ауры"
L["Bar"] = "Полоски"
L["Battleground"] = "Поле боя"
L["Buff fades"] = "Окончание баффа"
L["Buff gains"] = "Получение баффа"
L["Channel"] = "Канал"
--[[Translation missing --]]
L["Chat frame"] = "Chat frame"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Отметьте те группы, которые вам интересны. Данные по остальным группам записаны не будут."
L["Combat log lines"] = "Как в журнале боя"
--[[Translation missing --]]
L["Compact"] = "Compact"
L["Consolidate consecutive auras"] = "Объединить последовательные ауры"
L["Consolidate consecutive heals"] = "Объединить последовательное исцеление"
L["Consolidate consecutive hits"] = "Объединить последовательный урон"
L["Damage"] = "Урон"
L["Data capture"] = "Запись данных"
L["Data has been reset"] = "Данные будут сброшены"
L["Data optimization done in %.02f ms"] = "Данные оптимизируются через %.02f мс"
L["Death"] = "Смерть"
L["Death Note"] = "Death Note"
--[[Translation missing --]]
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
L["Debuff fades"] = "Окончание дебаффа"
L["Debuff gains"] = "Получение дебаффа"
L["Decrease scale"] = "Уменьшить масштаб"
--[[Translation missing --]]
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
--[[Translation missing --]]
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "Враждебные NPC"
L["Enemy players"] = "Враждебные игроки"
--[[Translation missing --]]
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
--[[Translation missing --]]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
L["Filters"] = "Фильтры"
L["Formatted"] = "Отформатированные"
L["Formatted style options"] = "Настройки форматирования"
L["Friendly NPCs"] = "NPC-союзники"
L["Friendly players"] = "Игроки-союзники"
L["General"] = "Общее"
--[[Translation missing --]]
L["Group (party or raid)"] = "Group (party or raid)"
L["Group players"] = "Игроки в группе (рейде)"
L["Guild"] = "Гильдия"
L["Healing"] = "Исцеление"
L["Health format"] = "Вид ХП"
L["Hide misses"] = "Скрыть промахи"
L["Highlight survival cooldowns"] = "Подсвечивать защитные способности"
L["HP"] = "Количество ХП"
L["HP %"] = "Процент ХП"
L["HP/HPMax"] = "ХП / макс. ХП"
L["Include amount resisted/blocked/absorbed"] = "Включать количество отраженного/заблокированного/поглощенного"
L["Include damage"] = "Включать урон"
L["Include hit type (critical, crushing, etc)"] = "Включать тип урона (критический, сокрушающий и т.п.)"
L["Include overkill"] = "Включать избыточный урон (overkill)"
L["Increase scale"] = "Увеличить масштаб"
L["Keep data between sessions"] = "Сохранять данные между сессиями"
--[[Translation missing --]]
L["Limiting report to %i lines"] = "Limiting report to %i lines"
L["Maximum number of deaths"] = "Макс. количество смертей"
L["Miss"] = "Промах"
L["Name"] = "Имя"
L["None"] = "Пусто"
L["Officer"] = "Офицер"
L["Options"] = "Настройки"
L["Other pets"] = "Другие питомцы"
L["Others"] = "Другое"
L["Output channel"] = "Канал вывода"
--[[Translation missing --]]
L["Party"] = "Party"
--[[Translation missing --]]
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
L["Raid"] = "Рейд"
--[[Translation missing --]]
L["Raid Warning"] = "Raid Warning"
L["Real time"] = "Реальное время"
L["Report style"] = "Формат отчета"
L["Reset"] = "Сбросить"
L["Reset data"] = "Сбросить данные"
L["Say"] = "Сказать"
L["Scale: %i%%"] = "Масштаб: %i%%"
L["Seconds from death"] = "Секунды до смерти"
--[[Translation missing --]]
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
L["Seconds to keep before each death (for the unit killed)"] = "Сколько секунд записывать перед каждой смертью (для убитого существа)"
--[[Translation missing --]]
L["selector:search"] = "Search:"
L["Send report from this line"] = "Послать отчет из этой строки"
L["Setting scale to %i%%"] = "Установить шкалу в %i%%"
L["Show Death Note"] = "Показать Посмертную Заметку"
L["Show in the unit popup menu (requires a UI reload)"] = "Показывать в выпадающем меню игроков (требуется перезагрузка UI)"
--[[Translation missing --]]
L["Show target deaths"] = "Show target deaths"
L["Sort deaths by"] = "Сортировать смерти по..."
L["Source"] = "Источник"
L["Source filter"] = "Фильтр источников"
L["Spell"] = "Заклинание"
L["Spell filter"] = "Фильтр заклинаний"
L["Survival cooldowns"] = "Защитные способности"
--[[Translation missing --]]
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
--[[Translation missing --]]
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
L["Threshold"] = "Порог"
L["Time"] = "Время"
L["Time format"] = "Формат времени"
--[[Translation missing --]]
L["ui:filters:select-cds"] = "Select CDs..."
L["ui:quick-spell-search"] = "Поиск заклинания:"
L["ui:quick-spell-search:mode:highlight"] = "подсвечивать найденные заклинания"
L["ui:quick-spell-search:mode:only-found-spells"] = "показывать только найденные заклинания + КД"
L["Units filters"] = "Фильтр существ"
L["Unknown"] = "Неизвестно"
L["Whisper"] = "Шепот"
L["Whisper target"] = "Шепнуть цели"
L["You were killed by"] = "Вы были убиты "
L["Your pet"] = "Ваш питомец"


--@end-debug@