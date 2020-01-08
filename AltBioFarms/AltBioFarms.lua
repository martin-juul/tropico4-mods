-- BioFarm Mod by DarthPresidente
-- Place in Tropico\Game Folder

-- Changes Bio farms so they can produce all of one crop type
-- or Foodcrops.  I had to eliminate Cashcrops because the UI
-- is designed to allow for a max of 8 work modes and I am too
-- lazy to mod that.

local AltBioFarmMTP = {Corn = {"Corn"}, Banana = {"Banana"}, Papaya = {"Papaya"}, Pineapple = {"Pineapple"}, Coffee = {"Coffee"}, Tobacco = {"Tobacco"}, Sugar = {"Sugar"}, Foodcrops = {"Banana", "Papaya", "Pineapple"}}

local AltBioFarmWorkModes = {{id = "Corn", name = "[[10922][Corn][]]", param1 = 230, param2 = 232, param3 = 450, rollover = "[[28730][The Bio Farm will produce Corn in all its fields][]]"}, {id = "Banana", name = "[[28718][Banana][PlantFarm name]]", param1 = 330, param2 = 371, param3 = 450, rollover = "[[28719][Bananas are a versatile crop that prefers relatively higher ground. The Bio Farm will produce Bananas in this work mode][WorkModeWrapper rollover]]"}, {id = "Papaya", name = "[[28720][Papaya][PlantFarm name]]", param1 = 330, param2 = 313, param3 = 450, rollover = "[[31367][Papayas prefer humid areas. The Bio Farm will produce Papaya in this work mode][WorkModeWrapper rollover]]"}, {id = "Pineapple", name = "[[28721][Pineapple][PlantFarm name]]", param1 = 360, param2 = 417, param3 = 450, rollover = "[[28722][Pineapples grow best in humid areas. The Bio Farm will produce Pineapple in this work mode][WorkModeWrapper rollover]]"}, {id = "Coffee", name = "[[28723][Coffee][PlantFarm name]]", param1 = 320, param2 = 452, param3 = 450, rollover = "[[28724][Coffee prefers high altitudes and high humidity. The Bio Farm will produce Coffee in this work mode][WorkModeWrapper rollover]]"}, {id = "Tobacco", name = "[[28725][Tobacco][PlantFarm name]]", param1 = 340, param2 = 371, param3 = 450, rollover = "[[28726][Tobacco prefers high areas with low humidity. The Bio Farm will produce Tobacco in this work mode][WorkModeWrapper rollover]]"}, {id = "Sugar", name = "[[28727][Sugar][PlantFarm name]]", param1 = 320, param2 = 440, param3 = 450, rollover = "[[28728][Sugar prefers low altitudes and high humidity. The Bio Farm will produce Sugar in this work mode][WorkModeWrapper rollover]]"}, {id = "Foodcrops", name = "[[28731][Food Crops][]]", param1 = 340, param2 = 367, param3 = 450, rollover = "[[28732][The Bio Farm will produce Bananas, Papaya, and Pineapple][WorkModeWrapper rollover]]"}}

function AltBioFarmCWM(self)
  self.modes = AltBioFarmWorkModes
end

function AltBioFarmGWM(self, id)
  return Building.GetWorkingMode(self, id)
end

function AltBioFarmAM(self, mode_id)
    g_Classes.FoodProductionBuilding.ActivateMode(self, mode_id)
    self.currentFieldClasses = {}
    local crops = self.mode_to_plant[mode_id]
    for i = 1, #crops do
        self.currentFieldClasses[#self.currentFieldClasses + 1] = "Field" .. crops[i] .. "Bio"
    end
    if mode_id == "Cashcrops" or mode_id == "Coffee" or mode_id == "Sugar" or mode_id == "Tobacco" then
        self:SetProvideMeals(false)
    else
        self:SetProvideMeals(true)
    end
  self.lastTimeChecked = false
end

function AltBioFarm()
    g_Classes.BioFarm.mode_to_plant = AltBioFarmMTP
    g_Classes.BioFarm.ChangeWorkModes = AltBioFarmCWM
    g_Classes.BioFarm.GetWorkingMode = AltBioFarmGWM
    g_Classes.BioFarm.ActivateMode = AltBioFarmAM
    g_Classes.BioFarm.modes = AltBioFarmWorkModes
end

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                AltBioFarm()
                OnMsg.MapPermanentObjectsLoaded = function()
                    AltBioFarm()
                end
            end)
        end
    end
end