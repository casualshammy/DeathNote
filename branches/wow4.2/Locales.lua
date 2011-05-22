local L

local debug = false
--@debug@
debug = true
--@end-debug@

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "enxUS", false, debug)

if L then
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

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "esES", true)
if L then
--@localization(locale="esES", format="lua_additive_table", same-key-is-true="true")@
L["%i deaths"] = "%i muertes" -- Needs review
L["%i more deaths were not announced"] = "%i muertes m\195\161s no han sido anunciadas" -- Needs review
L["%s's|r %s"] = "%2$s|r de %1$s" -- Needs review
L["%s|r has died of a heart attack"] = "%s|r ha muerto de un ataque al coraz\195\179n" -- Needs review
L["%s|r was killed by"] = "%s|r muri\195\179 por" -- Needs review
L["(%i more lines not shown)"] = "(%i lineas mas no mostradas)" -- Needs review
L["(%s overkill)"] = "(%s overkill)" -- Needs review
L["+%s (%i heals) (%s)"] = "+%s (%i sanaciones) (%s)" -- Needs review
L["-%s (%i hits) (%s)"] = "-%s (%i golpes) (%s)" -- Needs review
L["<+%i buffs>"] = "<+%i buffs>" -- Needs review
L["<+%i debuffs>"] = "<+%i debuffs>" -- Needs review
L["<-%i buffs>"] = "<-%i buffs>" -- Needs review
L["<-%i debuffs>"] = "<-%i debuffs>" -- Needs review
L["<Break>"] = "<Roto>" -- Needs review
L["<Dispel failed>"] = "<Dispel fallado>" -- Needs review
L["<Dispel>"] = "<Dispel>" -- Needs review
L["<Interrupt>"] = "<Interrupci\195\179n>"
L["<Refresh>"] = "<Restablecido>" -- Needs review
L["<Steal>"] = "<Robado>" -- Needs review
L["All friendly players, including those not in your group"] = "Todos los jugadores amistosos, incluidos los que no est\195\161n en tu grupo" -- Needs review
L["Amount"] = "Cantidad" -- Needs review
L["Announce"] = "Anunciar" -- Needs review
L["Announce deaths"] = "Anunciar muertes" -- Needs review
L["Announce deaths with an unknown cause"] = "Anunciar muertes cuya causa es desconocida" -- Needs review
L["Announces/10 seconds limit"] = "Limite de anuncios cada 10 segundos" -- Needs review
L["Auras"] = "Auras" -- Needs review
L["Bar"] = "Barra" -- Needs review
L["Battleground"] = "Campo de batalla" -- Needs review
L["Buff fades"] = "Buffs perdidos" -- Needs review
L["Buff gains"] = "Buffs ganados" -- Needs review
L["Channel"] = "Canal" -- Needs review
L["Chat frame"] = "Chat" -- Needs review
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Marca la unidades en las que estas interesado. Los datos para las unidades no filtradas se deshecha." -- Needs review
L["Combat log lines"] = "Lineas de registro de combate" -- Needs review
L["Compact"] = "Compacto" -- Needs review
L["Consolidate consecutive auras"] = "Consolidar auras consecutivas" -- Needs review
L["Consolidate consecutive heals"] = "Consolidar sanaciones consecutivas" -- Needs review
L["Consolidate consecutive hits"] = "Consolidar golpes consecutivos" -- Needs review
L["Damage"] = "Da\195\177o" -- Needs review
L["Data capture"] = "Captura de datos" -- Needs review
L["Data has been reset"] = "Los datos han sido reiniciados" -- Needs review
L["Data optimization done in %.02f ms"] = "Optimizaci\195\179n de datos realizada en %.02f ms" -- Needs review
L["Death"] = "Muerte" -- Needs review
L["Death Note"] = "Death Note" -- Needs review
L["Death Note: Death report for %s at %s"] = "Death Note: Reporte de la muerte de %s a las %s" -- Needs review
L["Debuff fades"] = "Debuffs perdidos" -- Needs review
L["Debuff gains"] = "Debuffs ganados" -- Needs review
L["Decrease scale"] = "Reducir escala" -- Needs review
L["Enable this if you want the data to persist after logging out or after a reload ui.\
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times."] = "Activa esto si quieres que los datos persistan entre sesiones." -- Needs review
L["Enemy NPCs"] = "NPJs enemigos" -- Needs review
L["Enemy players"] = "Jugadores enemigos" -- Needs review
L["Enter one or more sources, separated by commas.\
Ctrl+Click on a source column to add that source."] = "Introduce uno o mas or\195\173genes, separados por comas.\
Ctrl+Click en una columna de origen para a\195\177adir ese origen." -- Needs review
L["Enter one or more spells, separated by commas.\
Ctrl+Click on a spell column to add that spell."] = "Introduce una o mas habilidades, separadas por comas.\
Ctrl+Click en una columna de habilidad para a\195\177adir esa habilidad." -- Needs review
L["Filters"] = "Filtros" -- Needs review
L["Formatted"] = "Formateado" -- Needs review
L["Formatted style options"] = "Opciones de estilo formateado" -- Needs review
L["Friendly NPCs"] = "NPJs amistosos" -- Needs review
L["Friendly players"] = "Jugadores amistosos" -- Needs review
L["Group (party or raid)"] = "Grupo (grupo o banda)" -- Needs review
L["Group players"] = "Jugadores en tu grupo" -- Needs review
L["Guild"] = "Hermandad" -- Needs review
L["HP"] = "PVS" -- Needs review
L["HP %"] = "PVS %" -- Needs review
L["HP/HPMax"] = "PVS/Max PVS" -- Needs review
L["Healing"] = "Sanaci\195\179n" -- Needs review
L["Health format"] = "Formato de vida" -- Needs review
L["Hide misses"] = "Ocultar fallos" -- Needs review
L["Highlight survival cooldowns"] = "Resaltar cooldowns de supervivencia" -- Needs review
L["Include amount resisted/blocked/absorbed"] = "Incluir cantidad resistida/bloqueada/absorbida" -- Needs review
L["Include damage"] = "Incluir da\195\177o" -- Needs review
L["Include hit type (critical, crushing, etc)"] = "Incluir tipo de golpe (cr\195\173tico, aplastamiento, etc)" -- Needs review
L["Include overkill"] = "Incluir overkill" -- Needs review
L["Increase scale"] = "Incrementar escala" -- Needs review
L["Keep data between sessions"] = "Mantener datos entre sesiones" -- Needs review
L["Limiting report to %i lines"] = "Limitando reporte a %i lineas" -- Needs review
L["Maximum number of deaths"] = "M\195\161ximo n\195\186mero de muertes" -- Needs review
L["Miss"] = "Fallo" -- Needs review
L["Name"] = "Nombre" -- Needs review
L["None"] = "Ninguno" -- Needs review
L["Officer"] = "Oficial" -- Needs review
L["Options"] = "Opciones" -- Needs review
L["Other pets"] = "Mascotas de otros" -- Needs review
L["Others"] = "Otros" -- Needs review
L["Output channel"] = "Canal de salida" -- Needs review
L["Party"] = "Grupo" -- Needs review
L["Party and raid members, including yourself"] = "Miembros de grupo y banda, incluy\195\169ndote a ti mismo" -- Needs review
L["Raid"] = "Banda" -- Needs review
L["Raid Warning"] = "Aviso de banda" -- Needs review
L["Real time"] = "Tiempo real" -- Needs review
L["Report style"] = "Estilo de reporte" -- Needs review
L["Reset"] = "Reiniciar" -- Needs review
L["Reset data"] = "Reiniciar datos" -- Needs review
L["Say"] = "Hablar" -- Needs review
L["Scale: %i%%"] = "Escala: %i%%" -- Needs review
L["Seconds from death"] = "Segundos desde la muerte" -- Needs review
L["Seconds to keep before each death (for other units)"] = "Segundos a mantener antes de cada muerte (para otras unidades)" -- Needs review
L["Seconds to keep before each death (for the unit killed)"] = "Segundos a mantener antes de cada muerte (para la unidad muerta)" -- Needs review
L["Send report from this line"] = "Enviar reporte desde esta l\195\173nea" -- Needs review
L["Setting scale to %i%%"] = "Estableciendo escala a %i%%" -- Needs review
L["Show Death Note"] = "Mostrar Death Note" -- Needs review
L["Show target deaths"] = "Mostrar muertes de tu objetivo" -- Needs review
L["Sort deaths by"] = "Ordenar muertes por" -- Needs review
L["Source"] = "Origen" -- Needs review
L["Source filter"] = "Filtro de origen" -- Needs review
L["Spell"] = "Habilidad" -- Needs review
L["Spell filter"] = "Filtro de habilidades" -- Needs review
L["Survival cooldowns"] = "Cooldowns de supervivencia" -- Needs review
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "El efecto de este filtro depende de los otros filtros. Por ejemplo, si tienes el filtro de jugadores amistosos desactivado, las muertes de sus mascotas no ser\195\161n guardadas tampoco, incluso con este filtro activo." -- Needs review
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "Estos datos son usados para mostrar las acciones de otros jugadores cuando ocurre una muerte. Ponlo a 0 a no ser que uses esta funcionalidad, ya que puede usar una gran cantidad de memoria." -- Needs review
L["Threshold"] = "Umbral" -- Needs review
L["Time"] = "Tiempo" -- Needs review
L["Time format"] = "Formato del tiempo" -- Needs review
L["Units filters"] = "Filtros de unidades" -- Needs review
L["Unknown"] = "Desconocido" -- Needs review
L["Whisper"] = "Susurro" -- Needs review
L["Whisper target"] = "Susurro a tu objetivo" -- Needs review
L["You were killed by"] = "Tu moriste por" -- Needs review
L["Your pet"] = "Tu mascota" -- Needs review
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r para abrir Death Note. |cFFEDA55FClick derecho|r para mostrar opciones. |cFFEDA55FShift+Click|r para optimizar datos. |cFFEDA55FCtrl+Click|r para reiniciar datos." -- Needs review
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