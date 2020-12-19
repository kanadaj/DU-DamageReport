function UpdateClickArea(candidate, newEntry, mode)
    for i, screen in ipairs(screens) do
        for k, v in pairs(screens[i].ClickAreas) do
            if v.id == candidate and v.mode == mode then
                screens[i].ClickAreas[k] = newEntry
            end
        end
    end
end

function AddClickArea(mode, newEntry)
    for i, screen in ipairs(screens) do
        if screens[i].mode == mode then
            table.insert(screens[i].ClickAreas, newEntry)
        end
    end
end

function AddClickAreaForScreenID(screenid, newEntry)
    for i, screen in ipairs(screens) do
        if screens[i].id == screenid then
            table.insert(screens[i].ClickAreas, newEntry)
        end
    end
end

function DisableClickArea(candidate, mode)
    UpdateClickArea(candidate, {
        id = candidate,
        mode = mode,
        x1 = -1,
        x2 = -1,
        y1 = -1,
        y2 = -1
    })
end

function SetRefresh(mode, submode)
    mode = mode or "all"
    submode = submode or "all"
    if screens ~= nil and #screens > 0 then
        for i = 1, #screens, 1 do
            if screens[i].mode == mode or mode == "all" then
                if screens[i].submode == submode or submode =="all" then
                    screens[i].refresh = true
                end
            end
        end
    end
end

function WipeClickAreasForScreen(screen)
    screen.ClickAreas = {}
    return screen
end

function CreateBaseClickAreas(screen)
    table.insert(screen.ClickAreas, {mode = "all", id = "ToggleHudMode", x1 = 1537, x2 = 1728, y1 = 1015, y2 = 1075} )
    table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "damage", x1 = 193, x2 = 384, y1 = 1015, y2 = 1075} )
    table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "damageoutline", x1 = 385, x2 = 576, y1 = 1015, y2 = 1075} )
    table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "fuel", x1 = 577, x2 = 768, y1 = 1015, y2 = 1075} )
    -- table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "flight", x1 = 769, x2 = 960, y1 = 1015, y2 = 1075} )
    -- table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "cargo", x1 = 961, x2 = 1152, y1 = 1015, y2 = 1075} )
    -- table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "agg", x1 = 1153, x2 = 1344, y1 = 1015, y2 = 1075} )
    -- table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "map", x1 = 1345, x2 = 1536, y1 = 1015, y2 = 1075} )
    table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "time", x1 = 0, x2 = 192, y1 = 1015, y2 = 1075} )
    table.insert(screen.ClickAreas, {mode = "all", id = "ButtonPress", param = "settings1", x1 = 1729, x2 = 1920, y1 = 1015, y2 = 1075} )
    return screen
end

function CreateClickAreasForScreen(screen)
    
    if screen == nil then return {} end

    if screen.mode == "flight" then
    elseif screen.mode == "damage" then        
        table.insert( screen.ClickAreas, {mode = "damage", id = "ToggleElementLabel", x1 = 70, x2 = 425, y1 = 325, y2 = 355} )
        table.insert( screen.ClickAreas, {mode = "damage", id = "ToggleElementLabel2", x1 = 980, x2 = 1400, y1 = 325, y2 = 355} )
    elseif screen.mode == "damageoutline" then
        table.insert(screen.ClickAreas, {mode = "damageoutline", id = "DMGOChangeView", param = "top", x1 = 60, x2 = 439, y1 = 150, y2 = 200} )
        table.insert(screen.ClickAreas, {mode = "damageoutline", id = "DMGOChangeView", param = "side", x1 = 440, x2 = 824, y1 = 150, y2 = 200} )
        table.insert(screen.ClickAreas, {mode = "damageoutline", id = "DMGOChangeView", param = "front", x1 = 825, x2 = 1215, y1 = 150, y2 = 200} )
        table.insert(screen.ClickAreas, {mode = "damageoutline", id = "DMGOChangeStretch", x1 = 1530, x2 = 1580, y1 = 150, y2 = 200} )
    elseif screen.mode == "fuel" then
    elseif screen.mode == "cargo" then
    elseif screen.mode == "agg" then
    elseif screen.mode == "map" then
    elseif screen.mode == "time" then
    elseif screen.mode == "settings1" then
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ToggleBackground", x1 = 75, x2 = 860, y1 = 170, y2 = 215} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "PreviousBackground", x1 = 75, x2 = 460, y1 = 235, y2 = 285} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "NextBackground", x1 = 480, x2 = 860, y1 = 235, y2 = 285} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "DecreaseOpacity", x1 = 75, x2 = 460, y1 = 300, y2 = 350} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "IncreaseOpacity", x1 = 480, x2 = 860, y1 = 300, y2 = 350} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ResetColors", x1 = 75, x2 = 860, y1 = 370, y2 = 415} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "PreviousColorID", x1 = 90, x2 = 140, y1 = 500, y2 = 550} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "NextColorID", x1 = 795, x2 = 845, y1 = 500, y2 = 550} )

        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="1", x1 = 210, x2 = 290, y1 = 655, y2 = 700} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="2", x1 = 300, x2 = 380, y1 = 655, y2 = 700} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="3", x1 = 385, x2 = 465, y1 = 655, y2 = 700} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="4", x1 = 470, x2 = 550, y1 = 655, y2 = 700} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="5", x1 = 560, x2 = 640, y1 = 655, y2 = 700} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosUp", param="6", x1 = 645, x2 = 725, y1 = 655, y2 = 700} )

        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="1", x1 = 210, x2 = 290, y1 = 740, y2 = 780} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="2", x1 = 300, x2 = 380, y1 = 740, y2 = 780} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="3", x1 = 385, x2 = 465, y1 = 740, y2 = 780} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="4", x1 = 470, x2 = 550, y1 = 740, y2 = 780} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="5", x1 = 560, x2 = 640, y1 = 740, y2 = 780} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ColorPosDown", param="6", x1 = 645, x2 = 725, y1 = 740, y2 = 780} )

        table.insert( screen.ClickAreas, {mode = "settings1", id = "ResetPosColor", x1 = 160, x2 = 340, y1 = 885, y2 = 935} )
        table.insert( screen.ClickAreas, {mode = "settings1", id = "ApplyPosColor", x1 = 355, x2 = 780, y1 = 885, y2 = 935} )

    elseif screen.mode == "startup" then
    end

    screen = CreateBaseClickAreas(screen)

    return screen
end

function CheckClick(x, y, HitTarget)
    x = x*1920
    y = y*1120
    HitTarget = HitTarget or ""
    HitPayload = {}
    -- PrintConsole("Clicked: "..x.." / "..y)
    if screens ~= nil and #screens > 0 then
        for i = 1, #screens, 1 do
            if screens[i].active == true and screens[i].element.getMouseX() ~= -1 and screens[i].element.getMouseY() ~= -1 then
               if HitTarget == "" then
                    for k, v in pairs(screens[i].ClickAreas) do
                        if v ~=nil and x >= v.x1 and x <= v.x2 and y >= v.y1 and y <= v.y2 then
                            HitTarget = v.id
                            HitPayload = v
                            break
                        end
                    end
                end
                if HitTarget == "ButtonPress" then
                    if screens[i].mode == HitPayload.param then
                        screens[i].mode = "startup"
                    else
                        screens[i].mode = HitPayload.param
                    end

                    if screens[i].mode == "damageoutline" then
                        if screens[i].submode == "" then
                            screens[i].submode = "top"
                        end
                    end
                    screens[i].refresh = true
                    screens[i].ClickAreas = {}
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "ToggleBackground" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if BackgroundMode == "" then
                        BackgroundSelected = 1
                        BackgroundMode = backgroundModes[BackgroundSelected]
                    else
                        BackgroundSelected = 1
                        BackgroundMode = ""
                    end
                    for k, screen in pairs(screens) do
                        screens[k].refresh = true
                    end
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "PreviousBackground" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if BackgroundMode == "" then
                        BackgroundSelected = 1
                        BackgroundMode = backgroundModes[BackgroundSelected]
                    else
                        if BackgroundSelected <= 1 then
                            BackgroundSelected = #backgroundModes
                        else
                            BackgroundSelected = BackgroundSelected - 1
                        end
                        BackgroundMode = backgroundModes[BackgroundSelected]
                    end
                    for k, screen in pairs(screens) do
                        screens[k].refresh = true
                    end
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "NextBackground" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                     if BackgroundMode == "" then
                        BackgroundSelected = 1
                        BackgroundMode = backgroundModes[BackgroundSelected]
                    else
                        if BackgroundSelected >= #backgroundModes then
                            BackgroundSelected = 1
                        else
                            BackgroundSelected = BackgroundSelected + 1
                        end
                        BackgroundMode = backgroundModes[BackgroundSelected]
                    end
                    for k, screen in pairs(screens) do
                        screens[k].refresh = true
                    end
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "DecreaseOpacity" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if BackgroundModeOpacity>0.1 then
                        BackgroundModeOpacity = BackgroundModeOpacity - 0.05
                        for k, screen in pairs(screens) do
                            screens[k].refresh = true
                        end
                        SaveToDatabank()
                        SetRefresh()
                        RenderScreens()
                    end
                elseif HitTarget == "IncreaseOpacity" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if BackgroundModeOpacity<1.0 then
                        BackgroundModeOpacity = BackgroundModeOpacity + 0.05
                        for k, screen in pairs(screens) do
                            screens[k].refresh = true
                        end
                        SaveToDatabank()
                        SetRefresh()
                        RenderScreens()
                    end
                elseif HitTarget == "ResetColors" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then                
                    db.clear()
                    ColorPrimary = "FF6700"
                    ColorSecondary = "FFFFFF"
                    ColorTertiary = "000000"
                    ColorHealthy = "00FF00"
                    ColorWarning = "FFFF00"
                    ColorCritical = "FF0000"
                    ColorBackground = "000000"
                    ColorBackgroundPattern = "4f4f4f"
                    ColorFuelAtmospheric = "004444"
                    ColorFuelSpace = "444400"
                    ColorFuelRocket = "440044"
                    BackgroundMode = "deathstar"
                    BackgroundSelected = 1
                    BackgroundModeOpacity = 0.25
                    colorIDTable = {
                        [1] = {
                            id="ColorPrimary",
                            desc="Main HUD Color",
                            basec = "FF6700", 
                            newc = "FF6700"
                        },
                        [2] = {
                            id="ColorSecondary",
                            desc="Secondary HUD Color",
                            basec = "FFFFFF", 
                            newc = "FFFFFF"
                        },
                        [3] = { 
                            id="ColorTertiary",
                            desc="Tertiary HUD Color",
                            basec = "000000", 
                            newc = "000000"
                        },
                        [4] = { 
                            id="ColorHealthy",
                            desc="Color code for Healthy/Okay",
                            basec = "00FF00", 
                            newc = "00FF00"
                        },
                        [5] = { 
                            id="ColorWarning",
                            desc="Color code for Damaged/Warning",
                            basec = "FFFF00", 
                            newc = "FFFF00"
                        },
                        [6] = { 
                            id="ColorCritical",
                            desc="Color code for Broken/Critical",
                            basec = "FF0000", 
                            newc = "FF0000"
                        },
                        [7] = { 
                            id="ColorBackground",
                            desc="Background Color",
                            basec = "000000", 
                            newc = "000000"
                        },
                        [8] = { 
                            id="ColorBackgroundPattern",
                            desc="Background Pattern Color",
                            basec = "4F4F4F", 
                            newc = "4F4F4F"
                        },
                        [9] = { 
                            id="ColorFuelAtmospheric",
                            desc="Color for Atmo Fuel/Elements",
                            basec = "004444", 
                            newc = "004444"
                        },
                        [10] = { 
                            id="ColorFuelSpace",
                            desc="Color for Space Fuel/Elements",
                            basec = "444400", 
                            newc = "444400"
                        },
                        [11] = { 
                            id="ColorFuelRocket",
                            desc="Color for Rocket Fuel/Elements",
                            basec = "440044", 
                            newc = "440044"
                        }
                    }
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "PreviousColorID" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    colorIDIndex = colorIDIndex - 1
                    if colorIDIndex < 1 then colorIDIndex = #colorIDTable end
                    SaveToDatabank()
                    SetRefresh("settings1")
                    RenderScreens("settings1")
                elseif HitTarget == "NextColorID" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    colorIDIndex = colorIDIndex + 1
                    if colorIDIndex > #colorIDTable then colorIDIndex = 1 end
                    SaveToDatabank()
                    SetRefresh("settings1")
                    RenderScreens("settings1")
                elseif HitTarget == "ColorPosUp" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    local s = tonumber(string.sub(colorIDTable[colorIDIndex].newc, HitPayload.param, HitPayload.param),16)
                    s = s + 1
                    if s > 15 then s = 0 end
                    colorIDTable[colorIDIndex].newc = replace_char(HitPayload.param, colorIDTable[colorIDIndex].newc, hexTable[s+1])
                    SaveToDatabank()
                    SetRefresh("settings1")
                    RenderScreens("settings1")
                elseif HitTarget == "ColorPosDown" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    local s = tonumber(string.sub(colorIDTable[colorIDIndex].newc, HitPayload.param, HitPayload.param),16)
                    s = s - 1
                    if s < 0 then s = 15 end
                    colorIDTable[colorIDIndex].newc = replace_char(HitPayload.param, colorIDTable[colorIDIndex].newc, hexTable[s+1])
                    SaveToDatabank()
                    SetRefresh("settings1")
                    RenderScreens("settings1")
                elseif HitTarget == "ResetPosColor" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    colorIDTable[colorIDIndex].newc = colorIDTable[colorIDIndex].basec
                    _G[colorIDTable[colorIDIndex].id] = colorIDTable[colorIDIndex].basec
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "ApplyPosColor" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    _G[colorIDTable[colorIDIndex].id] = colorIDTable[colorIDIndex].newc
                    SaveToDatabank()
                    SetRefresh()
                    RenderScreens()
                elseif HitTarget == "DamagedPageDown" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    CurrentDamagedPage = CurrentDamagedPage + 1
                    if CurrentDamagedPage > math.ceil(#damagedElements / DamagePageSize) then
                        CurrentDamagedPage = math.ceil(#damagedElements / DamagePageSize)
                    end
                    HudDeselectElement()
                    SaveToDatabank()
                    SetRefresh("damage")
                    RenderScreens("damage")
                elseif HitTarget == "DamagedPageUp" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    CurrentDamagedPage = CurrentDamagedPage - 1
                    if CurrentDamagedPage < 1 then CurrentDamagedPage = 1 end
                    HudDeselectElement()
                    SaveToDatabank()
                    SetRefresh("damage")
                    RenderScreens("damage")
                elseif HitTarget == "BrokenPageDown" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    CurrentBrokenPage = CurrentBrokenPage + 1
                    if CurrentBrokenPage > math.ceil(#brokenElements / DamagePageSize) then
                        CurrentBrokenPage = math.ceil(#brokenElements / DamagePageSize)
                    end
                    HudDeselectElement()
                    SaveToDatabank()
                    SetRefresh("damage")
                    RenderScreens("damage")
                elseif HitTarget == "BrokenPageUp" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    CurrentBrokenPage = CurrentBrokenPage - 1
                    if CurrentBrokenPage < 1 then CurrentBrokenPage = 1 end
                    HudDeselectElement()
                    SaveToDatabank()
                    SetRefresh("damage")
                    RenderScreens("damage")
                elseif HitTarget == "DMGOChangeView" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    screens[i].submode = HitPayload.param
                    UpdateViewDamageoutline(screens[i])
                    SaveToDatabank()
                    SetRefresh("damageoutline", screens[i].submode)
                    RenderScreens("damageoutline", screens[i].submode)
                elseif HitTarget == "DMGOChangeStretch" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if DMGOStretch == true then
                        DMGOStretch = false
                    else
                        DMGOStretch = true
                    end
                    UpdateViewDamageoutline(screens[i])
                    SaveToDatabank()
                    SetRefresh("damageoutline")
                    RenderScreens("damageoutline")
                elseif HitTarget == "ToggleDisplayAtmosphere" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if screens[i].fuelA == true then
                        screens[i].fuelA = false
                    else
                        screens[i].fuelA = true
                    end
                    screens[i].fuelIndex = 1
                    SaveToDatabank()
                    SetRefresh("fuel")
                    RenderScreens("fuel")
                elseif HitTarget == "ToggleDisplaySpace" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if screens[i].fuelS == true then
                        screens[i].fuelS = false
                    else
                        screens[i].fuelS = true
                    end
                    screens[i].fuelIndex = 1
                    SaveToDatabank()
                    SetRefresh("fuel")
                    RenderScreens("fuel")
                elseif HitTarget == "ToggleDisplayRocket" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if screens[i].fuelR == true then
                        screens[i].fuelR = false
                    else
                        screens[i].fuelR = true
                    end
                    screens[i].fuelIndex = 1
                    SaveToDatabank()
                    SetRefresh("fuel")
                    RenderScreens("fuel")
                elseif HitTarget == "DecreaseFuelIndex" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    screens[i].fuelIndex = screens[i].fuelIndex - 1
                    if screens[i].fuelIndex < 1 then screens[i].fuelIndex = 1 end
                    SaveToDatabank()
                    SetRefresh("fuel")
                    RenderScreens("fuel")
                elseif HitTarget == "IncreaseFuelIndex" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    screens[i].fuelIndex = screens[i].fuelIndex + 1
                    SaveToDatabank()
                    SetRefresh("fuel")
                    RenderScreens("fuel")
                elseif HitTarget == "ToggleHudMode" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if HUDMode == true then
                        HUDMode = false
                        forceDamageRedraw = true
                        HudDeselectElement()
                        SaveToDatabank()
                        SetRefresh()
                        RenderScreens()
                    else
                        HUDMode = true
                        forceDamageRedraw = true
                        HudDeselectElement()
                        SaveToDatabank()
                        SetRefresh()
                        RenderScreens()
                    end
                elseif HitTarget == "ToggleSimulation" and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    CurrentDamagedPage = 1
                    CurrentBrokenPage = 1
                    if SimulationMode == true then
                        SimulationMode = false
                        SimulationActive = false
                        UpdateDamageData()
                        UpdateTypeData()
                        forceDamageRedraw = true
                        HudDeselectElement()
                        SetRefresh("damage")
                        SetRefresh("damageoutline")
                        SetRefresh("settings1")
                        SetRefresh("fuel")
                        SaveToDatabank()
                        RenderScreens()
                    else
                        SimulationMode = true
                        SimulationActive = false
                        UpdateDamageData()
                        UpdateTypeData()
                        forceDamageRedraw = true
                        HudDeselectElement()
                        SetRefresh("damage")
                        SetRefresh("damageoutline")
                        SetRefresh("settings1")
                        SetRefresh("fuel")
                        SaveToDatabank()
                        RenderScreens()
                    end
                elseif (HitTarget == "ToggleElementLabel" or HitTarget == "ToggleElementLabel2") and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    if UseMyElementNames == true then
                        UseMyElementNames = false
                        SetRefresh("damage")
                        RenderScreens("damage")
                    else
                        UseMyElementNames = true
                        SetRefresh("damage")
                        RenderScreens("damage")
                    end
                elseif (HitTarget == "SwitchScrapTier" or HitTarget == "SwitchScrapTier2") and (HitPayload.mode == screens[i].mode or HitPayload.mode == "all") then
                    ScrapTier = ScrapTier + 1
                    if ScrapTier > 4 then ScrapTier = 1 end
                    SetRefresh("damage")
                    RenderScreens("damage")
                end


            end
        end
    end
end