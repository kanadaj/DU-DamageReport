function GetContentStartup()
    local output = ""
    output = output .. GetElementLogo(812, 380, "f", "f", "f")
    if YourShipsName == "Enter here" then
        output = output .. [[<g><text class="f160m" x="960" y="330">Spaceship ID ]]..ShipID..[[</text><animate attributeName="fill" values="#]]..ColorPrimary..[[;#]]..ColorSecondary..[[;#]]..ColorPrimary..[[" dur="30s" repeatCount="indefinite" /></g>]]
    else
        output = output .. [[<g><text class="f160m" x="960" y="330">]]..YourShipsName..[[</text><animate attributeName="fill" values="#]]..ColorPrimary..[[;#]]..ColorSecondary..[[;#]]..ColorPrimary..[[" dur="30s" repeatCount="indefinite" /></g>]]
    end
    if ShowWelcomeMessage == true then output = output .. [[<text class="f50mx" x="960" y="750">Greetings, Commander ]]..PlayerName..[[.</text>]] end
    if #Warnings > 0 then
        output = output .. [[<text class="f25mc" x="960" y="880">Warning: ]]..(table.concat(Warnings, " "))..[[</text>]]
    end
    output = output .. [[<text class="f30mxx" style="fill-opacity:0.2" x="960" y="1000">Damage Report v]]..VERSION..[[, by Scion Interstellar, DorianGray - Discord: Dorian Gray#2623. Under GNU Public License 3.0.</text>]]
    return output
end