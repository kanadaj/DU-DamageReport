function InitiateSlots()
    for slot_name, slot in pairs(unit) do
        if type(slot) == "table" and type(slot.export) == "table" and
            slot.getElementClass then
            local elementClass = slot.getElementClass():lower()
            if elementClass:find("coreunit") then
                core = slot
                local coreHP = core.getMaxHitPoints()
                if coreHP > 10000 then
                    coreWorldOffset = 128
                elseif coreHP > 1000 then
                    coreWorldOffset = 64
                elseif coreHP > 150 then
                    coreWorldOffset = 32
                else
                    coreWorldOffset = 16
                end
            elseif elementClass == 'databankunit' then
                db = slot
            elseif elementClass == "screenunit" then
                local iScreenMode = "startup"
                screens[#screens + 1] = { 
                    element = slot, 
                    id = slot.getId(),
                    mode = iScreenMode,
                    submode = "",
                    ClickAreas = {},
                    refresh = true,
                    active = false,
                    fuelA = true,
                    fuelS = true,
                    fuelR = true,
                    fuelIndex = 1
                }
            end
        end
    end
end

function InitiateScreens()
    if screens ~= nil and #screens > 0 then
        for i = 1, #screens, 1 do
            screens[i] = CreateClickAreasForScreen(screens[i])
        end
    end
end