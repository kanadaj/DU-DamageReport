UpdateDataInterval = 0.2 -- How often shall the data be updated? (Increase if running into CPU issues.)
HighlightBlinkingInterval = 0.5 -- How fast shall highlight arrows of marked elements blink?

ColorPrimary = "FF6700" -- Enter the hexcode of the main color to be used by all views.
ColorSecondary = "FFFFFF" -- Enter the hexcode of the secondary color to be used by all views.
ColorTertiary = "000000" -- Enter the hexcode of the tertiary color to be used by all views.
ColorHealthy = "00FF00" -- Enter the hexcode of the 'healthy' color to be used by all views.
ColorWarning = "FFFF00" -- Enter the hexcode of the 'warning' color to be used by all views.
ColorCritical = "FF0000" -- Enter the hexcode of the 'critical' color to be used by all views.
ColorBackground = "000000" -- Enter the hexcode of the background color to be used by all views.
ColorBackgroundPattern = "4F4F4F" -- Enter the hexcode of the background color to be used by all views.
ColorFuelAtmospheric = "004444" -- Enter the hexcode of the atmospheric fuel color.
ColorFuelSpace = "444400" -- Enter the hexcode of the space fuel color.
ColorFuelRocket = "440044" -- Enter the hexcode of the rocket fuel color.

VERSION = 3.13
DebugMode = false
DebugRenderClickareas = true

DBData = {}

core = nil
db = nil
screens = {}
dscreens = {}
elements = {}

Warnings = {}

screenModes = { 
    ["flight"] = { id="flight" }, 
    ["damage"] = { id="damage" }, 
    ["damageoutline"] = { id="damageoutline" }, 
    ["fuel"] = { id="fuel" }, 
    ["cargo"] = { id="cargo" }, 
    ["agg"] = { id="agg" }, 
    ["map"] = { id="map" }, 
    ["time"] = { id="time", activetoggle="true" }, 
    ["settings1"] = { id="settings1" },
    ["startup"] = { id="startup" } 
}

backgroundModes = { "deathstar", "capsule", "rain", "signal", "hexagon", "diagonal", "diamond", "plus", "dots" }
BackgroundMode ="deathstar"
BackgroundSelected = 1
BackgroundModeOpacity = 0.25

SaveVars = { "dscreens",
                "ColorPrimary", "ColorSecondary", "ColorTertiary",
                "ColorHealthy", "ColorWarning", "ColorCritical",
                "ColorBackground", "ColorBackgroundPattern",
                "ColorFuelAtmospheric", "ColorFuelSpace", "ColorFuelRocket", 
                "ScrapTier", "HUDMode", "SimulationMode", "DMGOStretch",
                "HUDShiftU", "HUDShiftV", "colorIDIndex", "colorIDTable", 
                "BackgroundMode", "BackgroundSelected", "BackgroundModeOpacity" }

HUDMode = false
HUDShiftU = 0
HUDShiftV = 0
hudSelectedIndex = 0
hudStartIndex = 1
hudArrowSticker = {}
highlightOn = false
highlightID = 0
highlightX = 0
highlightY = 0
highlightZ = 0

index = 1
elementCount = 0

SimulationMode = false
OkayCenterMessage = "All systems nominal."
CurrentDamagedPage = 1
CurrentBrokenPage = 1
DamagePageSize = 12
ScrapTier = 1
totalScraps = 0
ScrapTierRepairTimes = { 10, 50, 250, 1250 }

coreWorldOffset = 0
totalShipHP = 0
formerTotalShipHP = -1
totalShipMaxHP = 0
totalShipIntegrity = 100
elementsId = {}
elementsIdList = {}
damagedElements = {}
brokenElements = {}
rE = {}
healthyElements = {}
typeElements = {}
ElementCounter = 0
UseMyElementNames = true
dmgoElements = {}
DMGOMaxElements = 250
DMGOStretch = false
ShipXmin = 99999999
ShipXmax = -99999999
ShipYmin = 99999999
ShipYmax = -99999999
ShipZmin = 99999999
ShipZmax = -99999999

totalShipMass = 0
formerTotalShipMass = -1

formerTime = -1

FuelAtmosphericTanks = {}
FuelSpaceTanks = {}
FuelRocketTanks = {}
FuelAtmosphericTotal = 0
FuelSpaceTotal = 0
FuelRocketTotal = 0
FuelAtmosphericCurrent = 0
FuelSpaceTotalCurrent = 0
FuelRocketTotalCurrent = 0
formerFuelAtmosphericTotal = -1
formerFuelSpaceTotal = -1
formerFuelRocketTotal = -1

hexTable = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"}
colorIDIndex = 1
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