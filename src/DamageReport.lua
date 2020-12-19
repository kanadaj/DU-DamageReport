--[[
    Damage Report 3.13
    A LUA script for Dual Universe

    Created By Dorian Gray
    Ingame: DorianGray
    Discord: Dorian Gray#2623
    
    Modified By Kanadaj
    Discord: Kanadaj#5656

    You can find/update this script on GitHub. Explanations, installation and usage information as well as screenshots can be found there too.
    GitHub: https://github.com/Bayouking1/DU-DamageReport

    GNU Public License 3.0. Use whatever you want, be so kind to leave credit.
    
    Credits & thanks: 
        Thanks to NovaQuark for creating the MMO of the century.
        Thanks to Jericho, Dmentia and Archaegeo for learning a lot from their fine scripts.
        Thanks to TheBlacklist for testing and wonderful suggestions.
        SVG patterns by Hero Patterns.
        DU atlas data from Jayle Break.
        
]]

function UpdateElementList()
    if core == nil then
        return
    end
    elementsIdList = core.getElementIdList()
    
    elements = {}
    ElementCounter = 0
    totalShipMaxHP = 0
    typeElements = {}
    for i, id in pairs(elementsIdList) do
        local idName = core.getElementNameById(id)

        local idType = core.getElementTypeById(id)
        -- local idTypeClean = idType:gsub("[%s%-]+", ""):lower()
        local idPos = core.getElementPositionById(id)
        local idMaxHP = core.getElementMaxHitPointsById(id)
        totalShipMaxHP = totalShipMaxHP + idMaxHP
        elements[i] = {
            id = id,
            name = idName,
            type = idType,
            pos = idPos,
            status = 'healthy',
            counter = i,
            hp = nil,
            maxhp = idMaxHP,
            previoushp = idMaxHP,
            missinghp = 0,
            percent = nil,
            pos = idPos
        }
        ElementCounter = ElementCounter + 1
        
        if
            string.match(string.lower(idType), "fuel tank")
        then
            table.insert(typeElements, id)
        end
    end
    totalShipHP = totalShipMaxHP
end

function UpdateDamage()   
    if index > ElementCounter then
        index = 1
    end
    local originalHp = totalShipHP
    local maxValue = math.min(index + BatchSize, ElementCounter)
    for i = index, maxValue do
        local id = elements[i].id
        local idHP = core.getElementHitPointsById(id)
        if elements[i].hp ~= idHP then
            forceDamageRedraw = true
        end
        elements[i].hp = idHP
        totalShipHP = totalShipHP - elements[i].previoushp + elements[i].hp
        elements[i].previoushp = elements[i].hp
        elements[i].missinghp = elements[i].maxhp - idHP
        elements[i].percent = math.ceil(100 / elements[i].maxhp * idHP)
    end
    if originalHp ~= totalShipHP then
        SetRefresh("damage")
        SetRefresh("damageoutline")
    end
    UpdateTables()
    index = index + BatchSize 
end

function UpdateTables()
    damagedElements = {}
    brokenElements = {}
    healthyElements = {}
    for i, element in pairs(elements) do

        if element.hp == nil then
            table.insert(healthyElements, {
                id = element.id,
                name = element.name,
                type = element.type,
                pos = element.pos,
                status = 'healthy',
                counter = element.counter,
                hp = element.maxhp,
                maxhp = element.maxhp,
                missinghp = 0,
                percent = 100,
            })
        elseif element.hp == 0 then
            table.insert(brokenElements, element)
        elseif element.maxhp - element.hp > constants.epsilon then
            table.insert(damagedElements, element)
        else
            table.insert(healthyElements, element)
        end
    end
end

function UpdateTypeData()
    FuelAtmosphericTanks = {}
    FuelSpaceTanks = {}
    FuelRocketTanks = {}

    FuelAtmosphericTotal = 0
    FuelAtmosphericCurrent = 0
    FuelSpaceTotal = 0
    FuelSpaceCurrent = 0
    FuelRocketCurrent = 0
    FuelRocketTotal = 0

    local weightAtmosphericFuel = 4
    local weightSpaceFuel = 6
    local weightRocketFuel = 0.8

    --[[
    (FuelMass * (1-.05 * <Container Optimization Talent Level>) * (1-.05 * <Fuel Tank Optimization Talent Level>)
    It just seems to be that the Container Optimization and Fuel Tank Optimization are not added together so the max is not -50% (25% from each skill from the base mass) but 43.75% So the Fuel Tank Optimization uses the container optimization result as it's base value
    ]]

    if StatContainerOptimization > 0 then
        weightAtmosphericFuel = weightAtmosphericFuel - 0.05 * StatContainerOptimization * weightAtmosphericFuel
        weightSpaceFuel = weightSpaceFuel - 0.05 * StatContainerOptimization * weightSpaceFuel
        weightRocketFuel = weightRocketFuel - 0.05 * StatContainerOptimization * weightRocketFuel
    end
    if StatFuelTankOptimization > 0 then
        weightAtmosphericFuel = weightAtmosphericFuel - 0.05 * StatFuelTankOptimization * weightAtmosphericFuel
        weightSpaceFuel = weightSpaceFuel - 0.05 * StatFuelTankOptimization * weightSpaceFuel
        weightRocketFuel = weightRocketFuel - 0.05 * StatFuelTankOptimization * weightRocketFuel
    end

    for i, id in ipairs(typeElements) do
        local idName = core.getElementNameById(id) or ""
        local idType = core.getElementTypeById(id) or ""
        -- local idTypeClean = idType:gsub("[%s%-]+", ""):lower()
        local idPos = core.getElementPositionById(id) or 0
        local idHP = core.getElementHitPointsById(id) or 0
        local idMaxHP = core.getElementMaxHitPointsById(id) or 0
        local idMass = core.getElementMassById(id) or 0

        local baseSize = ""
        local baseVol = 0
        local baseMass = 0
        local cMass = 0
        local cVol = 0

        if string.lower(idType) == "atmospheric fuel tank" then
            if idMaxHP > 10000 then 
                baseSize = "L"
                baseMass = 5480
                baseVol = 12800
            elseif idMaxHP > 1300 then
                baseSize = "M"
                baseMass = 988.67
                baseVol = 1600
            elseif idMaxHP > 150 then
                baseSize = "S"
                baseMass = 182.67
                baseVol = 400
            else
                baseSize = "XS"
                baseMass = 35.03
                baseVol = 100
            end
            if StatAtmosphericFuelTankHandling > 0 then
                baseVol = 0.2 * StatAtmosphericFuelTankHandling * baseVol + baseVol
            end
            cMass = idMass - baseMass
            if cMass <=10 then cMass = 0 end
            cVol = string.format("%.0f", cMass / weightAtmosphericFuel)
            cPercent = string.format("%.1f", math.floor(100/baseVol * tonumber(cVol)))
            table.insert(FuelAtmosphericTanks, {
                type = 1,
                id = id,
                name = idName,
                maxhp = idMaxHP,
                hp = GetHPforElement(id),
                pos = idPos,
                size = baseSize,
                mass = baseMass,
                vol = baseVol,
                cvol = cVol,
                percent = cPercent
            })
            if idHP > 0 then
                FuelAtmosphericCurrent = FuelAtmosphericCurrent + cVol
            end
            FuelAtmosphericTotal = FuelAtmosphericTotal + baseVol
        elseif string.lower(idType) == "space fuel tank" then
            if idMaxHP > 10000 then
                baseSize = "L"
                baseMass = 5480
                baseVol = 12800
            elseif idMaxHP > 1300 then
                baseSize = "M"
                baseMass = 988.67
                baseVol = 1600
            else
                baseSize = "S"
                baseMass = 182.67
                baseVol = 400
            end
            if StatSpaceFuelTankHandling > 0 then
                baseVol = 0.2 * StatSpaceFuelTankHandling * baseVol + baseVol
            end
            cMass = idMass - baseMass
            if cMass <=10 then cMass = 0 end
            cVol = string.format("%.0f", cMass / weightSpaceFuel)
            cPercent = string.format("%.1f", (100/baseVol * tonumber(cVol)))
            table.insert(FuelSpaceTanks, {
                type = 2,
                id = id,
                name = idName,
                maxhp = idMaxHP,
                hp = GetHPforElement(id),
                pos = idPos,
                size = baseSize,
                mass = baseMass,
                vol = baseVol,
                cvol = cVol,
                percent = cPercent
            })
            if idHP > 0 then
                FuelSpaceCurrent = FuelSpaceCurrent + cVol
            end
            FuelSpaceTotal = FuelSpaceTotal + baseVol
        elseif string.lower(idType) == "rocket fuel tank" then
            if idMaxHP > 65000 then 
                baseSize = "L"
                baseMass = 25740
                baseVol = 50000
            elseif idMaxHP > 6000 then
                baseSize = "M"
                baseMass = 4720
                baseVol = 6400
            elseif idMaxHP > 700 then
                baseSize = "S"
                baseMass = 886.72
                baseVol = 800
            else
                baseSize = "XS"
                baseMass = 173.42
                baseVol = 400
            end
            if StatRocketFuelTankHandling > 0 then
                baseVol = 0.2 * StatRocketFuelTankHandling * baseVol + baseVol
            end
            cMass = idMass - baseMass
            if cMass <=10 then cMass = 0 end
            cVol = string.format("%.0f", cMass / weightRocketFuel)
            cPercent = string.format("%.1f", (100/baseVol * tonumber(cVol)))
            table.insert(FuelRocketTanks, {
                type = 3,
                id = id,
                name = idName,
                maxhp = idMaxHP,
                hp = GetHPforElement(id),
                pos = idPos,
                size = baseSize,
                mass = baseMass,
                vol = baseVol,
                cvol = cVol,
                percent = cPercent
            })
            if idHP > 0 then
                FuelRocketCurrent = FuelRocketCurrent + cVol
            end
            FuelRocketTotal = FuelRocketTotal + baseVol
        end

    end

    if FuelAtmosphericCurrent ~= formerFuelAtmosphericCurrent then
        SetRefresh("fuel")
        formerFuelAtmosphericCurrent = FuelAtmosphericCurrent
    end
    if FuelSpaceCurrent ~= formerFuelSpaceCurrent then
        SetRefresh("fuel")
        formerFuelSpaceCurrent = FuelSpaceCurrent
    end
    if FuelRocketCurrent ~= formerFuelRocketCurrent then
        SetRefresh("fuel")
        formerFuelRocketCurrent = FuelRocketCurrent
    end



end

function UpdateDamageData()
    local formerTotalShipHP = totalShipHP
    UpdateDamage()

    SortDamageTables()

    rE = {}

    if #brokenElements > 0 then
        for _,v in ipairs(brokenElements) do
            table.insert(rE, {id=v.id, missinghp=v.missinghp, hp=v.hp, name=v.name, type=v.type, pos=v.pos})
        end
    end
    if #damagedElements > 0 then
        for _,v in ipairs(damagedElements) do
            table.insert(rE, {id=v.id, missinghp=v.missinghp, hp=v.hp, name=v.name, type=v.type, pos=v.pos})
        end
    end
    if #rE > 0 then
        table.sort(rE, function(a,b) return a.missinghp>b.missinghp end)
    end

    totalShipIntegrity = string.format("%2.0f", 100 / totalShipMaxHP * totalShipHP)

    if formerTotalShipHP ~= totalShipHP then
        forceDamageRedraw = true
        formerTotalShipHP = totalShipHP
    else
        forceDamageRedraw = false
    end
end

function GetHPforElement(id)
    for i,v in ipairs(brokenElements) do
        if v.id == id then
            return 0
        end
    end
    for i,v in ipairs(damagedElements) do
        if v.id == id then
            return v.hp
        end 
    end
    for i,v in ipairs(healthyElements) do
        if v.id == id then
            return v.maxhp
        end 
    end
end

function OnTickData()
    if formerTime + 60 < system.getTime() then
        SetRefresh("time")
    end
    totalShipMass = core.getConstructMass()
    if formerTotalShipMass ~= totalShipMass then
        UpdateElementList()
        UpdateDamageData()
        UpdateTypeData()
        SetRefresh()
        formerTotalShipMass = totalShipMass
    else
        UpdateDamageData()
        UpdateTypeData()
    end
    RenderScreens()
end

