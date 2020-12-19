--[[ 4. RENDERING FUNCTIONS ]]

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