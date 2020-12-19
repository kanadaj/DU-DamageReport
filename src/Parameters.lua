--[[ 1. USER DEFINED VARIABLES ]]

YourShipsName = "Enter here" --export Enter your ship name here if you want it displayed instead of the ship's ID. YOU NEED TO LEAVE THE QUOTATION MARKS.

SkillRepairToolEfficiency = 0 --export Enter (0-5) your talent "Mining and Inventory -> Equipment Manager -> Repair Tool Efficiency"
SkillRepairToolOptimization = 0 --export Enter your talent "Mining and Inventory -> Equipment Manager -> Repair Tool Optimization"

StatAtmosphericFuelTankHandling = 0 --export (0-5) Enter the LEVEL OF YOUR PLACED ATMOSPHERIC FUEL TANKS (from the builders talent "Piloting -> Atmospheric Flight Technician -> Atmospheric Fuel-Tank Handling")
StatSpaceFuelTankHandling = 0 --export (0-5) Enter the LEVEL OF YOUR PLACED FUEL SPACE TANKS (from the builders talent "Piloting -> Atmospheric Engine Technician -> Space Fuel-Tank Handling")
StatRocketFuelTankHandling = 0 --export (0-5) Enter the LEVEL OF YOUR PLACED FUEL ROCKET TANKS (from the builders talent "Piloting -> Rocket Scientist -> Rocket Booster Fuel Tank Handling")
StatContainerOptimization = 0 --export (0-5) Enter the LEVEL OF YOUR PLACED FUEL TANKS "from the builders talent Mining and Inventory -> Stock Control -> Container Optimization"
StatFuelTankOptimization = 0 --export (0-5) Enter the LEVEL OF YOUR PLACED FUEL TANKS "from the builders talent Mining and Inventory -> Stock Control -> Fuel Tank Optimization"

BatchSize = 200 --export The number of elements to update every tick. Higher numbers mean faster updates but higher CPU usage

ShowWelcomeMessage = true --export Do you want the welcome message on the start screen with your name?
DisallowKeyPresses = false --export Need your keys for other scripts/huds and want to prevent Damage Report keypresses to be processed? Then check this. (Usability of the HUD mode will be small.)
AddSummertimeHour = false --export: Is summertime currently enabled in your location? (Adds one hour.)

-- SkillAtmosphericFuelEfficiency = 0 --export Enter (0-5) your talent "Mining and Inventory -> Equipment Manager -> Repair Tool Efficiency"
-- SkillSpaceFuelEfficiency = 0 --export Enter (0-5) your talent "Mining and Inventory -> Equipment Manager -> Repair Tool Efficiency"
-- SkillRocketFuelEfficiency = 0 --export Enter (0-5) your talent "Mining and Inventory -> Equipment Manager -> Repair Tool Efficiency"

UpdateDataInterval = 0.2 -- export How often should we process each batch? (Increase if running into CPU issues.)