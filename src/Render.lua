--[[ 4. RENDERING FUNCTIONS ]]

function GetContentFlight()
    local output = ""
    output = output .. GetHeader("Flight Data Report") ..
    [[
        
    ]]
    return output
end

function GetContentDamage()
    local output = ""
    if SimulationMode == true then 
        output = output .. GetHeader("Damage Report (Simulated damage)") .. [[]]
    else 
        output = output .. GetHeader("Damage Report") .. [[]]
    end
    output = output .. GetContentDamageScreen()
    return output
end

function GetContentDamageoutline(screen)
    UpdateDataDamageoutline()
    UpdateViewDamageoutline(screen)
    local output = ""
    output = output .. GetHeader("Damage Ship Outline Report") ..
    GetDamageoutlineShip() .. 
    [[<rect x=20 y=180 rx=5 ry=5 width=1880 height=840 fill=#000000 fill-opacity=0.5 style="stroke:#]]..ColorPrimary..[[;stroke-width:3;" />]]

    if screen.submode=="top" then
        output = output ..
            [[
              <rect class=xfill x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=220 y=165>Top View</text>
              <rect class=xborder x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=620 y=165>Side View</text>
              <rect class=xborder x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=1020 y=165>Front View</text>
            ]]
    elseif screen.submode=="side" then
        output = output ..
            [[
              <rect class=xborder x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=220 y=165>Top View</text>
              <rect class=xfill x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=620 y=165>Side View</text>
              <rect class=xborder x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=1020 y=165>Front View</text>
            ]]
    elseif screen.submode=="front" then
        output = output ..
            [[
              <rect class=xborder x=20 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=220 y=165>Top View</text>
              <rect class=xborder x=420 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mx x=620 y=165>Side View</text>
              <rect class=xfill x=820 y=130 rx=5 ry=5 width=400 height=50 />
              <text class=f30mxx x=1020 y=165>Front View</text>
            ]]
    else
    end
    output = output .. [[<text class=f30exx x=1900 y=120>]]..#dmgoElements..[[ of ]]..ElementCounter..[[ shown</text>]]
    output = output .. [[<rect class=xborder x=1550 y=130 rx=5 ry=5 width=50 height=50 />]]
    if DMGOStretch == true then
        output = output .. [[<rect class=xfill x=1558 y=138 rx=5 ry=5 width=34 height=34 />]]
    end
    output = output .. [[<text class=f30exx x=1900 y=165>Stretch both axis</text>]]
    return output
end

function GetContentFuel(screen)

    if #FuelAtmosphericTanks < 1 and #FuelSpaceTanks < 1 and #FuelRocketTanks < 1 then return "" end

    local FuelTypes = 0
    local output = ""
    local addHeadline = {}

    FuelDisplay = { screen.fuelA, screen.fuelS, screen.fuelR }

    if FuelDisplay[1] == true and #FuelAtmosphericTanks > 0 then 
        table.insert(addHeadline, "Atmospheric")
        FuelTypes = FuelTypes + 1
    end
    if FuelDisplay[2] == true and #FuelSpaceTanks > 0 then 
        table.insert(addHeadline, "Space")
        FuelTypes = FuelTypes + 1
    end
    if FuelDisplay[3] == true and #FuelRocketTanks > 0 then 
        table.insert(addHeadline, "Rocket")
        FuelTypes = FuelTypes + 1
    end

    output = output .. GetHeader("Fuel Report ("..table.concat(addHeadline, ", ")..")") ..
    [[
    <style>
        .fuele{fill:#]]..ColorBackground..[[;}
        .fuela{fill:#]]..ColorFuelAtmospheric..[[;fill-opacity:1;}
        .fuels{fill:#]]..ColorFuelSpace..[[;fill-opacity:1;}
        .fuelr{fill:#]]..ColorFuelRocket..[[;fill-opacity:1;}

        .fuela2{fill:none;stroke:#]]..ColorFuelAtmospheric..[[;stroke-width:3px;opacity:1;}
        .fuels2{fill:none;stroke:#]]..ColorFuelSpace..[[;stroke-width:3px;opacity:1;}
        .fuelr2{fill:none;stroke:#]]..ColorFuelRocket..[[;stroke-width:3px;opacity:1;}

        .fuela3{fill:#]]..ColorFuelAtmospheric..[[;fill-opacity:0.1;}
        .fuels3{fill:#]]..ColorFuelSpace..[[;fill-opacity:0.1;}
        .fuelr3{fill:#]]..ColorFuelRocket..[[;fill-opacity:0.1;}

        .fuela4{fill:#]]..ColorFuelAtmospheric..[[;fill-opacity:1;}
        .fuels4{fill:#]]..ColorFuelSpace..[[;fill-opacity:1;}
        .fuelr4{fill:#]]..ColorFuelRocket..[[;fill-opacity:1;}
    </style> ]]

    local totalH = 150
    local counter = 0
    local tOffset = 0

    if FuelDisplay[1] == true and #FuelAtmosphericTanks > 0 then

        if FuelTypes == 1 then tOffset = 50
        elseif FuelTypes == 2 then tOffset = 6
        elseif FuelTypes == 3 then tOffset = 0
        end

        output = output .. [[
        <svg x=20 y=]]..(95+totalH/FuelTypes*counter)..[[ width=1880 height=]]..totalH/FuelTypes..[[>
            <rect class="fuele" width="100%" height="100%"/>
            <rect class="fuela" width="]]..math.floor(100/FuelAtmosphericTotal*FuelAtmosphericCurrent)..[[%" height="100%"/>
        </svg>]]

        output = output ..
        [[<text class=f25sxx x=40 y=]]..(130+totalH/FuelTypes*counter+tOffset)..[[>]]..
        GenerateCommaValue(FuelAtmosphericCurrent, true)..
        [[ of ]]..GenerateCommaValue(FuelAtmosphericTotal, true)..
        [[ | Total Atmospheric Fuel in ]]..#FuelAtmosphericTanks..[[ tank]]..(#FuelAtmosphericTanks==1 and "" or "s")..[[ (]]..math.floor(100/FuelAtmosphericTotal*FuelAtmosphericCurrent)..[[%)</text>]]
        counter = counter + 1
    end

    if FuelDisplay[2] == true and #FuelSpaceTanks > 0 then

        if FuelTypes == 1 then tOffset = 50
        elseif FuelTypes == 2 then tOffset = 6
        elseif FuelTypes == 3 then tOffset = 0
        end

        output = output .. [[
        <svg x=20 y=]]..(95+totalH/FuelTypes*counter)..[[ width=1880 height=]]..totalH/FuelTypes..[[>
            <rect class="fuele" width="100%" height="100%"/>
            <rect class="fuels" width="]]..math.floor(100/FuelSpaceTotal*FuelSpaceCurrent)..[[%" height="100%"/>
        </svg>]]

        output = output ..
        [[<text class=f25sxx x=40 y=]]..(130+totalH/FuelTypes*counter+tOffset)..[[>]]..
        GenerateCommaValue(FuelSpaceCurrent, true)..
        [[ of ]]..GenerateCommaValue(FuelSpaceTotal, true)..
        [[ | Total Space Fuel in ]]..#FuelSpaceTanks..[[ tank]]..(#FuelSpaceTanks==1 and "" or "s")..[[ (]]..math.floor(100/FuelSpaceTotal*FuelSpaceCurrent)..[[%)</text>]]
        counter = counter + 1
    end

    if FuelDisplay[3] == true and #FuelRocketTanks > 0 then

        if FuelTypes == 1 then tOffset = 50
        elseif FuelTypes == 2 then tOffset = 6
        elseif FuelTypes == 3 then tOffset = 0
        end

        output = output .. [[
        <svg x=20 y=]]..(95+totalH/FuelTypes*counter)..[[ width=1880 height=]]..totalH/FuelTypes..[[>
            <rect class="fuele" width="100%" height="100%"/>
            <rect class="fuelr" width="]]..math.floor(100/FuelRocketTotal*FuelRocketCurrent)..[[%" height="100%"/>
        </svg> ]]

        output = output ..
        [[<text class=f25sxx x=40 y=]]..(130+totalH/FuelTypes*counter+tOffset)..[[>]]..
        GenerateCommaValue(FuelRocketCurrent, true)..
        [[ of ]]..GenerateCommaValue(FuelRocketTotal, true)..
        [[ | Total Rocket Fuel in ]]..#FuelRocketTanks..[[ tank]]..(#FuelRocketTanks==1 and "" or "s")..[[ (]]..math.floor(100/FuelRocketTotal*FuelRocketCurrent)..[[%)</text>]]
    end

    output = output .. [[
    <svg x=20 y=95 width=1880 height=]]..totalH..[[>
        <rect class="xborder" width="100%" height="100%"/>
    </svg>
    ]]

    local DisplayTable = {}
    if screen.fuelIndex == nil or screen.fuelIndex < 1 then
        screen.fuelIndex = 1
    end

    if FuelDisplay[1] == true then
        for _,v in ipairs(FuelAtmosphericTanks) do
            table.insert(DisplayTable, v)
        end
    end
    if FuelDisplay[2] == true then
        for _,v in ipairs(FuelSpaceTanks) do
            table.insert(DisplayTable, v)
        end
    end
    if FuelDisplay[3] == true then
        for _,v in ipairs(FuelRocketTanks) do
            table.insert(DisplayTable, v)
        end
    end

    table.sort(DisplayTable, function(a,b) return a.type<b.type or (a.type == b.type and a.id<b.id) end)

    local cCounter = 0
    for i=screen.fuelIndex, screen.fuelIndex+6, 1 do
        if DisplayTable[i] ~= nil then
            local tank = DisplayTable[i]
            cCounter = cCounter + 1
            local colorChar = ""
            if tank.type == 1 then
                colorChar = "a"
            elseif tank.type == 2 then
                colorChar = "s"
            elseif tank.type == 3 then
                colorChar = "r"
            end
            

            local twidth = 1853/100
            if tank.percent == nil or tank.percent==0 then
                twidth = 0
            else
                twidth = twidth * tank.percent
            end
            if tank.cvol == nil then tank.cvol = 0 end
            if tank.name == nil then tank.name = "" end

            

            output = output .. [[
                <svg x=20 y=]]..(cCounter*100+220)..[[ width=1880 height=100 viewBox="0 0 1880 100">
                    <rect class="fuel]]..colorChar..[[3" x="13.5" y="9.5" width="1853" height="81"/>
                    <rect class="fuel]]..colorChar..[[4" x="13.5" y="9.5" width="]]..twidth..[[" height="81"/>
                    <rect class="fuel]]..colorChar..[[2" x="13.5" y="9.5" width="1853" height="81"/>]]
            if tank.hp == 0 then
                output = output .. [[<polygon class="cc" points="7 3 7 97 15 97 15 100 4 100 4 74.9 0 71.32 0 18.7 4 14.4 4 0 15 0 15 3 7 3"/><polygon class="cc" points="1873 3 1873 97 1865 97 1865 100 1876 100 1876 74.9 1880 71.32 1880 18.7 1876 14.4 1876 0 1865 0 1865 3 1873 3"/>]]
            elseif tank.maxhp - tank.hp > constants.epsilon then
                output = output .. [[<polygon class="cw" points="7 3 7 97 15 97 15 100 4 100 4 74.9 0 71.32 0 18.7 4 14.4 4 0 15 0 15 3 7 3"/><polygon class="cw" points="1873 3 1873 97 1865 97 1865 100 1876 100 1876 74.9 1880 71.32 1880 18.7 1876 14.4 1876 0 1865 0 1865 3 1873 3"/>]]
            else 
                output = output .. [[<polygon class="ch" points="7 3 7 97 15 97 15 100 4 100 4 74.9 0 71.32 0 18.7 4 14.4 4 0 15 0 15 3 7 3"/><polygon class="ch" points="1873 3 1873 97 1865 97 1865 100 1876 100 1876 74.9 1880 71.32 1880 18.7 1876 14.4 1876 0 1865 0 1865 3 1873 3"/>]]
            end
            if tank.hp == 0 then output = output .. [[<text class=f80mc x=60 y=82>]]..tank.size..[[</text>]]
            else output = output .. [[<text class=f80mxx07 x=60 y=82>]]..tank.size..[[</text>]]
            end

            if tank.hp == 0 then 
                output = output .. [[<text class=f60mc x=940 y=74>Broken</text>]] ..
                                   [[<text class=f25ec x=1860 y=60>0 of ]]..GenerateCommaValue(tank.vol)..[[</text>]]
            elseif tonumber(tank.percent) < 10 then 
                output = output .. [[<text class=f60mc x=940 y=74>]]..tank.percent..[[%</text>]] ..
                                   [[<text class=f25ec x=1860 y=60>]]..GenerateCommaValue(tank.cvol)..[[ of ]]..GenerateCommaValue(tank.vol)..[[</text>]]
            elseif tonumber(tank.percent) < 30 then 
                output = output .. [[<text class=f60mw x=940 y=74>]]..tank.percent..[[%</text>]] ..
                                   [[<text class=f25ew x=1860 y=60>]]..GenerateCommaValue(tank.cvol)..[[ of ]]..GenerateCommaValue(tank.vol)..[[</text>]]
            else output = 
                output .. [[<text class=f60mxx x=940 y=74>]]..tank.percent..[[%</text>]] ..
                          [[<text class=f25exx x=1860 y=60>]]..GenerateCommaValue(tank.cvol)..[[ of ]]..GenerateCommaValue(tank.vol)..[[</text>]]
            end

            output = output ..[[<text class=f25sxx x=140 y=60>]]..tank.name..[[</text>]]

            output = output .. [[</svg>]]

        end
    end



    if #FuelAtmosphericTanks > 0 then
        output = output .. [[<rect class=xborder x=20 y=260 rx=5 ry=5 width=50 height=50 />]]
        if FuelDisplay[1] == true then
            output = output .. [[<rect class=xfill x=28 y=268 rx=5 ry=5 width=34 height=34 />]]
        end
        output = output .. [[<text class=f25sx x=80 y=290>ATM</text>]]
        AddClickAreaForScreenID(screen.id, {mode = "fuel", id = "ToggleDisplayAtmosphere", x1 = 50, x2 = 100, y1 = 270, y2 = 320} )
    end

    if #FuelSpaceTanks > 0 then
        output = output .. [[<rect class=xborder x=170 y=260 rx=5 ry=5 width=50 height=50 />]]
        if FuelDisplay[2] == true then
            output = output .. [[<rect class=xfill x=178 y=268 rx=5 ry=5 width=34 height=34 />]]
        end
        output = output .. [[<text class=f25sx x=230 y=290>SPC</text>]]
        AddClickAreaForScreenID(screen.id, {mode = "fuel", id = "ToggleDisplaySpace", x1 = 200, x2 = 250, y1 = 270, y2 = 320} )
    end

    if #FuelRocketTanks > 0 then
        output = output .. [[<rect class=xborder x=320 y=260 rx=5 ry=5 width=50 height=50 />]]
        if FuelDisplay[3] == true then
            output = output .. [[<rect class=xfill x=328 y=268 rx=5 ry=5 width=34 height=34 />]]
        end
        output = output .. [[<text class=f25sx x=380 y=290>RKT</text>]]
        AddClickAreaForScreenID(screen.id, {mode = "fuel", id = "ToggleDisplayRocket", x1 = 350, x2 = 400, y1 = 270, y2 = 320} )
    end

    if screen.fuelIndex > 1 then
        output = output .. [[<svg x="1490" y="260">
                                <rect x="0" y="0" rx="10" ry="10" width="200" height="50" style="fill:#]]..ColorPrimary..[[;" />
                                <svg x="80" y="15"><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>
                            </svg>]]
        AddClickAreaForScreenID(screen.id, {mode = "fuel", id = "DecreaseFuelIndex", x1 = 1470, x2 = 1670, y1 = 270, y2 = 320} )
    end

    if screen.fuelIndex+cCounter-1 < #DisplayTable then
        output = output .. [[<svg x="1700" y="260">
                                <rect x="0" y="0" rx="10" ry="10" width="200" height="50" style="fill:#]]..ColorPrimary..[[;" />
                                <svg x="80" y="15"><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>
                            </svg>]]
        AddClickAreaForScreenID(screen.id, {mode = "fuel", id = "IncreaseFuelIndex", x1 = 1680, x2 = 1880, y1 = 270, y2 = 320} )
    end

    if cCounter > 0 then
        output = output .. [[<text class=f30mx x=960 y=300>]]..
                           #DisplayTable..
                           [[ Tank]]..(#DisplayTable == 1 and "" or "s")..
                           [[ (Showing ]]..screen.fuelIndex..[[ to ]]..(screen.fuelIndex+cCounter-1)..[[)</text>]]
    end

    return output
end

function GetContentCargo()
    local output = ""
    output = output .. GetHeader("Cargo Report") ..
    [[
        
    ]]
    return output
end

function GetContentAGG()
    local output = ""
    output = output .. GetHeader("Anti-Grav Control") ..
    [[
        
    ]]
    return output
end

function GetContentMap()
    local output = ""
    output = output .. GetHeader("Map Overview") ..
    [[
        
    ]]
    return output
end

function GetContentTime()
    local output = ""
    output = output .. GetHeader("Time") .. epochTime()
    output = output ..
                [[<svg x=460 y=370 width=120 height=150 viewBox="0 0 24 30">
                    <rect x=0 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0s" dur="1s" repeatCount="indefinite" />
                    </rect>
                    <rect x=10 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0.15s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0.15s" dur="1s" repeatCount="indefinite" />
                    </rect>
                    <rect x=20 y=13 width=4 height=5 fill=#]]..ColorPrimary..[[>
                      <animate attributeName="height" attributeType="XML"
                        values="5;21;5" 
                        begin="0.3s" dur="1s" repeatCount="indefinite" />
                      <animate attributeName="y" attributeType="XML"
                        values="13; 5; 13"
                        begin="0.3s" dur="1s" repeatCount="indefinite" />
                    </rect>
                  </svg>]]
    return output
end

function GetContentSettings1()
    local output = ""
    output = output .. GetHeader("Settings") .. [[<rect class="xfill" x="40" y="150" rx="5" ry="5" width="820" height="50" />]]
    if BackgroundMode=="" then
        output = output ..[[<text class="f30mxxx" x="440" y="185">Activate background</text>]]
    else
        output = output ..[[<text class="f30mxxx" x="440" y="185">Deactivate background (']]..BackgroundMode..[[', ]]..string.format("%.0f",BackgroundModeOpacity*100)..[[%)</text>]]
    end
    output = output ..[[
        <rect class="xfill" x="40" y="220" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="240" y="255">Previous background</text>
        <rect class="xfill" x="460" y="220" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="660" y="255">Next background</text>

        <rect class="xfill" x="40" y="290" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="240" y="325">Decrease Opacity</text>
        <rect class="xfill" x="460" y="290" rx="5" ry="5" width="400" height="50" />
        <text class="f30mxxx" x="660" y="325">Increase Opacity</text>
    ]]

    output = output ..
        [[<rect class="xfill" x="40" y="360" rx="5" ry="5" width="820" height="50" />]] ..
        [[<text class="f30mxxx" x="440" y="395">Reset background and all colors</text>]]

    output = output ..
        [[<svg x=40 y=430 width=820 height=574>]] ..
            [[<rect class="xborder" x="0" y="0" rx="5" ry="5" width="820" height="574" stroke-dasharray="2 5" />]] ..
            [[<rect class="xborder" x="0" y="0" rx="5" ry="5" width="820" height="50" />]] ..
            [[<text class="f30mxx" x="410" y="35">Select and change any of the ]]..#colorIDTable..[[ HUD colors</text>]] ..
            [[<rect class="xfill" x="20" y="70" rx="5" ry="5" width="50" height="50" />]] ..
                [[<svg x=32 y=74><path d="M1,23.13,16.79,40.25a3.23,3.23,0,0,0,5.6-2.19V3.24a3.23,3.23,0,0,0-5.6-2.19L1,18.17A3.66,3.66,0,0,0,1,23.13Z" transform="translate(0.01 -0.01)"/></svg>]] ..
            [[<rect class="xfill" x="750" y="70" rx="5" ry="5" width="50" height="50" />]] ..
                [[<svg x=764 y=74><path d="M21.42,18.17,5.59,1.05A3.23,3.23,0,0,0,0,3.24V38.06a3.23,3.23,0,0,0,5.6,2.19L21.42,23.13A3.66,3.66,0,0,0,21.42,18.17Z" transform="translate(0.01 -0.01)"/></svg>]] ..
            [[<rect class="xborder" x="90" y="70" rx="5" ry="5" width="640" height="50" />]] ..
            [[<text class="f30mxx" x="410" y="105">]]..colorIDTable[colorIDIndex].desc..[[</text>]] ..
            [[<rect style="fill: #]].._G[colorIDTable[colorIDIndex].id]..[[; fill-opacity: 1; stroke: #]]..ColorPrimary..[[; stroke-width:3;" x="90" y="140" rx="5" ry="5" width="640" height="70" />]] ..
            [[<text class="f20sxx" x="100" y="160">Current color</text>]] ..
            [[<svg x=90 y=230 width=640 height=140>]] ..

                [[<rect class=xbfill x=55 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=75 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=145 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=165 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=235 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=255 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=325 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=345 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=415 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=435 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=505 y=5 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=525 y=15><path d="M47.52,14.77,30.4,30.6a3.23,3.23,0,0,0,2.19,5.6H67.41a3.23,3.23,0,0,0,2.19-5.6L52.48,14.77A3.66,3.66,0,0,0,47.52,14.77Z" transform="translate(-29.36 -13.8)"/></svg>]] ..

                [[<text class=f60mx x=27 y=92>#</text>]] ..

                [[<rect class=xborder x=55 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=95 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,1,1)..[[</text>]] ..
                [[<rect class=xborder x=145 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=185 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,2,2)..[[</text>]] ..
                [[<rect class=xborder x=235 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=275 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,3,3)..[[</text>]] ..
                [[<rect class=xborder x=325 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=365 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,4,4)..[[</text>]] ..
                [[<rect class=xborder x=415 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=455 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,5,5)..[[</text>]] ..
                [[<rect class=xborder x=505 y=50 rx=5 ry=5 width=80 height=40 />]] ..
                [[<text class=f30mxx x=545 y=80>]]..string.sub(colorIDTable[colorIDIndex].newc,6,6)..[[</text>]] ..

                [[<rect class=xbfill x=55 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=75 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=145 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=165 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=235 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=255 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=325 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=345 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=415 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=435 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..
                [[<rect class=xbfill x=505 y=95 rx=5 ry=5 width=80 height=40 />]] ..
                    [[<svg x=525 y=105><path d="M52.48,35.23,69.6,19.4a3.23,3.23,0,0,0-2.19-5.6H32.59a3.23,3.23,0,0,0-2.19,5.6L47.52,35.23A3.66,3.66,0,0,0,52.48,35.23Z" transform="translate(-29.36 -13.8)"/></svg>]] ..

            [[</svg>]] ..
            [[<rect style="fill: #]]..colorIDTable[colorIDIndex].newc..[[; fill-opacity: 1; stroke: #]]..ColorPrimary..[[; stroke-width:3;" x="90" y="390" rx="5" ry="5" width="640" height="70" />]] ..
            [[<text class=f20sxx x=100 y=410>New color</text>]] ..
            [[<rect class=xfill x=290 y=480 rx=5 ry=5 width=440 height=50 />]] ..
            [[<text class=f30mxxx x=510 y=515>Apply new color</text>]] ..
            [[<rect class=xfill x=90 y=480 rx=5 ry=5 width=185 height=50 />]] ..
            [[<text class=f30mxxx x=182 y=515>Reset</text>]] ..
        [[</svg>]]

    output = output ..
            [[<svg x=940 y=150 width=936 height=774>]] ..
                [[<rect class=xborder x=0 y=0 rx=5 ry=5 width=936 height=774 stroke-dasharray="2 5" />]] ..
                [[<rect class=xborder x=0 y=0 rx=5 ry=5 width=936 height=50 />]] ..
                [[<text class=f30mxx x=468 y=35>Explanation / Hints</text>]] ..
                [[<text class=f30mxx x=468 y=400>Coming soon.</text>]]


    output = output .. [[</svg>]]

    if SimulationMode == true then
        output = output .. [[<rect class="cfill" x="940" y="954" rx="5" ry="5" width="936" height="50" /><text class="f30mxxx" x="1408" y="989">Simulating Damage to elements</text>]]
        AddClickArea("settings1", { id = "ToggleSimulation", mode ="settings1", x1 = 940, x2 = 1850, y1 = 919, y2 = 969 })
    else
        output = output .. [[<rect class="xfill" x="940" y="954" rx="5" ry="5" width="936" height="50" /><text class="f30mxxx" x="1408" y="989">Simulate Damage to elements</text>]]
        AddClickArea("settings1", { id = "ToggleSimulation", mode ="settings1", x1 = 940, x2 = 1850, y1 = 919, y2 = 969 })
    end

    return output
end

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

function RenderScreen(screen, contentToRender)
    if contentToRender == nil then
        PrintConsole("ERROR: contentToRender is nil.")
        unit.exit()
    end
 
    CreateClickAreasForScreen(screen)

    local output =""
    output = output .. [[
    <style>
      body{
        background-color: #]]..ColorBackground..[[; ]]..GetContentBackground(BackgroundMode)..[[
      }
      .screen { width: 1920px; height: 1120px; }
      .main { width: 1920px; height: 1040px; }
      .menu { width: 1920px; height: 70px; stroke: #]]..ColorPrimary..[[; stroke-width: 3; }

      .xline { stroke: #]]..ColorPrimary..[[; stroke-width: 3;}
      .daline { stroke: #]]..ColorSecondary..[[; stroke-dasharray: 2 5; }
      .ll { fill: #FF55FF; stroke: #FF0000}
      .xborder { fill:#]]..ColorPrimary..[[; fill-opacity:0.05; stroke: #]]..ColorPrimary..[[; stroke-width:3; }
      .xfill { fill:#]]..ColorPrimary..[[; fill-opacity:1; }
      .xbfill { fill:#]]..ColorPrimary..[[; fill-opacity:1; stroke: #]]..ColorPrimary..[[; stroke-width:3; }
      .cfill { fill:#]]..ColorCritical..[[; fill-opacity:1; }

      .hlrect { fill: #]]..ColorPrimary..[[; }
      .cx { fill: #]]..ColorPrimary..[[; }
      .ch { fill: #]]..ColorHealthy..[[; }
      .cw { fill: #]]..ColorWarning..[[; } 
      .cc { fill: #]]..ColorCritical..[[; }

      .f { fill:#]]..ColorPrimary..[[; }
      .f2 { fill:#]]..ColorSecondary..[[; }
      .f3 { fill:#]]..ColorTertiary..[[; }
      .f250mx { font-size: 250px; text-anchor: middle; fill: #]]..ColorPrimary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f160m { font-size: 160px; text-anchor: middle; font-family: Impact, Charcoal, sans-serif; }
      .f160mx { font-size: 160px; text-anchor: middle; fill: #]]..ColorPrimary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f100mx { font-size: 100px; text-anchor: middle; fill: #]]..ColorPrimary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f80mxx07 { opacity:0.7; font-size: 80px; text-anchor: middle; fill: #]]..ColorSecondary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f80mc { opacity:1; font-size: 80px; text-anchor: middle; fill: #]]..ColorCritical..[[; font-family: Impact, Charcoal, sans-serif; }
      .f60s { font-size: 60px; text-anchor: start; }
      .f60m { font-size: 60px; text-anchor: middle; }
      .f60e { font-size: 60px; text-anchor: end; }
      .f60mx { font-size: 60px; text-anchor: middle; fill: #]]..ColorPrimary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f60mxx { font-size: 60px; text-anchor: middle; fill: #]]..ColorSecondary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f60mxx07 { opacity:0.7; font-size: 60px; text-anchor: middle; fill: #]]..ColorSecondary..[[; font-family: Impact, Charcoal, sans-serif; }
      .f60mc { opacity:1; font-size: 60px; text-anchor: middle; fill: #]]..ColorCritical..[[; font-family: Impact, Charcoal, sans-serif; }
      .f60mw { opacity:1; font-size: 60px; text-anchor: middle; fill: #]]..ColorWarning..[[; font-family: Impact, Charcoal, sans-serif; }
      .f50m { font-size: 50px; text-anchor: middle; }
      .f50sxx { font-size: 50px; text-anchor: start; fill: #]]..ColorSecondary..[[; }
      .f50mx { font-size: 50px; fill: #]]..ColorPrimary..[[; fill-opacity: 1; text-anchor: middle; }
      .f50mx02 { font-size: 50px; fill: #]]..ColorPrimary..[[; fill-opacity: 0.2; text-anchor: middle; }
      .f50mxx { font-size: 50px; fill: #]]..ColorSecondary..[[; fill-opacity: 1; text-anchor: middle }
      .f36mxx { font-size: 36px; fill: #]]..ColorSecondary..[[; fill-opacity: 1; text-anchor: middle }
      .f30mx { font-size: 30px; fill: #]]..ColorPrimary..[[; fill-opacity: 1; text-anchor: middle; }
      .f30sxx { font-size: 30px; fill: #]]..ColorSecondary..[[; fill-opacity: 1; text-anchor: start; }
      .f30exx { font-size: 30px; fill: #]]..ColorSecondary..[[; fill-opacity: 1; text-anchor: end; }
      .f30mxx { font-size: 30px; fill: #]]..ColorSecondary..[[; fill-opacity: 1; text-anchor: middle; }
      .f30mxxx { font-size: 30px; fill: #]]..ColorTertiary..[[; fill-opacity: 1; text-anchor: middle; }
      .f25sx { font-size: 25px; text-anchor: start; fill: #]]..ColorPrimary..[[; }
      .f25exx { font-size: 25px; text-anchor: end; fill: #]]..ColorSecondary..[[; }
      .f25sxx { font-size: 25px; text-anchor: start; fill: #]]..ColorSecondary..[[; }
      .f25mw { font-size: 25px; text-anchor: middle; fill: #]]..ColorWarning..[[; }
      .f25mr { font-size: 25px; text-anchor: middle; fill: #]]..ColorCritical..[[; }
      .f25ew { font-size: 25px; text-anchor: end; fill: #]]..ColorWarning..[[; }
      .f25ec { font-size: 25px; text-anchor: end; fill: #]]..ColorCritical..[[; }
      .f25mc { font-size: 25px; text-anchor: middle; fill: #]]..ColorCritical..[[; }
      .f20sxx { font-size: 20px; text-anchor: start; fill: #]]..ColorSecondary..[[; }
      .f20mxx { font-size: 20px; text-anchor: middle; fill: #]]..ColorSecondary..[[; }
    </style>
    <svg class=screen viewBox="0 0 1920 1120">
      <svg class=main x=0 y=0>]]
        
        output = output .. contentToRender

        if screen.mode == "startup" then
            output = output .. [[<rect class=xborder x=0 y=0 rx=5 ry=5 width=1920 height=1040 />]]
        else
            output = output .. [[<rect class=xborder x=0 y=70 rx=5 ry=5 width=1920 height=970 />]]
        end

        output = output .. [[
      </svg>
      <svg class=menu x=0 y=1050>
        <rect class=xline x=0 y=0 rx=5 ry=5 width=1920 height=70 fill=#]]..ColorBackground..[[ />
        <text class=f50mx x=96 y=50>TIME</text>
        <text class=f50mx x=288 y=50>DMG</text>
        <text class=f50mx x=480 y=50>DMGO</text>
        <text class=f50mx x=672 y=50>FUEL</text>]]

        --[[
        <text class=f50mx x=672 y=50>FUEL</text>
        <text class=f50mx x=864 y=50>FLGT</text>
        <text class=f50mx x=1056 y=50>CRGO</text>
        <text class=f50mx x=1248 y=50>AGG</text>
        <text class=f50mx x=1440 y=50>MAP</text>
        ]]

        output = output .. [[
        <text class=f50mx x=1632 y=50>HUD</text>
        <text class=f50mx x=1824 y=50>SETS</text>
        <line class=xline x1=192 y1=10 x2=192 y2=60 />
        <line class=xline x1=384 y1=10 x2=384 y2=60 />
        <line class=xline x1=576 y1=10 x2=576 y2=60 />
        <line class=xline x1=768 y1=10 x2=768 y2=60 />]] ..
        -- [[<line class=xline x1=960 y1=10 x2=960 y2=60 />
        -- <line class=xline x1=1152 y1=10 x2=1152 y2=60 />
        ---<line class=xline x1=1344 y1=10 x2=1344 y2=60 />]] ..
        [[<line class=xline x1=1536 y1=10 x2=1536 y2=60 />
        <line class=xline x1=1728 y1=10 x2=1728 y2=60 />]]
        if HUDMode == true then
            output = output .. [[
            <rect class=hlrect x=1544 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=1632 y=50>HUD</text>
            ]]
        end
        if screen.mode == "damage" then
            output = output .. [[
            <rect class=hlrect x=200 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=288 y=50>DMG</text>
            ]]
        elseif screen.mode == "damageoutline" then
            output = output .. [[
            <rect class=hlrect x=392 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=480 y=50>DMGO</text>
            ]]
        elseif screen.mode == "fuel" then
            output = output .. [[
            <rect class=hlrect x=584 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=672 y=50>FUEL</text>
            ]]
        elseif screen.mode == "flight" then
            output = output .. [[
            <rect class=hlrect x=776 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=864 y=50>FLGT</text>
            ]]
        elseif screen.mode == "cargo" then
            output = output .. [[
            <rect class=hlrect x=968 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=1056 y=50>CRGO</text>
            ]]
        elseif screen.mode == "agg" then
            output = output .. [[
            <rect class=hlrect x=1160 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=1248 y=50>AGG</text>
            ]]
        elseif screen.mode == "map" then
            output = output .. [[
            <rect class=hlrect x=1352 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=1440 y=50>MAP</text>
            ]]
        elseif screen.mode == "time" then
            output = output .. [[
            <rect class=hlrect x=8 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=96 y=50>TIME</text>
            ]]
        elseif screen.mode == "settings1" then
            output = output .. [[
            <rect class=hlrect x=1736 y=6 rx=0 ry=0 width=176 height=58 />
            <text class=f50mxx x=1824 y=50>SETS</text>
            ]]
        end
      output = output .. [[</svg>]]
    output = output .. [[</svg>]]
     
    -- Center:

    -- <line style="stroke: white;" class="xline" x1="960" y1="0" x2="960" y2="1040" />
    -- <line style="stroke: white;" class="xline" x1="0" y1="520" x2="1920" y2="520" />
    -- <line style="stroke: white;" class="xline" x1="960" y1="0" x2="960" y2="1120" />
    -- <line style="stroke: white;" class="xline" x1="0" y1="560" x2="1920" y2="560" />

    local outputLength = string.len(output)
    -- PrintConsole("Render: "..screen.mode.." ("..outputLength.." chars)")
    screen.element.setSVG(output)
end

function RenderScreens(onlymode, onlysubmode)

    onlymode = onlymode or "all"
    onlysubmode = onlysubmode or "all"

    if screens ~= nil and #screens > 0 then

        local contentFlight = ""
        local contentDamage = ""
        local contentDamageoutlineTop = ""
        local contentDamageoutlineSide = ""
        local contentDamageoutlineFront = ""
        local contentFuel = ""
        local contentCargo = ""
        local contentAGG = ""
        local contentMap = ""
        local contentTime = ""
        local contentSettings1 = ""
        local contentStartup = ""

        for k,screen in pairs(screens) do
            if screen.refresh == true then
                local contentToRender = ""

                if screen.mode == "flight" and (onlymode =="flight" or onlymode =="all") then
                    if contentFlight == "" then contentFlight = GetContentFlight() end
                    contentToRender = contentFlight
                elseif screen.mode == "damage" and (onlymode =="damage" or onlymode =="all") then
                    if contentDamage == "" then contentDamage = GetContentDamage() end
                    contentToRender = contentDamage
                elseif screen.mode == "damageoutline" and (onlymode =="damageoutline" or onlymode =="all") then
                    if screen.submode == "" then
                        screen.submode = "top"
                        screens[k].submode = "top"
                    end
                    if screen.submode == "top" and (onlysubmode == "top" or onlysubmode == "all") then
                        if contentDamageoutlineTop == "" then contentDamageoutlineTop = GetContentDamageoutline(screen) end
                        contentToRender = contentDamageoutlineTop
                    end
                    if screen.submode == "side" and (onlysubmode == "side" or onlysubmode == "all") then
                        if contentDamageoutlineSide == "" then contentDamageoutlineSide = GetContentDamageoutline(screen) end
                        contentToRender = contentDamageoutlineSide
                    end
                    if screen.submode == "front" and (onlysubmode == "front" or onlysubmode == "all") then 
                        if contentDamageoutlineFront == "" then contentDamageoutlineFront = GetContentDamageoutline(screen) end
                        contentToRender = contentDamageoutlineFront
                    end
                elseif screen.mode == "fuel" and (onlymode =="fuel" or onlymode =="all") then
                    screen = WipeClickAreasForScreen(screens[k])
                    contentToRender = GetContentFuel(screen)
                elseif screen.mode == "cargo" and (onlymode =="cargo" or onlymode =="all") then
                    if contentCargo == "" then contentCargo = GetContentCargo() end
                    contentToRender = contentCargo
                elseif screen.mode == "agg" and (onlymode =="agg" or onlymode =="all") then
                    if contentAGG == "" then contentAGG = GetContentAGG() end
                    contentToRender = contentAGG
                elseif screen.mode == "map" and (onlymode =="map" or onlymode =="all") then
                    if contentMap == "" then contentMap = GetContentMap() end
                    contentToRender = contentMap
                elseif screen.mode == "time" and (onlymode =="time" or onlymode =="all") then
                    if contentTime == "" then contentTime = GetContentTime() end
                    contentToRender = contentTime
                elseif screen.mode == "settings1" and (onlymode =="settings1" or onlymode =="all") then
                    if contentSettings1 == "" then contentSettings1 = GetContentSettings1() end
                    contentToRender = contentSettings1
                elseif screen.mode == "startup" and (onlymode =="startup" or onlymode =="all") then
                    if contentStartup == "" then contentStartup = GetContentStartup() end
                    contentToRender = contentStartup
                else
                    contentToRender = "Invalid screen mode. ('"..screen.mode.."')"
                end

                if contentToRender ~= "" then
                    RenderScreen(screen, contentToRender)
                else
                    DrawCenteredText("ERROR: No contentToRender delivered for "..screen.mode)
                    PrintConsole("ERROR: No contentToRender delivered for "..screen.mode)
                    unit.exit()
                end
                screens[k].refresh = false
            end
        end
    end

    if HUDMode == true then
         system.setScreen(GetContentDamageHUDOutput())
         system.showScreen(1)
    else
         system.showScreen(0)
    end

end