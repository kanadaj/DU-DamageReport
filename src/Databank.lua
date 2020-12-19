function LoadFromDatabank()
    if db == nil then
        return
    else
        for _, data in pairs(SaveVars) do
            if db.hasKey(data) then
                local jData = json.decode( db.getStringValue(data) )
                if jData ~= nil then
                    if data == "YourShipsName" or data == "AddSummertimeHour" or data == "UpdateDataInterval" or data == "HighlightBlinkingInterval" or
                        data == "SkillRepairToolEfficiency" or data == "SkillRepairToolOptimization" or data == "SkillAtmosphericFuelEfficiency" or
                        data == "SkillSpaceFuelEfficiency" or data == "SkillRocketFuelEfficiency" or data == "StatAtmosphericFuelTankHandling" or
                        data == "StatSpaceFuelTankHandling" or data ==  "StatRocketFuelTankHandling" 
                    then
                        -- Nada
                    else
                        _G[data] = jData
                    end
                end
            end
        end
            
        for i,v in ipairs(screens) do
            for j,dv in ipairs(dscreens) do
                if screens[i].id == dscreens[j].id then
                    screens[i].mode = dscreens[j].mode
                    screens[i].submode = dscreens[j].submode
                    screens[i].active = dscreens[j].active
                    screens[i].refresh = true
                    screens[i].fuelA = dscreens[j].fuelA
                    screens[i].fuelS = dscreens[j].fuelS
                    screens[i].fuelR = dscreens[j].fuelR
                    screens[i].fuelIndex = dscreens[j].fuelIndex
                end
            end
        end
    end    
end

function SaveToDatabank()
    if db == nil then
        return
    else
        dscreens = {}
        for i,screen in ipairs(screens) do
            dscreens[i] = {}
            dscreens[i].id = screen.id
            dscreens[i].mode = screen.mode
            dscreens[i].submode = screen.submode
            dscreens[i].active = screen.active
            dscreens[i].fuelA = screen.fuelA
            dscreens[i].fuelS = screen.fuelS
            dscreens[i].fuelR = screen.fuelR
            dscreens[i].fuelIndex = screen.fuelIndex
        end

        db.clear()

        for _, data in pairs(SaveVars) do
            db.setStringValue(data, json.encode(_G[data]))
        end

    end
end