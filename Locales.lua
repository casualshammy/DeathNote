local L

local debug = false
--@debug@
debug = true
--@end-debug@

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "enUS", true, not debug)

if L then
L = L or {}
L["%i deaths"] = "%i deaths"
L["%i more deaths were not announced"] = "%i more deaths were not announced"
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
L["%s|r was killed by"] = "%s|r was killed by"
L["%s's|r %s"] = "%s's|r %s"
L["(%i more lines not shown)"] = "(%i more lines not shown)"
L["(%s overkill)"] = "(%s overkill)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
L["<-%i buffs>"] = "<-%i buffs>"
L["<-%i debuffs>"] = "<-%i debuffs>"
L["<+%i buffs>"] = "<+%i buffs>"
L["<+%i debuffs>"] = "<+%i debuffs>"
L["<Break>"] = "<Break>"
L["<Dispel failed>"] = "<Dispel failed>"
L["<Dispel>"] = "<Dispel>"
L["<Interrupt>"] = "<Interrupt>"
L["<Refresh>"] = "<Refresh>"
L["<Steal>"] = "<Steal>"
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
L["Amount"] = "Amount"
L["Announce"] = "Announce"
L["Announce deaths"] = "Announce deaths"
L["Announce deaths with an unknown cause"] = "Announce deaths with an unknown cause"
L["Announces/10 seconds limit"] = "Announces/10 seconds limit"
L["Auras"] = "Auras"
L["Bar"] = "Bar"
L["Battleground"] = "Battleground"
L["Buff fades"] = "Buff fades"
L["Buff gains"] = "Buff gains"
L["Channel"] = "Channel"
L["Chat frame"] = "Chat frame"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Check the units you are interested in. Data for the units not filtered is discarded."
L["Combat log lines"] = "Combat log lines"
L["Compact"] = "Compact"
L["Consolidate consecutive auras"] = "Consolidate consecutive auras"
L["Consolidate consecutive heals"] = "Consolidate consecutive heals"
L["Consolidate consecutive hits"] = "Consolidate consecutive hits"
L["Damage"] = "Damage"
L["Data capture"] = "Data capture"
L["Data has been reset"] = "Data has been reset"
L["Data optimization done in %.02f ms"] = "Data optimization done in %.02f ms"
L["Death"] = "Death"
L["Death Note"] = "Death Note"
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
L["Debuff fades"] = "Debuff fades"
L["Debuff gains"] = "Debuff gains"
L["Decrease scale"] = "Decrease scale"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "Enemy NPCs"
L["Enemy players"] = "Enemy players"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
L["Filters"] = "Filters"
L["Formatted"] = "Formatted"
L["Formatted style options"] = "Formatted style options"
L["Friendly NPCs"] = "Friendly NPCs"
L["Friendly players"] = "Friendly players"
L["General"] = "General"
L["Group (party or raid)"] = "Group (party or raid)"
L["Group players"] = "Group players"
L["Guild"] = "Guild"
L["Healing"] = "Healing"
L["Health format"] = "Health format"
L["Hide misses"] = "Hide misses"
L["Highlight survival cooldowns"] = "Highlight survival cooldowns"
L["HP"] = "HP"
L["HP %"] = "HP %"
L["HP/HPMax"] = "HP/HPMax"
L["Include amount resisted/blocked/absorbed"] = "Include amount resisted/blocked/absorbed"
L["Include damage"] = "Include damage"
L["Include hit type (critical, crushing, etc)"] = "Include hit type (critical, crushing, etc)"
L["Include overkill"] = "Include overkill"
L["Increase scale"] = "Increase scale"
L["Keep data between sessions"] = "Keep data between sessions"
L["Limiting report to %i lines"] = "Limiting report to %i lines"
L["Maximum number of deaths"] = "Maximum number of deaths"
L["Miss"] = "Miss"
L["Name"] = "Name"
L["None"] = "None"
L["Officer"] = "Officer"
L["Options"] = "Options"
L["Other pets"] = "Other pets"
L["Others"] = "Others"
L["Output channel"] = "Output channel"
L["Party"] = "Party"
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
L["Raid"] = "Raid"
L["Raid Warning"] = "Raid Warning"
L["Real time"] = "Real time"
L["Report style"] = "Report style"
L["Reset"] = "Reset"
L["Reset data"] = "Reset data"
L["Say"] = "Say"
L["Scale: %i%%"] = "Scale: %i%%"
L["Seconds from death"] = "Seconds from death"
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
L["Seconds to keep before each death (for the unit killed)"] = "Seconds to keep before each death (for the unit killed)"
L["Send report from this line"] = "Send report from this line"
L["Setting scale to %i%%"] = "Setting scale to %i%%"
L["Show Death Note"] = "Show Death Note"
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
L["Show target deaths"] = "Show target deaths"
L["Sort deaths by"] = "Sort deaths by"
L["Source"] = "Source"
L["Source filter"] = "Source filter"
L["Spell"] = "Spell"
L["Spell filter"] = "Spell filter"
L["Survival cooldowns"] = "Survival cooldowns"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
L["Threshold"] = "Threshold"
L["Time"] = "Time"
L["Time format"] = "Time format"
L["ui:quick-spell-search"] = "Quick spell search:"
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "Units filters"
L["Unknown"] = "Unknown"
L["Whisper"] = "Whisper"
L["Whisper target"] = "Whisper target"
L["You were killed by"] = "You were killed by"
L["Your pet"] = "Your pet"

end



-- Other translations are added from the WowAce project page
L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "deDE")
if L then
L = L or {}
L["%i deaths"] = "%i Tode"
L["%i more deaths were not announced"] = "%i weitere Tode wurden nicht angekündigt"
L["-%s (%i hits) (%s)"] = "-%s (%i Treffer) (%s)"
L["%s|r has died of a heart attack"] = "%s|r ist an einer Herzattacke gestorben"
L["%s|r was killed by"] = "%s|r ist gestorben durch"
L["%s's|r %s"] = "%s's|r %s"
L["(%i more lines not shown)"] = "(%i weitere Zeilen nicht angezeigt)"
L["(%s overkill)"] = "(%s über Tod)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FLinksklick|r um Death Note zu öffnen. |cFFEDA55FRechtsklick|r um die Einstellungen zu zeigen. |cFFEDA55FUmschalt-Linksklick|r um die Daten zu optimieren. |cFFEDA55FStrg-Linksklick|r um die Daten zurückzusetzen."
L["+%s (%i heals) (%s)"] = "+%s (%i Heilungen) (%s)"
L["<-%i buffs>"] = "<-%i Stärkungszauber>"
L["<-%i debuffs>"] = "<-%i Schwächungszauber>"
L["<+%i buffs>"] = "<+%i Stärkungszauber>"
L["<+%i debuffs>"] = "<+%i Schwächungszauber>"
L["<Break>"] = "<Gebrochen>"
L["<Dispel failed>"] = "<Entzauberung fehlgeschlagen>"
L["<Dispel>"] = "<Entzaubert>"
L["<Interrupt>"] = "<Unterbrochen>"
L["<Refresh>"] = "<Erneuert>"
L["<Steal>"] = "<Gestohlen>"
L["All friendly players, including those not in your group"] = "Alle freundlichen Spieler, inklusive derer nicht in deiner Gruppe"
L["Amount"] = "Menge"
L["Announce"] = "Ankündigen"
L["Announce deaths"] = "Tode ankündigen"
L["Announce deaths with an unknown cause"] = "Tode mit unbekannten Gründen ankündigen"
L["Announces/10 seconds limit"] = "Ankündigungen/10 Sekunden Limit"
L["Auras"] = "Auren"
L["Bar"] = "Leiste"
L["Battleground"] = "Schlachtfeld"
L["Buff fades"] = "Stärkungszauber schwindet"
L["Buff gains"] = "Stärkungszauber erhalten"
L["Channel"] = "Kanal"
L["Chat frame"] = "Chatfenster"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Markiere die Einheiten, an denen du interessiert bist. Daten von nicht markierten Einheiten werden verworfen."
L["Combat log lines"] = "Kampflogzeilen"
L["Compact"] = "Kompakt"
L["Consolidate consecutive auras"] = "Aufeinander folgende Auren zusammenfassen"
L["Consolidate consecutive heals"] = "Aufeinander folgende Heilungen zusammenfassen"
L["Consolidate consecutive hits"] = "Aufeinander folgende Treffer zusammenfassen"
L["Damage"] = "Schaden"
L["Data capture"] = "Datensammlung"
L["Data has been reset"] = "Daten wurden zurückgesetzt"
L["Data optimization done in %.02f ms"] = "Datenoptimierung in %.02f ms abgeschlossen"
L["Death"] = "Tode"
L["Death Note"] = "Death Note"
L["Death Note: Death report for %s at %s"] = "Death Note: Todesbericht für %s um %s"
L["Debuff fades"] = "Schwächungszauber schwindet"
L["Debuff gains"] = "Schwächungszauber erhalten"
L["Decrease scale"] = "Skalierung reduzieren"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Aktiviere dies, falls du die Daten über das Ausloggen oder Neuladen des UI hinweg behalten willst.
Denk daran, dass dies je nach Einstellungen eine sehr große SavedVariables-Datei erzeugen kann und die Zeiten für das Ein-/Ausloggen und Neuladen des UI beeinflussen kann.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "Feindliche NSCs"
L["Enemy players"] = "Feindliche Spieler"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Gebe eine oder mehrere Quellen, getrennt durch Kommas, ein.
Strg+Linksklick auf eine Quellzeile um diese hinzuzufügen.]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Gebe eine oder mehrere Zauber, getrennt durch Kommas, ein.
Strg+Linksklick auf eine Zauberzeile um diese hinzuzufügen.]=]
L["Filters"] = "Filter"
L["Formatted"] = "Formatiert"
L["Formatted style options"] = "Formatierungsstil Einstellungen"
L["Friendly NPCs"] = "Freundliche NSCs"
L["Friendly players"] = "Freundliche Spieler"
L["General"] = "Allgemein"
L["Group (party or raid)"] = "Gruppe (Gruppe oder Schlachtzug)"
L["Group players"] = "Gruppenspieler"
L["Guild"] = "Gilde"
L["Healing"] = "Heilung"
L["Health format"] = "Gesundheitsformat"
L["Hide misses"] = "Verfehlen verstecken"
L["Highlight survival cooldowns"] = "Überlebensfähigkeiten hervorheben"
L["HP"] = "HP"
L["HP %"] = "HP %"
L["HP/HPMax"] = "HP/HPMax"
L["Include amount resisted/blocked/absorbed"] = "Widerstandene/Geblockte/Absorbierte Menge einfügen"
L["Include damage"] = "Schaden einfügen"
L["Include hit type (critical, crushing, etc)"] = "Trefferart (kritisch, schmetternd, etc.) einfügen"
L["Include overkill"] = "Über Tod einfügen"
L["Increase scale"] = "Skalierung erhöhen"
L["Keep data between sessions"] = "Daten zwischen Sitzungen behalten"
L["Limiting report to %i lines"] = "Begrenze Bericht auf %i Zeilen"
L["Maximum number of deaths"] = "Maximale Anzahl Tode"
L["Miss"] = "Verfehlen"
L["Name"] = "Name"
L["None"] = "Keine"
L["Officer"] = "Offizier"
L["Options"] = "Einstellungen"
L["Other pets"] = "Andere Begleiter"
L["Others"] = "Andere"
L["Output channel"] = "Ausgabekanal"
L["Party"] = "Gruppe"
L["Party and raid members, including yourself"] = "Gruppen- und Schlachtzugsmitglieder (inklusive dir selbst)"
L["Raid"] = "Schlachtzug"
L["Raid Warning"] = "Schlachtzugswarnung"
L["Real time"] = "Echtzeit"
L["Report style"] = "Berichtsstil"
L["Reset"] = "Zurücksetzen"
L["Reset data"] = "Daten zurücksetzen"
L["Say"] = "Sagen"
L["Scale: %i%%"] = "Skalierung: %i%%"
L["Seconds from death"] = "Sekunden vor Tod"
L["Seconds to keep before each death (for other units)"] = "Zu speichernde Sekunden vor dem Tod (für andere Einheiten)"
L["Seconds to keep before each death (for the unit killed)"] = "Zu speichernde Sekunden vor dem Tod (für die getötete Einheit)"
L["Send report from this line"] = "Sende Bericht ab dieser Zeile"
L["Setting scale to %i%%"] = "Setze Skalierung auf %i%%"
L["Show Death Note"] = "Zeige Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
L["Show target deaths"] = "Zeige Tode vom Ziel"
L["Sort deaths by"] = "Sortiere Tode nach"
L["Source"] = "Quelle"
L["Source filter"] = "Quellenfilter"
L["Spell"] = "Zauber"
L["Spell filter"] = "Zauberfilter"
L["Survival cooldowns"] = "Überlebensfähigkeit"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "Die Wirksamkeit dieses Filters hängt von den anderen Filtern ab. Zum Beispiel, wenn der freundliche Spieler Filter inaktiv ist, werden deren Begleitertode nicht aufgezeichnet, selbst wenn dieser Filter aktiv ist."
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "Diese Daten werden zur Anzeige von Aktionen anderer Spieler genutzt, wenn ein Tod geschah. Setze diesen Wert auf 0 außer du willst diese Funktion nutzen, da sie viel Speicher benötigt."
L["Threshold"] = "Grenzwert"
L["Time"] = "Zeit"
L["Time format"] = "Zeitformat"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "Einheitenfilter"
L["Unknown"] = "Unbekannt"
L["Whisper"] = "Flüstern"
L["Whisper target"] = "Ziel anflüstern"
L["You were killed by"] = "Du bist gestorben durch"
L["Your pet"] = "Dein Begleiter"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "esES")
if L then
L = L or {}
L["%i deaths"] = "%i muertes"
L["%i more deaths were not announced"] = "%i muertes más no han sido anunciadas"
L["-%s (%i hits) (%s)"] = "-%s (%i golpes) (%s)"
L["%s|r has died of a heart attack"] = "%s|r ha muerto de un ataque al corazón"
L["%s|r was killed by"] = "%s|r murió por"
L["%s's|r %s"] = "%2$s|r de %1$s"
L["(%i more lines not shown)"] = "(%i lineas más no mostradas)"
L["(%s overkill)"] = "(%s overkill)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r para abrir Death Note. |cFFEDA55FClick derecho|r para mostrar opciones. |cFFEDA55FShift+Click|r para optimizar datos. |cFFEDA55FCtrl+Click|r para reiniciar datos."
L["+%s (%i heals) (%s)"] = "+%s (%i sanaciones) (%s)"
L["<-%i buffs>"] = "<-%i buffs>"
L["<-%i debuffs>"] = "<-%i debuffs>"
L["<+%i buffs>"] = "<+%i buffs>"
L["<+%i debuffs>"] = "<+%i debuffs>"
L["<Break>"] = "<Roto>"
L["<Dispel failed>"] = "<Dispel fallado>"
L["<Dispel>"] = "<Dispel>"
L["<Interrupt>"] = "<Interrupción>"
L["<Refresh>"] = "<Restablecido>"
L["<Steal>"] = "<Robado>"
L["All friendly players, including those not in your group"] = "Todos los jugadores amistosos, incluidos los que no están en tu grupo"
L["Amount"] = "Cantidad"
L["Announce"] = "Anunciar"
L["Announce deaths"] = "Anunciar muertes"
L["Announce deaths with an unknown cause"] = "Anunciar muertes cuya causa es desconocida"
L["Announces/10 seconds limit"] = "Limite de anuncios cada 10 segundos"
L["Auras"] = "Auras"
L["Bar"] = "Barra"
L["Battleground"] = "Campo de batalla"
L["Buff fades"] = "Buffs perdidos"
L["Buff gains"] = "Buffs ganados"
L["Channel"] = "Canal"
L["Chat frame"] = "Chat"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Marca la unidades en las que estas interesado. Los datos para las unidades no filtradas se deshecha."
L["Combat log lines"] = "Lineas de registro de combate"
L["Compact"] = "Compacto"
L["Consolidate consecutive auras"] = "Consolidar auras consecutivas"
L["Consolidate consecutive heals"] = "Consolidar sanaciones consecutivas"
L["Consolidate consecutive hits"] = "Consolidar golpes consecutivos"
L["Damage"] = "Daño"
L["Data capture"] = "Captura de datos"
L["Data has been reset"] = "Los datos han sido reiniciados"
L["Data optimization done in %.02f ms"] = "Optimización de datos realizada en %.02f ms"
L["Death"] = "Muerte"
L["Death Note"] = "Death Note"
L["Death Note: Death report for %s at %s"] = "Death Note: Reporte de la muerte de %s a las %s"
L["Debuff fades"] = "Debuffs perdidos"
L["Debuff gains"] = "Debuffs ganados"
L["Decrease scale"] = "Reducir escala"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = "Activa esto si quieres que los datos persistan entre sesiones."
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "NPJs enemigos"
L["Enemy players"] = "Jugadores enemigos"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Introduce uno o más orígenes, separados por comas.
Ctrl+Click en una columna de origen para añadir ese origen.]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Introduce una o más habilidades, separadas por comas.
Ctrl+Click en una columna de habilidad para añadir esa habilidad.]=]
L["Filters"] = "Filtros"
L["Formatted"] = "Formateado"
L["Formatted style options"] = "Opciones de estilo formateado"
L["Friendly NPCs"] = "NPJs amistosos"
L["Friendly players"] = "Jugadores amistosos"
--Translation missing 
L["General"] = "General"
L["Group (party or raid)"] = "Grupo (grupo o banda)"
L["Group players"] = "Jugadores en tu grupo"
L["Guild"] = "Hermandad"
L["Healing"] = "Sanación"
L["Health format"] = "Formato de vida"
L["Hide misses"] = "Ocultar fallos"
L["Highlight survival cooldowns"] = "Resaltar cooldowns de supervivencia"
L["HP"] = "PVS"
L["HP %"] = "PVS %"
L["HP/HPMax"] = "PVS/Max PVS"
L["Include amount resisted/blocked/absorbed"] = "Incluir cantidad resistida/bloqueada/absorbida"
L["Include damage"] = "Incluir daño"
L["Include hit type (critical, crushing, etc)"] = "Incluir tipo de golpe (crítico, aplastamiento, etc)"
L["Include overkill"] = "Incluir overkill"
L["Increase scale"] = "Incrementar escala"
L["Keep data between sessions"] = "Mantener datos entre sesiones"
L["Limiting report to %i lines"] = "Limitando reporte a %i lineas"
L["Maximum number of deaths"] = "Máximo número de muertes"
L["Miss"] = "Fallo"
L["Name"] = "Nombre"
L["None"] = "Ninguno"
L["Officer"] = "Oficial"
L["Options"] = "Opciones"
L["Other pets"] = "Mascotas de otros"
L["Others"] = "Otros"
L["Output channel"] = "Canal de salida"
L["Party"] = "Grupo"
L["Party and raid members, including yourself"] = "Miembros de grupo y banda, incluyéndote a ti mismo"
L["Raid"] = "Banda"
L["Raid Warning"] = "Aviso de banda"
L["Real time"] = "Tiempo real"
L["Report style"] = "Estilo de reporte"
L["Reset"] = "Reiniciar"
L["Reset data"] = "Reiniciar datos"
L["Say"] = "Hablar"
L["Scale: %i%%"] = "Escala: %i%%"
L["Seconds from death"] = "Segundos desde la muerte"
L["Seconds to keep before each death (for other units)"] = "Segundos a mantener antes de cada muerte (para otras unidades)"
L["Seconds to keep before each death (for the unit killed)"] = "Segundos a mantener antes de cada muerte (para la unidad muerta)"
L["Send report from this line"] = "Enviar reporte desde esta línea"
L["Setting scale to %i%%"] = "Estableciendo escala a %i%%"
L["Show Death Note"] = "Mostrar Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
L["Show target deaths"] = "Mostrar muertes de tu objetivo"
L["Sort deaths by"] = "Ordenar muertes por"
L["Source"] = "Origen"
L["Source filter"] = "Filtro de origen"
L["Spell"] = "Habilidad"
L["Spell filter"] = "Filtro de habilidades"
L["Survival cooldowns"] = "Cooldowns de supervivencia"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "El efecto de este filtro depende de los otros filtros. Por ejemplo, si tienes el filtro de jugadores amistosos desactivado, las muertes de sus mascotas no serán guardadas tampoco, incluso con este filtro activo."
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "Estos datos son usados para mostrar las acciones de otros jugadores cuando ocurre una muerte. Ponlo a 0 a no ser que uses esta funcionalidad, ya que puede usar una gran cantidad de memoria."
L["Threshold"] = "Umbral"
L["Time"] = "Tiempo"
L["Time format"] = "Formato del tiempo"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "Filtros de unidades"
L["Unknown"] = "Desconocido"
L["Whisper"] = "Susurro"
L["Whisper target"] = "Susurro a tu objetivo"
L["You were killed by"] = "Tu moriste por"
L["Your pet"] = "Tu mascota"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "esMX")
if L then
L = L or {}
--Translation missing 
L["%i deaths"] = "%i deaths"
--Translation missing 
L["%i more deaths were not announced"] = "%i more deaths were not announced"
--Translation missing 
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
--Translation missing 
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
--Translation missing 
L["%s|r was killed by"] = "%s|r was killed by"
--Translation missing 
L["%s's|r %s"] = "%s's|r %s"
--Translation missing 
L["(%i more lines not shown)"] = "(%i more lines not shown)"
--Translation missing 
L["(%s overkill)"] = "(%s overkill)"
--Translation missing 
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
--Translation missing 
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
--Translation missing 
L["<-%i buffs>"] = "<-%i buffs>"
--Translation missing 
L["<-%i debuffs>"] = "<-%i debuffs>"
--Translation missing 
L["<+%i buffs>"] = "<+%i buffs>"
--Translation missing 
L["<+%i debuffs>"] = "<+%i debuffs>"
--Translation missing 
L["<Break>"] = "<Break>"
--Translation missing 
L["<Dispel failed>"] = "<Dispel failed>"
--Translation missing 
L["<Dispel>"] = "<Dispel>"
--Translation missing 
L["<Interrupt>"] = "<Interrupt>"
--Translation missing 
L["<Refresh>"] = "<Refresh>"
--Translation missing 
L["<Steal>"] = "<Steal>"
--Translation missing 
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
--Translation missing 
L["Amount"] = "Amount"
--Translation missing 
L["Announce"] = "Announce"
--Translation missing 
L["Announce deaths"] = "Announce deaths"
--Translation missing 
L["Announce deaths with an unknown cause"] = "Announce deaths with an unknown cause"
--Translation missing 
L["Announces/10 seconds limit"] = "Announces/10 seconds limit"
--Translation missing 
L["Auras"] = "Auras"
--Translation missing 
L["Bar"] = "Bar"
--Translation missing 
L["Battleground"] = "Battleground"
--Translation missing 
L["Buff fades"] = "Buff fades"
--Translation missing 
L["Buff gains"] = "Buff gains"
--Translation missing 
L["Channel"] = "Channel"
--Translation missing 
L["Chat frame"] = "Chat frame"
--Translation missing 
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Check the units you are interested in. Data for the units not filtered is discarded."
--Translation missing 
L["Combat log lines"] = "Combat log lines"
--Translation missing 
L["Compact"] = "Compact"
--Translation missing 
L["Consolidate consecutive auras"] = "Consolidate consecutive auras"
--Translation missing 
L["Consolidate consecutive heals"] = "Consolidate consecutive heals"
--Translation missing 
L["Consolidate consecutive hits"] = "Consolidate consecutive hits"
--Translation missing 
L["Damage"] = "Damage"
--Translation missing 
L["Data capture"] = "Data capture"
--Translation missing 
L["Data has been reset"] = "Data has been reset"
--Translation missing 
L["Data optimization done in %.02f ms"] = "Data optimization done in %.02f ms"
--Translation missing 
L["Death"] = "Death"
--Translation missing 
L["Death Note"] = "Death Note"
--Translation missing 
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
--Translation missing 
L["Debuff fades"] = "Debuff fades"
--Translation missing 
L["Debuff gains"] = "Debuff gains"
--Translation missing 
L["Decrease scale"] = "Decrease scale"
--Translation missing 
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
--Translation missing 
L["Enemy NPCs"] = "Enemy NPCs"
--Translation missing 
L["Enemy players"] = "Enemy players"
--Translation missing 
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
--Translation missing 
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
--Translation missing 
L["Filters"] = "Filters"
--Translation missing 
L["Formatted"] = "Formatted"
--Translation missing 
L["Formatted style options"] = "Formatted style options"
--Translation missing 
L["Friendly NPCs"] = "Friendly NPCs"
--Translation missing 
L["Friendly players"] = "Friendly players"
--Translation missing 
L["General"] = "General"
--Translation missing 
L["Group (party or raid)"] = "Group (party or raid)"
--Translation missing 
L["Group players"] = "Group players"
--Translation missing 
L["Guild"] = "Guild"
--Translation missing 
L["Healing"] = "Healing"
--Translation missing 
L["Health format"] = "Health format"
--Translation missing 
L["Hide misses"] = "Hide misses"
--Translation missing 
L["Highlight survival cooldowns"] = "Highlight survival cooldowns"
--Translation missing 
L["HP"] = "HP"
--Translation missing 
L["HP %"] = "HP %"
--Translation missing 
L["HP/HPMax"] = "HP/HPMax"
--Translation missing 
L["Include amount resisted/blocked/absorbed"] = "Include amount resisted/blocked/absorbed"
--Translation missing 
L["Include damage"] = "Include damage"
--Translation missing 
L["Include hit type (critical, crushing, etc)"] = "Include hit type (critical, crushing, etc)"
--Translation missing 
L["Include overkill"] = "Include overkill"
--Translation missing 
L["Increase scale"] = "Increase scale"
--Translation missing 
L["Keep data between sessions"] = "Keep data between sessions"
--Translation missing 
L["Limiting report to %i lines"] = "Limiting report to %i lines"
--Translation missing 
L["Maximum number of deaths"] = "Maximum number of deaths"
--Translation missing 
L["Miss"] = "Miss"
--Translation missing 
L["Name"] = "Name"
--Translation missing 
L["None"] = "None"
--Translation missing 
L["Officer"] = "Officer"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Other pets"] = "Other pets"
--Translation missing 
L["Others"] = "Others"
--Translation missing 
L["Output channel"] = "Output channel"
--Translation missing 
L["Party"] = "Party"
--Translation missing 
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
--Translation missing 
L["Raid"] = "Raid"
--Translation missing 
L["Raid Warning"] = "Raid Warning"
--Translation missing 
L["Real time"] = "Real time"
--Translation missing 
L["Report style"] = "Report style"
--Translation missing 
L["Reset"] = "Reset"
--Translation missing 
L["Reset data"] = "Reset data"
--Translation missing 
L["Say"] = "Say"
--Translation missing 
L["Scale: %i%%"] = "Scale: %i%%"
--Translation missing 
L["Seconds from death"] = "Seconds from death"
--Translation missing 
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
--Translation missing 
L["Seconds to keep before each death (for the unit killed)"] = "Seconds to keep before each death (for the unit killed)"
--Translation missing 
L["Send report from this line"] = "Send report from this line"
--Translation missing 
L["Setting scale to %i%%"] = "Setting scale to %i%%"
--Translation missing 
L["Show Death Note"] = "Show Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
--Translation missing 
L["Show target deaths"] = "Show target deaths"
--Translation missing 
L["Sort deaths by"] = "Sort deaths by"
--Translation missing 
L["Source"] = "Source"
--Translation missing 
L["Source filter"] = "Source filter"
--Translation missing 
L["Spell"] = "Spell"
--Translation missing 
L["Spell filter"] = "Spell filter"
--Translation missing 
L["Survival cooldowns"] = "Survival cooldowns"
--Translation missing 
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
--Translation missing 
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
--Translation missing 
L["Threshold"] = "Threshold"
--Translation missing 
L["Time"] = "Time"
--Translation missing 
L["Time format"] = "Time format"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
--Translation missing 
L["Units filters"] = "Units filters"
--Translation missing 
L["Unknown"] = "Unknown"
--Translation missing 
L["Whisper"] = "Whisper"
--Translation missing 
L["Whisper target"] = "Whisper target"
--Translation missing 
L["You were killed by"] = "You were killed by"
--Translation missing 
L["Your pet"] = "Your pet"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "frFR")
if L then
L = L or {}
--Translation missing 
L["%i deaths"] = "%i deaths"
--Translation missing 
L["%i more deaths were not announced"] = "%i more deaths were not announced"
--Translation missing 
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
--Translation missing 
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
--Translation missing 
L["%s|r was killed by"] = "%s|r was killed by"
--Translation missing 
L["%s's|r %s"] = "%s's|r %s"
--Translation missing 
L["(%i more lines not shown)"] = "(%i more lines not shown)"
--Translation missing 
L["(%s overkill)"] = "(%s overkill)"
--Translation missing 
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
--Translation missing 
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
--Translation missing 
L["<-%i buffs>"] = "<-%i buffs>"
--Translation missing 
L["<-%i debuffs>"] = "<-%i debuffs>"
--Translation missing 
L["<+%i buffs>"] = "<+%i buffs>"
--Translation missing 
L["<+%i debuffs>"] = "<+%i debuffs>"
--Translation missing 
L["<Break>"] = "<Break>"
--Translation missing 
L["<Dispel failed>"] = "<Dispel failed>"
--Translation missing 
L["<Dispel>"] = "<Dispel>"
--Translation missing 
L["<Interrupt>"] = "<Interrupt>"
--Translation missing 
L["<Refresh>"] = "<Refresh>"
--Translation missing 
L["<Steal>"] = "<Steal>"
--Translation missing 
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
--Translation missing 
L["Amount"] = "Amount"
--Translation missing 
L["Announce"] = "Announce"
--Translation missing 
L["Announce deaths"] = "Announce deaths"
--Translation missing 
L["Announce deaths with an unknown cause"] = "Announce deaths with an unknown cause"
--Translation missing 
L["Announces/10 seconds limit"] = "Announces/10 seconds limit"
--Translation missing 
L["Auras"] = "Auras"
--Translation missing 
L["Bar"] = "Bar"
--Translation missing 
L["Battleground"] = "Battleground"
--Translation missing 
L["Buff fades"] = "Buff fades"
--Translation missing 
L["Buff gains"] = "Buff gains"
--Translation missing 
L["Channel"] = "Channel"
--Translation missing 
L["Chat frame"] = "Chat frame"
--Translation missing 
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Check the units you are interested in. Data for the units not filtered is discarded."
--Translation missing 
L["Combat log lines"] = "Combat log lines"
--Translation missing 
L["Compact"] = "Compact"
--Translation missing 
L["Consolidate consecutive auras"] = "Consolidate consecutive auras"
--Translation missing 
L["Consolidate consecutive heals"] = "Consolidate consecutive heals"
--Translation missing 
L["Consolidate consecutive hits"] = "Consolidate consecutive hits"
--Translation missing 
L["Damage"] = "Damage"
--Translation missing 
L["Data capture"] = "Data capture"
--Translation missing 
L["Data has been reset"] = "Data has been reset"
--Translation missing 
L["Data optimization done in %.02f ms"] = "Data optimization done in %.02f ms"
--Translation missing 
L["Death"] = "Death"
--Translation missing 
L["Death Note"] = "Death Note"
--Translation missing 
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
--Translation missing 
L["Debuff fades"] = "Debuff fades"
--Translation missing 
L["Debuff gains"] = "Debuff gains"
--Translation missing 
L["Decrease scale"] = "Decrease scale"
--Translation missing 
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
--Translation missing 
L["Enemy NPCs"] = "Enemy NPCs"
--Translation missing 
L["Enemy players"] = "Enemy players"
--Translation missing 
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
--Translation missing 
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
--Translation missing 
L["Filters"] = "Filters"
--Translation missing 
L["Formatted"] = "Formatted"
--Translation missing 
L["Formatted style options"] = "Formatted style options"
--Translation missing 
L["Friendly NPCs"] = "Friendly NPCs"
--Translation missing 
L["Friendly players"] = "Friendly players"
--Translation missing 
L["General"] = "General"
--Translation missing 
L["Group (party or raid)"] = "Group (party or raid)"
--Translation missing 
L["Group players"] = "Group players"
--Translation missing 
L["Guild"] = "Guild"
--Translation missing 
L["Healing"] = "Healing"
--Translation missing 
L["Health format"] = "Health format"
--Translation missing 
L["Hide misses"] = "Hide misses"
--Translation missing 
L["Highlight survival cooldowns"] = "Highlight survival cooldowns"
--Translation missing 
L["HP"] = "HP"
--Translation missing 
L["HP %"] = "HP %"
--Translation missing 
L["HP/HPMax"] = "HP/HPMax"
--Translation missing 
L["Include amount resisted/blocked/absorbed"] = "Include amount resisted/blocked/absorbed"
--Translation missing 
L["Include damage"] = "Include damage"
--Translation missing 
L["Include hit type (critical, crushing, etc)"] = "Include hit type (critical, crushing, etc)"
--Translation missing 
L["Include overkill"] = "Include overkill"
--Translation missing 
L["Increase scale"] = "Increase scale"
--Translation missing 
L["Keep data between sessions"] = "Keep data between sessions"
--Translation missing 
L["Limiting report to %i lines"] = "Limiting report to %i lines"
--Translation missing 
L["Maximum number of deaths"] = "Maximum number of deaths"
--Translation missing 
L["Miss"] = "Miss"
--Translation missing 
L["Name"] = "Name"
--Translation missing 
L["None"] = "None"
--Translation missing 
L["Officer"] = "Officer"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Other pets"] = "Other pets"
--Translation missing 
L["Others"] = "Others"
--Translation missing 
L["Output channel"] = "Output channel"
--Translation missing 
L["Party"] = "Party"
--Translation missing 
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
--Translation missing 
L["Raid"] = "Raid"
--Translation missing 
L["Raid Warning"] = "Raid Warning"
--Translation missing 
L["Real time"] = "Real time"
--Translation missing 
L["Report style"] = "Report style"
--Translation missing 
L["Reset"] = "Reset"
--Translation missing 
L["Reset data"] = "Reset data"
--Translation missing 
L["Say"] = "Say"
--Translation missing 
L["Scale: %i%%"] = "Scale: %i%%"
--Translation missing 
L["Seconds from death"] = "Seconds from death"
--Translation missing 
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
--Translation missing 
L["Seconds to keep before each death (for the unit killed)"] = "Seconds to keep before each death (for the unit killed)"
--Translation missing 
L["Send report from this line"] = "Send report from this line"
--Translation missing 
L["Setting scale to %i%%"] = "Setting scale to %i%%"
--Translation missing 
L["Show Death Note"] = "Show Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
--Translation missing 
L["Show target deaths"] = "Show target deaths"
--Translation missing 
L["Sort deaths by"] = "Sort deaths by"
--Translation missing 
L["Source"] = "Source"
--Translation missing 
L["Source filter"] = "Source filter"
--Translation missing 
L["Spell"] = "Spell"
--Translation missing 
L["Spell filter"] = "Spell filter"
--Translation missing 
L["Survival cooldowns"] = "Survival cooldowns"
--Translation missing 
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
--Translation missing 
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
--Translation missing 
L["Threshold"] = "Threshold"
--Translation missing 
L["Time"] = "Time"
--Translation missing 
L["Time format"] = "Time format"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
--Translation missing 
L["Units filters"] = "Units filters"
--Translation missing 
L["Unknown"] = "Unknown"
--Translation missing 
L["Whisper"] = "Whisper"
--Translation missing 
L["Whisper target"] = "Whisper target"
--Translation missing 
L["You were killed by"] = "You were killed by"
--Translation missing 
L["Your pet"] = "Your pet"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "itIT")
if L then
L = L or {}
--Translation missing 
L["%i deaths"] = "%i deaths"
--Translation missing 
L["%i more deaths were not announced"] = "%i more deaths were not announced"
--Translation missing 
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
--Translation missing 
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
--Translation missing 
L["%s|r was killed by"] = "%s|r was killed by"
--Translation missing 
L["%s's|r %s"] = "%s's|r %s"
--Translation missing 
L["(%i more lines not shown)"] = "(%i more lines not shown)"
--Translation missing 
L["(%s overkill)"] = "(%s overkill)"
--Translation missing 
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
--Translation missing 
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
--Translation missing 
L["<-%i buffs>"] = "<-%i buffs>"
--Translation missing 
L["<-%i debuffs>"] = "<-%i debuffs>"
--Translation missing 
L["<+%i buffs>"] = "<+%i buffs>"
--Translation missing 
L["<+%i debuffs>"] = "<+%i debuffs>"
--Translation missing 
L["<Break>"] = "<Break>"
--Translation missing 
L["<Dispel failed>"] = "<Dispel failed>"
--Translation missing 
L["<Dispel>"] = "<Dispel>"
--Translation missing 
L["<Interrupt>"] = "<Interrupt>"
--Translation missing 
L["<Refresh>"] = "<Refresh>"
--Translation missing 
L["<Steal>"] = "<Steal>"
--Translation missing 
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
--Translation missing 
L["Amount"] = "Amount"
--Translation missing 
L["Announce"] = "Announce"
--Translation missing 
L["Announce deaths"] = "Announce deaths"
--Translation missing 
L["Announce deaths with an unknown cause"] = "Announce deaths with an unknown cause"
--Translation missing 
L["Announces/10 seconds limit"] = "Announces/10 seconds limit"
--Translation missing 
L["Auras"] = "Auras"
--Translation missing 
L["Bar"] = "Bar"
--Translation missing 
L["Battleground"] = "Battleground"
--Translation missing 
L["Buff fades"] = "Buff fades"
--Translation missing 
L["Buff gains"] = "Buff gains"
--Translation missing 
L["Channel"] = "Channel"
--Translation missing 
L["Chat frame"] = "Chat frame"
--Translation missing 
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Check the units you are interested in. Data for the units not filtered is discarded."
--Translation missing 
L["Combat log lines"] = "Combat log lines"
--Translation missing 
L["Compact"] = "Compact"
--Translation missing 
L["Consolidate consecutive auras"] = "Consolidate consecutive auras"
--Translation missing 
L["Consolidate consecutive heals"] = "Consolidate consecutive heals"
--Translation missing 
L["Consolidate consecutive hits"] = "Consolidate consecutive hits"
--Translation missing 
L["Damage"] = "Damage"
--Translation missing 
L["Data capture"] = "Data capture"
--Translation missing 
L["Data has been reset"] = "Data has been reset"
--Translation missing 
L["Data optimization done in %.02f ms"] = "Data optimization done in %.02f ms"
--Translation missing 
L["Death"] = "Death"
--Translation missing 
L["Death Note"] = "Death Note"
--Translation missing 
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
--Translation missing 
L["Debuff fades"] = "Debuff fades"
--Translation missing 
L["Debuff gains"] = "Debuff gains"
--Translation missing 
L["Decrease scale"] = "Decrease scale"
--Translation missing 
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
--Translation missing 
L["Enemy NPCs"] = "Enemy NPCs"
--Translation missing 
L["Enemy players"] = "Enemy players"
--Translation missing 
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
--Translation missing 
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
--Translation missing 
L["Filters"] = "Filters"
--Translation missing 
L["Formatted"] = "Formatted"
--Translation missing 
L["Formatted style options"] = "Formatted style options"
--Translation missing 
L["Friendly NPCs"] = "Friendly NPCs"
--Translation missing 
L["Friendly players"] = "Friendly players"
--Translation missing 
L["General"] = "General"
--Translation missing 
L["Group (party or raid)"] = "Group (party or raid)"
--Translation missing 
L["Group players"] = "Group players"
--Translation missing 
L["Guild"] = "Guild"
--Translation missing 
L["Healing"] = "Healing"
--Translation missing 
L["Health format"] = "Health format"
--Translation missing 
L["Hide misses"] = "Hide misses"
--Translation missing 
L["Highlight survival cooldowns"] = "Highlight survival cooldowns"
--Translation missing 
L["HP"] = "HP"
--Translation missing 
L["HP %"] = "HP %"
--Translation missing 
L["HP/HPMax"] = "HP/HPMax"
--Translation missing 
L["Include amount resisted/blocked/absorbed"] = "Include amount resisted/blocked/absorbed"
--Translation missing 
L["Include damage"] = "Include damage"
--Translation missing 
L["Include hit type (critical, crushing, etc)"] = "Include hit type (critical, crushing, etc)"
--Translation missing 
L["Include overkill"] = "Include overkill"
--Translation missing 
L["Increase scale"] = "Increase scale"
--Translation missing 
L["Keep data between sessions"] = "Keep data between sessions"
--Translation missing 
L["Limiting report to %i lines"] = "Limiting report to %i lines"
--Translation missing 
L["Maximum number of deaths"] = "Maximum number of deaths"
--Translation missing 
L["Miss"] = "Miss"
--Translation missing 
L["Name"] = "Name"
--Translation missing 
L["None"] = "None"
--Translation missing 
L["Officer"] = "Officer"
--Translation missing 
L["Options"] = "Options"
--Translation missing 
L["Other pets"] = "Other pets"
--Translation missing 
L["Others"] = "Others"
--Translation missing 
L["Output channel"] = "Output channel"
--Translation missing 
L["Party"] = "Party"
--Translation missing 
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
--Translation missing 
L["Raid"] = "Raid"
--Translation missing 
L["Raid Warning"] = "Raid Warning"
--Translation missing 
L["Real time"] = "Real time"
--Translation missing 
L["Report style"] = "Report style"
--Translation missing 
L["Reset"] = "Reset"
--Translation missing 
L["Reset data"] = "Reset data"
--Translation missing 
L["Say"] = "Say"
--Translation missing 
L["Scale: %i%%"] = "Scale: %i%%"
--Translation missing 
L["Seconds from death"] = "Seconds from death"
--Translation missing 
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
--Translation missing 
L["Seconds to keep before each death (for the unit killed)"] = "Seconds to keep before each death (for the unit killed)"
--Translation missing 
L["Send report from this line"] = "Send report from this line"
--Translation missing 
L["Setting scale to %i%%"] = "Setting scale to %i%%"
--Translation missing 
L["Show Death Note"] = "Show Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
--Translation missing 
L["Show target deaths"] = "Show target deaths"
--Translation missing 
L["Sort deaths by"] = "Sort deaths by"
--Translation missing 
L["Source"] = "Source"
--Translation missing 
L["Source filter"] = "Source filter"
--Translation missing 
L["Spell"] = "Spell"
--Translation missing 
L["Spell filter"] = "Spell filter"
--Translation missing 
L["Survival cooldowns"] = "Survival cooldowns"
--Translation missing 
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
--Translation missing 
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
--Translation missing 
L["Threshold"] = "Threshold"
--Translation missing 
L["Time"] = "Time"
--Translation missing 
L["Time format"] = "Time format"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
--Translation missing 
L["Units filters"] = "Units filters"
--Translation missing 
L["Unknown"] = "Unknown"
--Translation missing 
L["Whisper"] = "Whisper"
--Translation missing 
L["Whisper target"] = "Whisper target"
--Translation missing 
L["You were killed by"] = "You were killed by"
--Translation missing 
L["Your pet"] = "Your pet"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "koKR")
if L then
L = L or {}
L["%i deaths"] = "%i 죽음"
L["%i more deaths were not announced"] = "%i개의 죽음을 알리지 않았습니다"
L["-%s (%i hits) (%s)"] = "-%s (%i 적중) (%s)"
L["%s|r has died of a heart attack"] = "%s|r님이 심장마비로 죽었습니다"
L["%s|r was killed by"] = "%s|r 죽음 : "
L["%s's|r %s"] = "%s의|r %s"
L["(%i more lines not shown)"] = "(%i개의 줄 생략)"
L["(%s overkill)"] = "(%s 초과 피해)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = [=[|cFFEDA55F클릭|r Death Note 열기.
|cFFEDA55F오른쪽 클릭|r 옵션 열기.
|cFFEDA55FShift-클릭|r 데이터 최적화.
|cFFEDA55FCtrl-클릭|r 데이터 초기화.]=]
L["+%s (%i heals) (%s)"] = "+%s (%i 치유) (%s)"
L["<-%i buffs>"] = "<-%i 강화 효과>"
L["<-%i debuffs>"] = "<-%i 약화 효과>"
L["<+%i buffs>"] = "<+%i 강화 효과>"
L["<+%i debuffs>"] = "<+%i 약화 효과>"
L["<Break>"] = "<사라짐>"
L["<Dispel failed>"] = "<무효화 실패>"
L["<Dispel>"] = "<무효화>"
L["<Interrupt>"] = "<방해>"
L["<Refresh>"] = "<갱신>"
L["<Steal>"] = "<훔침>"
L["All friendly players, including those not in your group"] = "자신의 파티에 속하지 않은 사람을 포함한 모든 우호적인 플레이어"
L["Amount"] = "수치"
L["Announce"] = "알리기"
L["Announce deaths"] = "죽음 알리기"
L["Announce deaths with an unknown cause"] = "알 수 없는 이유로 인한 죽음 알리기"
L["Announces/10 seconds limit"] = "10초 동안 알릴 횟수"
L["Auras"] = "효과"
L["Bar"] = "바"
L["Battleground"] = "전장"
L["Buff fades"] = "강화 효과 사라짐"
L["Buff gains"] = "강화 효과 획득"
L["Channel"] = "채널"
L["Chat frame"] = "대화 창"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "데이터를 수집할 유닛을 선택하세요. 선택하지 않은 유닛의 데이터는 수집하지 않습니다."
L["Combat log lines"] = "전투 기록 형식"
L["Compact"] = "간편화"
L["Consolidate consecutive auras"] = "연이은 오라 통합"
L["Consolidate consecutive heals"] = "연이은 치유 통합"
L["Consolidate consecutive hits"] = "연이은 적중 통합"
L["Damage"] = "피해"
L["Data capture"] = "데이터 수집"
L["Data has been reset"] = "데이터가 초기화되었습니다"
L["Data optimization done in %.02f ms"] = "%.02fms 후 데이터 최적화 완료"
L["Death"] = "죽음"
L["Death Note"] = "Death Note"
L["Death Note: Death report for %s at %s"] = "Death Note: %2$s에서 %1$s의 죽음 보고"
L["Debuff fades"] = "약화 효과 사라짐"
L["Debuff gains"] = "약화 효과 획득"
L["Decrease scale"] = "크기 비율 줄이기"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[접속 종료나 UI 다시 불러오기 후에도 데이터가 유지되길 원하면 활성화하세요.
활성화하면 SavedVariables 파일 용량이 커지고 접속/접속 종료하거나 UI를 다시 불러올 때 시간이 더 오래 걸립니다.]=]
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "이 옵션은 유닛 팝업 메뉴에 오류를 발생시키며 주시 대상 설정같은 몇몇 옵션 작동에 문제가 생깁니다"
L["Enemy NPCs"] = "적 NPC"
L["Enemy players"] = "적 플레이어"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[콤마로 구분하여 하나 이상의 행위자를 입력하세요.
행위자 열을 Ctrl+클릭하면 행위자가 추가됩니다.]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[콤마로 구분하여 하나 이상의 주문을 입력하세요.
주문 열을 Ctrl+클릭하면 주문이 추가됩니다.]=]
L["Filters"] = "필터"
L["Formatted"] = "형식화"
L["Formatted style options"] = "형식 유형 옵션"
L["Friendly NPCs"] = "우호적 NPC"
L["Friendly players"] = "우호적 플레이어"
L["General"] = "일반"
L["Group (party or raid)"] = "그룹 (파티나 공격대)"
L["Group players"] = "파티/공격대원"
L["Guild"] = "길드"
L["Healing"] = "치유"
L["Health format"] = "생명력 형식"
L["Hide misses"] = "빗나감 숨기기"
L["Highlight survival cooldowns"] = "생존기 지속 시간 강조"
L["HP"] = "생명력"
L["HP %"] = "생명력 %"
L["HP/HPMax"] = "생명력/최대 생명력"
L["Include amount resisted/blocked/absorbed"] = "저항/방어/흡수량 포함"
L["Include damage"] = "피해 포함"
L["Include hit type (critical, crushing, etc)"] = "적중 유형 포함 (치명타, 강타 등등)"
L["Include overkill"] = "초과 피해 포함"
L["Increase scale"] = "크기 비율 늘리기"
L["Keep data between sessions"] = "세션간 데이터 유지하기"
L["Limiting report to %i lines"] = "보고서를 %i줄로 제한합니다"
L["Maximum number of deaths"] = "죽음의 최대 갯수"
L["Miss"] = "빗나감"
L["Name"] = "이름"
L["None"] = "없음"
L["Officer"] = "관리자"
L["Options"] = "옵션"
L["Other pets"] = "기타 소환수"
L["Others"] = "기타"
L["Output channel"] = "출력 채널"
L["Party"] = "파티"
L["Party and raid members, including yourself"] = "자신을 포함한 파티와 공격대원"
L["Raid"] = "공격대"
L["Raid Warning"] = "공격대 경보"
L["Real time"] = "실시간"
L["Report style"] = "보고서 형식"
L["Reset"] = "초기화"
L["Reset data"] = "데이터 초기화"
L["Say"] = "일반 대화"
L["Scale: %i%%"] = "크기 비율: %i%%"
L["Seconds from death"] = "죽음으로 부터 시간 표시 (초)"
L["Seconds to keep before each death (for other units)"] = "죽기 직전 상황을 기록할 시간 (다른 유닛)"
L["Seconds to keep before each death (for the unit killed)"] = "죽기 직전 상황을 기록할 시간 (죽은 유닛)"
L["Send report from this line"] = "이 줄의 보고서 전송하기"
L["Setting scale to %i%%"] = "크기 비율을 %i%%로 설정"
L["Show Death Note"] = "Death Note 표시"
L["Show in the unit popup menu (requires a UI reload)"] = "유닛 팝업 메뉴에 표시하기 (UI 다시 불러오기 필요)"
L["Show target deaths"] = "대상의 죽음 표시"
L["Sort deaths by"] = "죽음 정렬 형식"
L["Source"] = "행위자"
L["Source filter"] = "행위자 필터"
L["Spell"] = "주문"
L["Spell filter"] = "주문 필터"
L["Survival cooldowns"] = "생존기 지속 시간"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "이 필터의 효과는 다른 필터에 영향을 받습니다. 예를 들어, 우호적 플레이어를 비활성화 했을 때는 그들의 소환수가 죽어도 기록하지 않지만, 이 필터를 활성화하면 소환수의 죽음을 기록합니다."
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "이 데이터는 죽음이 발생했을 때 다른 플레이어의 행동을 표시하는데 사용됩니다. 값을 0으로 설정하면 많은 양의 메모리를 사용합니다."
L["Threshold"] = "임계값"
L["Time"] = "시간"
L["Time format"] = "시간 형식"
L["ui:quick-spell-search"] = "빠른 주문 검색:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "유닛 필터"
L["Unknown"] = "알 수 없음"
L["Whisper"] = "귓속말"
L["Whisper target"] = "대상에게 귓속말"
L["You were killed by"] = "당신 죽음 : "
L["Your pet"] = "당신의 소환수"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "ptBR")
if L then
L = L or {}
L["%i deaths"] = "%i mortes"
L["%i more deaths were not announced"] = "Mais %i não foram anunciadas"
L["-%s (%i hits) (%s)"] = "-%s (%i acerta) (%s)"
L["%s|r has died of a heart attack"] = "%s|r teve um ataque cardíaco"
L["%s|r was killed by"] = "%s|r foi morto(a) por"
L["%s's|r %s"] = "%s|r com %s "
L["(%i more lines not shown)"] = "(%i linhas não mostradas)"
L["(%s overkill)"] = "(%s sobredano)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r para abrir o Death Note. |cFFEDA55FClique-direito|r para opções. |cFFEDA55FShift-Clique|r para otimizar dados. |cFFEDA55FCtrl-Clique|r para apagar os dados."
L["+%s (%i heals) (%s)"] = "+%s (%i cura) (%s)"
L["<-%i buffs>"] = "<-%i bônus>"
L["<-%i debuffs>"] = "<-%i penalidade>"
L["<+%i buffs>"] = "<+%i bônus>"
L["<+%i debuffs>"] = "<+%i penalidade>"
L["<Break>"] = "<Quebra>"
L["<Dispel failed>"] = "<Dissipar falhou>"
L["<Dispel>"] = "<Dissipa>"
L["<Interrupt>"] = "<Interrompe>"
L["<Refresh>"] = "<Atualiza>"
L["<Steal>"] = "<Rouba>"
L["All friendly players, including those not in your group"] = "Todos os jogadores amigos, incluindo aqueles que não estão em seu grupo"
L["Amount"] = "Quantidade"
L["Announce"] = "Anúncios"
L["Announce deaths"] = "Anunciar mortes"
L["Announce deaths with an unknown cause"] = "Anunciar mortes com causa desconhecida"
L["Announces/10 seconds limit"] = "Anúncios/ limite de 10 segundos"
L["Auras"] = "Auras"
L["Bar"] = "Barra"
L["Battleground"] = "Campos de Batalha"
L["Buff fades"] = "Bônus acaba"
L["Buff gains"] = "Bônus dissipado"
L["Channel"] = "Canal"
L["Chat frame"] = "Quadro de conversas"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Marque as unidades de seu interesse. Dados para as outras unidades serão descartadas."
L["Combat log lines"] = "Linhas do registro de combate"
L["Compact"] = "Compacto"
L["Consolidate consecutive auras"] = "Consolidar auras consecutivas"
L["Consolidate consecutive heals"] = "Consolidar curas consecutivas"
L["Consolidate consecutive hits"] = "Consolidar acertos consecutivas"
L["Damage"] = "Dano"
L["Data capture"] = "Captura de dados"
L["Data has been reset"] = "Dados foram apagados"
L["Data optimization done in %.02f ms"] = "Otimização de dados feita em %.02f ms"
L["Death"] = "Morte"
L["Death Note"] = "Death Note"
L["Death Note: Death report for %s at %s"] = "Death Note: Relatóio da morte de %s às %s"
L["Debuff fades"] = "Penalidade dissipada"
L["Debuff gains"] = "Penalidade recebida"
L["Decrease scale"] = "Diminuir escala"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Habilite se você quer que os dados persistam após desconectar ou um reload.
Dependendo das suas opções isso pode gera um arquivo SavesVariables muito grande e isso pode impactar seu tempo de loading.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "PNJs inimigos"
L["Enemy players"] = "Jogadores Inimigos"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Digite um ou mais recursos, separados por vírgula.
Crtl+Clique em uma coluna para adicionar.]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Digite uma ou mais magias, separados por vírgula.
Crtl+Clique em uma coluna para adicionar a magia.]=]
L["Filters"] = "Filtros"
L["Formatted"] = "Formatado"
L["Formatted style options"] = "Opções do estilo formatado"
L["Friendly NPCs"] = "PNJs amigos"
L["Friendly players"] = "Jogadores amigos"
--Translation missing 
L["General"] = "General"
L["Group (party or raid)"] = "Grupo ou Raide"
L["Group players"] = "Agrupar jogadores"
L["Guild"] = "Guilda"
L["Healing"] = "Cura"
L["Health format"] = "Formatação da Vida"
L["Hide misses"] = "Esconder erros"
L["Highlight survival cooldowns"] = "Destacar recargas de sobrevivência"
L["HP"] = "PV"
L["HP %"] = "PV %"
L["HP/HPMax"] = "PV/PVMáx"
L["Include amount resisted/blocked/absorbed"] = "Incluir quantidade resistida/bloqueada/absorvida"
L["Include damage"] = "Incluir dano"
L["Include hit type (critical, crushing, etc)"] = "Incluir tipo de acerto (crítico, esmagador, etc)"
L["Include overkill"] = "Incluir sobredano"
L["Increase scale"] = "Aumentar escala"
L["Keep data between sessions"] = "Manter dados entre sessões"
L["Limiting report to %i lines"] = "Limitar relatória a %i linhas"
L["Maximum number of deaths"] = "Número máximo de mortes"
L["Miss"] = "Erro"
L["Name"] = "Nome"
L["None"] = "Nenhum"
L["Officer"] = "Oficial"
L["Options"] = "Opções"
L["Other pets"] = "Outros ajudantes"
L["Others"] = "Outros"
L["Output channel"] = "Canal de saída"
L["Party"] = "Grupo"
L["Party and raid members, including yourself"] = "Membros de grupo e raide, incluindo você mesmo"
L["Raid"] = "Raide"
L["Raid Warning"] = "Aviso de Raide"
L["Real time"] = "Tempo Real"
L["Report style"] = "Estilo do relatório"
L["Reset"] = "Resetar"
L["Reset data"] = "Apagar dados"
L["Say"] = "Dizer"
L["Scale: %i%%"] = "Escala: %i%%"
L["Seconds from death"] = "Segundos antes da morte"
L["Seconds to keep before each death (for other units)"] = "Segundos a manter antes de cada morte (para outras unidades)"
L["Seconds to keep before each death (for the unit killed)"] = "Segundos a manter antes de cada morte (para a unidade morta)"
L["Send report from this line"] = "Mandar relatório a partir dessa linha"
L["Setting scale to %i%%"] = "Definir escala para %i%%"
L["Show Death Note"] = "Mostrar Death Note"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
L["Show target deaths"] = "Mostrar mortes do alvo"
L["Sort deaths by"] = "Classificar mortes por"
L["Source"] = "Fonte"
L["Source filter"] = "Filtro de fonte"
L["Spell"] = "Magia"
L["Spell filter"] = "Filtro de magia"
L["Survival cooldowns"] = "Recargas de sobrevivência"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "O efeito disso depende de outros filtros. Por exemplo, se vcocê tem o filtro para jogadores amigos inativo, as mortes dos ajudantes deles também não serão gravadas, mesmo com esse filtro ativo."
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "Esses dados são usados para mostrar ações de outros jogadores quando uma morte acontece. Defina o valor para 0 a não ser que você quer usar essa característica, pois ela drena muita memória."
L["Threshold"] = "Limite"
L["Time"] = "Tempo"
L["Time format"] = "Formatação do tempo"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "Filtros de unidades"
L["Unknown"] = "Desconhecido"
L["Whisper"] = "Sussuro"
L["Whisper target"] = "Alvo do sussuro"
L["You were killed by"] = "Você foi morto(a) por"
L["Your pet"] = "Seu ajudante"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "ruRU")
if L then
L = L or {}
L["%i deaths"] = "%i смертей"
--Translation missing 
L["%i more deaths were not announced"] = "%i more deaths were not announced"
--Translation missing 
L["-%s (%i hits) (%s)"] = "-%s (%i hits) (%s)"
--Translation missing 
L["%s|r has died of a heart attack"] = "%s|r has died of a heart attack"
--Translation missing 
L["%s|r was killed by"] = "%s|r was killed by"
--Translation missing 
L["%s's|r %s"] = "%s's|r %s"
--Translation missing 
L["(%i more lines not shown)"] = "(%i more lines not shown)"
--Translation missing 
L["(%s overkill)"] = "(%s overkill)"
--Translation missing 
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."
--Translation missing 
L["+%s (%i heals) (%s)"] = "+%s (%i heals) (%s)"
--Translation missing 
L["<-%i buffs>"] = "<-%i buffs>"
--Translation missing 
L["<-%i debuffs>"] = "<-%i debuffs>"
--Translation missing 
L["<+%i buffs>"] = "<+%i buffs>"
--Translation missing 
L["<+%i debuffs>"] = "<+%i debuffs>"
--Translation missing 
L["<Break>"] = "<Break>"
--Translation missing 
L["<Dispel failed>"] = "<Dispel failed>"
--Translation missing 
L["<Dispel>"] = "<Dispel>"
--Translation missing 
L["<Interrupt>"] = "<Interrupt>"
--Translation missing 
L["<Refresh>"] = "<Refresh>"
--Translation missing 
L["<Steal>"] = "<Steal>"
--Translation missing 
L["All friendly players, including those not in your group"] = "All friendly players, including those not in your group"
L["Amount"] = "Количество"
L["Announce"] = "Объявления"
L["Announce deaths"] = "Объявлять смерти"
L["Announce deaths with an unknown cause"] = "Объявлять смерти по неизвестной причине"
L["Announces/10 seconds limit"] = "Лимит объявлений за период в 10 секунд"
L["Auras"] = "Ауры"
L["Bar"] = "Полоски"
L["Battleground"] = "Поле боя"
L["Buff fades"] = "Окончание баффа"
L["Buff gains"] = "Получение баффа"
L["Channel"] = "Канал"
--Translation missing 
L["Chat frame"] = "Chat frame"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "Отметьте те группы, которые вам интересны. Данные по остальным группам записаны не будут."
L["Combat log lines"] = "Как в журнале боя"
--Translation missing 
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
--Translation missing 
L["Death Note: Death report for %s at %s"] = "Death Note: Death report for %s at %s"
L["Debuff fades"] = "Окончание дебаффа"
L["Debuff gains"] = "Получение дебаффа"
L["Decrease scale"] = "Уменьшить масштаб"
--Translation missing 
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "Враждебные NPC"
L["Enemy players"] = "Враждебные игроки"
--Translation missing 
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=]
--Translation missing 
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=]
L["Filters"] = "Фильтры"
L["Formatted"] = "Отформатированные"
L["Formatted style options"] = "Настройки форматирования"
L["Friendly NPCs"] = "NPC-союзники"
L["Friendly players"] = "Игроки-союзники"
L["General"] = "Общее"
--Translation missing 
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
--Translation missing 
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
--Translation missing 
L["Party"] = "Party"
--Translation missing 
L["Party and raid members, including yourself"] = "Party and raid members, including yourself"
L["Raid"] = "Рейд"
--Translation missing 
L["Raid Warning"] = "Raid Warning"
L["Real time"] = "Реальное время"
L["Report style"] = "Формат отчета"
L["Reset"] = "Сбросить"
L["Reset data"] = "Сбросить данные"
L["Say"] = "Сказать"
L["Scale: %i%%"] = "Масштаб: %i%%"
L["Seconds from death"] = "Секунды до смерти"
--Translation missing 
L["Seconds to keep before each death (for other units)"] = "Seconds to keep before each death (for other units)"
L["Seconds to keep before each death (for the unit killed)"] = "Сколько секунд записывать перед каждой смертью (для убитого существа)"
L["Send report from this line"] = "Послать отчет из этой строки"
L["Setting scale to %i%%"] = "Установить шкалу в %i%%"
L["Show Death Note"] = "Показать Посмертную Заметку"
L["Show in the unit popup menu (requires a UI reload)"] = "Показывать в выпадающем меню игроков (требуется перезагрузка UI)"
--Translation missing 
L["Show target deaths"] = "Show target deaths"
L["Sort deaths by"] = "Сортировать смерти по..."
L["Source"] = "Источник"
L["Source filter"] = "Фильтр источников"
L["Spell"] = "Заклинание"
L["Spell filter"] = "Фильтр заклинаний"
L["Survival cooldowns"] = "Защитные способности"
--Translation missing 
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."
--Translation missing 
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."
L["Threshold"] = "Порог"
L["Time"] = "Время"
L["Time format"] = "Формат времени"
L["ui:quick-spell-search"] = "Поиск заклинания:"
L["ui:quick-spell-search:mode:highlight"] = "подсвечивать найденные заклинания"
L["ui:quick-spell-search:mode:only-found-spells"] = "показывать только найденные заклинания + КД"
L["Units filters"] = "Фильтр существ"
L["Unknown"] = "Неизвестно"
L["Whisper"] = "Шепот"
L["Whisper target"] = "Шепнуть цели"
L["You were killed by"] = "Вы были убиты "
L["Your pet"] = "Ваш питомец"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "zhCN")
if L then
L = L or {}
L["%i deaths"] = "%i 死亡"
L["%i more deaths were not announced"] = "多于%i的死亡不会被通告"
L["-%s (%i hits) (%s)"] = "-%s (%i 命中) (%s)"
L["%s|r has died of a heart attack"] = "%s|r 死于意外"
L["%s|r was killed by"] = "%s|r 死于"
L["%s's|r %s"] = "%s的|r %s"
L["(%i more lines not shown)"] = "(多于%i行不显示)"
L["(%s overkill)"] = "(%s 过量伤害)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55F点击|r 开启死亡记录。 |cFFEDA55F右键-点击|r 显示选项。 |cFFEDA55FShift-点击|r 资料优化。 |cFFEDA55FCtrl-点击|r to 重置资料。"
L["+%s (%i heals) (%s)"] = "+%s (%i 治疗) (%s)"
L["<-%i buffs>"] = "<-%i 增益状态>"
L["<-%i debuffs>"] = "<-%i 减益状态>"
L["<+%i buffs>"] = "<+%i 增益状态>"
L["<+%i debuffs>"] = "<+%i 减益状态>"
L["<Break>"] = "<破坏>"
L["<Dispel failed>"] = "<驱散失败>"
L["<Dispel>"] = "<驱散>"
L["<Interrupt>"] = "<打断>"
L["<Refresh>"] = "<刷新>"
L["<Steal>"] = "<偷取>"
L["All friendly players, including those not in your group"] = "所有我方玩家，包括不在您队伍中的那些人"
L["Amount"] = "计数"
L["Announce"] = "通报"
L["Announce deaths"] = "通报死亡"
L["Announce deaths with an unknown cause"] = "通报不明原因死亡"
L["Announces/10 seconds limit"] = "通报/10秒限制"
L["Auras"] = "法术效果"
L["Bar"] = "动作条"
L["Battleground"] = "战场"
L["Buff fades"] = "增益状态消失"
L["Buff gains"] = "获得增益状态"
L["Channel"] = "频道"
L["Chat frame"] = "聊天窗口"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "检查你感兴趣的单位。 此单位未过滤的数据不会被丢弃。"
L["Combat log lines"] = "战斗纪录"
L["Compact"] = "简洁"
L["Consolidate consecutive auras"] = "合并连续法术效果"
L["Consolidate consecutive heals"] = "合并连续治疗"
L["Consolidate consecutive hits"] = "合并连续命中"
L["Damage"] = "伤害"
L["Data capture"] = "资料收集"
L["Data has been reset"] = "资料已重置"
L["Data optimization done in %.02f ms"] = "资料优化在 %.02f ms内完成"
L["Death"] = "死亡"
L["Death Note"] = "死亡记录"
L["Death Note: Death report for %s at %s"] = "死亡记录：%s 的死亡报告于 %s"
L["Debuff fades"] = "减益状态消失"
L["Debuff gains"] = "获得减益状态"
L["Decrease scale"] = "缩小比例"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[启用此如果你想数据持续在登出或重新载入UI后。
请记住，这取决于你的选择，这可能产生一个非常大的SavedVariables文件，并可能影响您的登入/登出和重新加载UI的时间。]=]
--Translation missing 
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"
L["Enemy NPCs"] = "敌对NPC"
L["Enemy players"] = "敌对玩家"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[输入一个或多个来源，以逗号分隔。
按Ctrl+单击一个来源栏以加入来源。]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[输入一个或多个法术，以逗号分隔。
按Ctrl+单击一个法术栏以加入法术。]=]
L["Filters"] = "过滤器"
L["Formatted"] = "格式化"
L["Formatted style options"] = "格式化样式选项"
L["Friendly NPCs"] = "友善NPC"
L["Friendly players"] = "友善玩家"
--Translation missing 
L["General"] = "General"
L["Group (party or raid)"] = "组队(队伍或团队)"
L["Group players"] = "组队玩家"
L["Guild"] = "公会"
L["Healing"] = "治疗"
L["Health format"] = "生命值格式"
L["Hide misses"] = "隐藏未命中"
L["Highlight survival cooldowns"] = "高亮存活冷却时间"
L["HP"] = "生命值"
L["HP %"] = "生命值 %"
L["HP/HPMax"] = "生命值／最大生命值"
L["Include amount resisted/blocked/absorbed"] = "包含抵抗/格档/吸收的数字"
L["Include damage"] = "包含伤害"
L["Include hit type (critical, crushing, etc)"] = "包含命中类型 (致命、碾压 等)"
L["Include overkill"] = "包含过量伤害"
L["Increase scale"] = "放大比例"
L["Keep data between sessions"] = "在登出后保持数据"
L["Limiting report to %i lines"] = "限制报告在%i行"
L["Maximum number of deaths"] = "最大死亡数"
L["Miss"] = "未命中"
L["Name"] = "名称"
L["None"] = "无"
L["Officer"] = "官员"
L["Options"] = "选项"
L["Other pets"] = "其他宠物"
L["Others"] = "其他"
L["Output channel"] = "输出频道"
L["Party"] = "队伍"
L["Party and raid members, including yourself"] = "队伍和团队成员，包含你自己"
L["Raid"] = "团队"
L["Raid Warning"] = "团队警报"
L["Real time"] = "真实时间"
L["Report style"] = "报告样式"
L["Reset"] = "重置"
L["Reset data"] = "重置资料"
L["Say"] = "说"
L["Scale: %i%%"] = "比例：%i%%"
L["Seconds from death"] = "秒内死亡"
L["Seconds to keep before each death (for other units)"] = "每个死前纪录的秒数(其他单位)"
L["Seconds to keep before each death (for the unit killed)"] = "每个死前纪录的秒数 (已死的单位)"
L["Send report from this line"] = "发送这行死亡报告"
L["Setting scale to %i%%"] = "设置比例为%i%%"
L["Show Death Note"] = "显示死亡记录"
--Translation missing 
L["Show in the unit popup menu (requires a UI reload)"] = "Show in the unit popup menu (requires a UI reload)"
L["Show target deaths"] = "显示目标死亡"
L["Sort deaths by"] = "死亡排列方式"
L["Source"] = "来源"
L["Source filter"] = "来源过滤器"
L["Spell"] = "法术"
L["Spell filter"] = "法术过滤器"
L["Survival cooldowns"] = "存活冷却时间"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "这种过滤器的效果依赖于其他过滤器。例如，如果您的友方玩家过滤器未启用，他们的宠物的死亡也不会被记录，即使这个过滤器有启用。"
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "这个数据是用来显示其他玩家死亡时的行动。除非你想使用这个功能不然将此值设置为0，因为它会使用大量的内存。"
L["Threshold"] = "阀值"
L["Time"] = "时间"
L["Time format"] = "时间格式"
--Translation missing 
L["ui:quick-spell-search"] = "Quick spell search:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "单位过滤器"
L["Unknown"] = "未知"
L["Whisper"] = "悄悄话"
L["Whisper target"] = "悄悄话目标"
L["You were killed by"] = "你死于"
L["Your pet"] = "你的宠物"

end

L = LibStub("AceLocale-3.0"):NewLocale("DeathNote", "zhTW")
if L then
L = L or {}
L["%i deaths"] = "%i 死亡"
L["%i more deaths were not announced"] = "多於%i的死亡不會被通告"
L["-%s (%i hits) (%s)"] = "-%s (%i 命中) (%s)"
L["%s|r has died of a heart attack"] = "%s|r 死於心臟病發"
L["%s|r was killed by"] = "%s|r 死於"
L["%s's|r %s"] = "%s的|r %s"
L["(%i more lines not shown)"] = "(多於%i行不顯示)"
L["(%s overkill)"] = "(%s 過量傷害)"
L["|cFFEDA55FClick|r to open Death Note. |cFFEDA55FRight-Click|r to show options. |cFFEDA55FShift-Click|r to optimize data. |cFFEDA55FCtrl-Click|r to reset data."] = "|cFFEDA55F點擊|r 開啟死亡記錄。 |cFFEDA55F右鍵-點擊|r 顯示選項。 |cFFEDA55FShift-點擊|r 資料優化。 |cFFEDA55FCtrl-點擊|r to 重設資料。"
L["+%s (%i heals) (%s)"] = "+%s (%i 治療) (%s)"
L["<-%i buffs>"] = "<-%i 增益狀態>"
L["<-%i debuffs>"] = "<-%i 減益狀態>"
L["<+%i buffs>"] = "<+%i 增益狀態>"
L["<+%i debuffs>"] = "<+%i 減益狀態>"
L["<Break>"] = "<破壞>"
L["<Dispel failed>"] = "<驅散失敗>"
L["<Dispel>"] = "<驅散>"
L["<Interrupt>"] = "<斷法>"
L["<Refresh>"] = "<刷新>"
L["<Steal>"] = "<竊取>"
L["All friendly players, including those not in your group"] = "所有我方玩家，包括那些不在您群組中的"
L["Amount"] = "計數"
L["Announce"] = "通報"
L["Announce deaths"] = "通報死亡"
L["Announce deaths with an unknown cause"] = "通報不明原因死亡"
L["Announces/10 seconds limit"] = "通報/10秒限制"
L["Auras"] = "光環"
L["Bar"] = "動作條"
L["Battleground"] = "戰場"
L["Buff fades"] = "增益狀態消失"
L["Buff gains"] = "增益狀態獲得"
L["Channel"] = "頻道"
L["Chat frame"] = "聊天視窗"
L["Check the units you are interested in. Data for the units not filtered is discarded."] = "檢查你感興趣的單位。 此單位未過濾的數據將被丟棄。"
L["Combat log lines"] = "戰鬥紀錄"
L["Compact"] = "簡潔"
L["Consolidate consecutive auras"] = "合併連續光環"
L["Consolidate consecutive heals"] = "合併連續治療"
L["Consolidate consecutive hits"] = "合併連續命中"
L["Damage"] = "傷害"
L["Data capture"] = "資料收集"
L["Data has been reset"] = "資料已重設"
L["Data optimization done in %.02f ms"] = "資料優化在 %.02f ms內完成"
L["Death"] = "死亡"
L["Death Note"] = "死亡記錄"
L["Death Note: Death report for %s at %s"] = "死亡記錄：%s 的死亡報告於 %s"
L["Debuff fades"] = "減益狀態消失"
L["Debuff gains"] = "減益狀態獲得"
L["Decrease scale"] = "縮小比例"
L[ [=[Enable this if you want the data to persist after logging out or after a reload ui.
Keep in mind that depending on your options this may generate a very big SavedVariables file and may impact your login/logout and reload ui times.]=] ] = [=[啟用此如果你想數據持續在登出或重新載入UI後。
請記住，這取決於你的選擇，這可能產生一個非常大的SavedVariables文件，並可能影響您的登入/登出和重新加載UI的時間。]=]
L["Enabling this option will taint the unit popup menu and will prevent some options from working (such as setting a focus target)"] = "啟用此選項將染污單位彈出選單並且導致一些選項不正常運作(像是設定一個焦點目標)"
L["Enemy NPCs"] = "敵對NPC"
L["Enemy players"] = "敵對玩家"
L[ [=[Enter one or more sources, separated by commas.
Ctrl+Click on a source column to add that source.]=] ] = [=[輸入一個或多個來源，以逗號分隔。
按Ctrl+單擊一個來源欄以加入來源。]=]
L[ [=[Enter one or more spells, separated by commas.
Ctrl+Click on a spell column to add that spell.]=] ] = [=[輸入一個或多個法術，以逗號分隔。
按Ctrl+單擊一個法術欄以加入法術。]=]
L["Filters"] = "過濾器"
L["Formatted"] = "格式化"
L["Formatted style options"] = "格式化樣式選項"
L["Friendly NPCs"] = "友善NPC"
L["Friendly players"] = "友善玩家"
L["General"] = "一般"
L["Group (party or raid)"] = "群組 (隊伍或團隊)"
L["Group players"] = "群組玩家"
L["Guild"] = "公會"
L["Healing"] = "治療"
L["Health format"] = "生命值格式"
L["Hide misses"] = "隱藏未命中"
L["Highlight survival cooldowns"] = "高亮存活冷卻時間"
L["HP"] = "生命值"
L["HP %"] = "生命值 %"
L["HP/HPMax"] = "生命值／最大生命值"
L["Include amount resisted/blocked/absorbed"] = "包含抵抗/格檔/吸收的數字"
L["Include damage"] = "包含傷害"
L["Include hit type (critical, crushing, etc)"] = "包含命中類型 (致命、碾壓 等)"
L["Include overkill"] = "包含過量傷害"
L["Increase scale"] = "放大比例"
L["Keep data between sessions"] = "保持數據在登出後"
L["Limiting report to %i lines"] = "限制報告在%i行"
L["Maximum number of deaths"] = "最大死亡數"
L["Miss"] = "未命中"
L["Name"] = "名稱"
L["None"] = "無"
L["Officer"] = "幹部"
L["Options"] = "選項"
L["Other pets"] = "其他寵物"
L["Others"] = "其他"
L["Output channel"] = "輸出頻道"
L["Party"] = "隊伍"
L["Party and raid members, including yourself"] = "隊伍和團隊成員，包含你自己"
L["Raid"] = "團隊"
L["Raid Warning"] = "團隊警報"
L["Real time"] = "真實時間"
L["Report style"] = "報告樣式"
L["Reset"] = "重設"
L["Reset data"] = "重設資料"
L["Say"] = "說"
L["Scale: %i%%"] = "比例：%i%%"
L["Seconds from death"] = "秒內死亡"
L["Seconds to keep before each death (for other units)"] = "每個死前紀錄的秒數(其他單位)"
L["Seconds to keep before each death (for the unit killed)"] = "每個死前紀錄的秒數 (已死的單位)"
L["Send report from this line"] = "將這行發送報告"
L["Setting scale to %i%%"] = "設定比例為%i%%"
L["Show Death Note"] = "顯示死亡記錄"
L["Show in the unit popup menu (requires a UI reload)"] = "顯示單位彈出選單(需要UI重載)"
L["Show target deaths"] = "顯示目標死亡"
L["Sort deaths by"] = "排列死亡由"
L["Source"] = "來源"
L["Source filter"] = "來源過濾器"
L["Spell"] = "法術"
L["Spell filter"] = "法術過濾器"
L["Survival cooldowns"] = "存活冷卻時間"
L["The effect of this filter depends on the other filters. For example, if you have the friendly players filter inactive, their pets deaths won't be recorded either, even with this filter activated."] = "這種過濾器的效果依賴於其他過濾器。例如，如果您的友方玩家過濾器未啟用，他們的寵物的死亡也不會被記錄，即使這個過濾器有啟用。"
L["This data is used to display actions of other players when a death happened. Set this value to 0 unless you want to use this feature, as it can use a large amount of memory."] = "這個數據是用來顯示其他玩家死亡時的行動。除非你想使用這個功能不然將此值設置為0，因為它會使用大量的記憶體。"
L["Threshold"] = "門閥"
L["Time"] = "時間"
L["Time format"] = "時間格式"
L["ui:quick-spell-search"] = "快速法術搜尋:"
--Translation missing 
L["ui:quick-spell-search:mode:highlight"] = "highlight found spells"
--Translation missing 
L["ui:quick-spell-search:mode:only-found-spells"] = "display only found spells + CDs"
L["Units filters"] = "單位過濾器"
L["Unknown"] = "未知"
L["Whisper"] = "悄悄話"
L["Whisper target"] = "悄悄話目標"
L["You were killed by"] = "你死於"
L["Your pet"] = "你的寵物"

end

