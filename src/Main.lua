script = {}

function script.onMouseDown (x, y)
    CheckClick(x, y)
end

function script.onTick (timerId)
    if(timerId == "UpdateData") then
        OnTickData()
    elseif (timerId == "UpdateHighlight") then
        ToggleHighlight()
    end
end

function script.onActionStart(action)
    if action == "up" then
        ActionUp()
    elseif action == "down" then
        ActionDown()
    elseif action == "strafeleft" then
        ActionStrafeLeft()
    elseif action == "straferight" then
        ActionStrafeRight()
    elseif action == "brake" then
        KeyCTRLPressed = true
    elseif action == "option1" then
        ActionOption1()
    elseif action == "option2" then
        ActionOption2()
    elseif action == "option3" then
        ActionOption3()
    elseif action == "option4" then
        ActionOption4()
    elseif action == "option5" then
        ActionOption5()
    elseif action == "option6" then
        ActionOption6()
    elseif action == "option7" then
        ActionOption7()
    elseif action == "option8" then
        ActionOption8()
    elseif action == "option9" then
        ActionOption9()
    end
end

function script.onActionStop(action)
    if action == "brake" then
        KeyCTRLPressed = false
    end
end

function script.onStart()
    unit.hide()
    ClearConsole()
    PrintConsole("DAMAGE REPORT v"..VERSION.." STARTED", true)
    InitiateSlots()
    LoadFromDatabank()
    SwitchScreens("on")
    InitiateScreens()
    
    if core == nil then
        PrintConsole("ERROR: Connect the core to the programming board.")
        unit.exit()
    else
        OperatorID = unit.getMasterPlayerId()
        OperatorData = database.getPlayer(OperatorID)
        PlayerName = OperatorData["name"]
        ShipID = core.getConstructId()
    end
    
    if db == nil then
        table.insert(Warnings, "No databank connected, won't save/load settings.")
    end
    
    if YourShipsName == "Enter here" then
        table.insert(Warnings, "No ship name set in LUA settings.")
    end
    
    if SkillRepairToolEfficiency == 0 and SkillRepairToolOptimization == 0 and StatFuelTankOptimization == 0 and StatContainerOptimization ==0 and 
        StatAtmosphericFuelTankHandling == 0 and StatSpaceFuelTankHandling == 0 and StatRocketFuelTankHandling ==0 then
        table.insert(Warnings, "No talents/stats set in LUA settings.")
    end
    
    if SkillRepairToolEfficiency < 0 or SkillRepairToolOptimization < 0 or StatFuelTankOptimization < 0 or StatContainerOptimization < 0 or 
        StatAtmosphericFuelTankHandling < 0 or StatSpaceFuelTankHandling < 0 or StatRocketFuelTankHandling < 0 or 
        SkillRepairToolEfficiency > 5 or SkillRepairToolOptimization > 5 or StatFuelTankOptimization > 5 or StatContainerOptimization > 5 or
        StatAtmosphericFuelTankHandling > 5 or StatSpaceFuelTankHandling > 5 or StatRocketFuelTankHandling > 5 then
            PrintConsole("ERROR: Talents/stats can only range from 0 to 5. Please set correctly in LUA settings and reactivate script.")
            unit.exit()
    end
    
    if screens == nil or #screens == 0 then
        HUDMode = true
        PrintConsole("Warning: No screens connected. Entering HUD mode only.")
    end
    
    UpdateElementList()
    OnTickData()
    
    unit.setTimer('UpdateData', UpdateDataInterval)
    unit.setTimer('UpdateHighlight', HighlightBlinkingInterval)
end

script.onStart()