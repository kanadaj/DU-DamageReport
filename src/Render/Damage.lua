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