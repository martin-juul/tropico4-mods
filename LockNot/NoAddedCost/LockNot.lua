-- 	LockNot by DarthPresidente
--		Requires Modern Times

-- 	What this does:
--		For every Modern Times building the user can modify four things
--			1)	The year the building becomes available
--			2)	Whether or not to still allow building the old building
--			3)  If keeping an old building you can choose to add a one time retrofit cost
--				in the form of a new blueprint.
--			4)	If keeping an old building you can impose an increased cost on the old building

--	Using:
--		The dialog boxes that display the buildings are designed for a maximum of 12 buildings in a category
--		Simply preventing the buildings from becoming unavailable is not enough because the dialog won't
--			display every available building.
--		TO BUILD AN OLD BUILDING:  Hold down the SHIFT button before clicking the category
--		This will list all the old buildings for the category if there are any.

--  Thanks To:
--		SimCutie:  This mod started out by trying to decompile and fix "Don't Lock Classic Buildings Mod"

--	WARNING
--		Installation and use of a mod makes you ineligible for customer support from the publisher
--		I max no excuses for any sloppy or inefficient code.  I'm learning as I go.

-- 	Configuration

--	Each building has 4 options {1,2,3,4}
--	#1	Start Year.  Determines the year the building becomes available
--		Set to "false" to keep the game's default start year
--	#2	Keep.  Deterimes whether or not to keep available the old buildings it replaces
--		Set to "true" to keep old buildings
--		Set to "false" to maintain the game's default
--	#3	Retrofit Cost:  Determines the retrofit cost of the old buildings 
--			once the new buildings are available.  Cost is imposed as a blueprint.
--		Set to the chosen cost.  Set to 0 to impose no retrofit cost
--	#4	Additional Building Cost:  Raises the cost of the old buildings by set amount.
--		Set to the chosen cost.  Set to 0 to impose no additional cost.

															-- Standard
local Unlocker = {											-- Old Building Cost / New Building Cost
	CityPark = {false , false, 0, 0},						-- Does not replace anything
	Supermarket = {false , true, 0, 0}, 					-- 500 / 5000
	Theater = {false , true, 0, 0},							-- 4000 / 6000
	Sanatorium = {false , false, 0, 0},						-- Does not replace anything
	FishFarm = {false , true, 0, 0},						-- 3000 / 6000
	WaterTreatment = {false , true, 0, 0},					-- 5000 / 10000
	ShipORant = {false , true, 0, 0},						-- 2000 / 10000
	ApartmentModern = {false , true, 0, 0},					-- 5000 / 10000
	BioFarm = {false , true, 0, 0},							-- 1500 / 5000
	OrganicRanch = {false , true, 0, 0},					-- 750 / 4000
	SWAT = {false , true, 0, 0},							-- 3000 / 15000
	BoreholeMine = {false , true, 0, 0},					-- 3000 / 7000
	SolarPlant = {false , true, 0, 0},						-- 6000 / 15000
	SkyscraperOffice = {false , false, 0, 0},				-- Does not replace anything
	BankModern = {false , true, 0, 0},						-- 8000 / 12000
	SkyscraperHotelModern = {false , true, 0, 0},			-- 16000 / 30000
	ElectronicsFactory = {false , false, 0, 0},				-- Does not replace anything
	MetroStation = {false , false, 0, 0},					-- Does not replace anything
	AirportModern = {false , true, 0, 0},					-- 24000 / 24000 - No added costs since they are equal
	CondominiumModern = {false , true, 0, 0},				-- 6000 / 12000
	TelecomHQ = {false , false, 0, 0},						-- Does not replace anything
	CarFactory = {false , false, 0,0},						-- Does not replace anything				
	CrystalCathedral = {false , true, 0, 0},				-- 20000 / 40000
	SpaceProgram = {false , false, 0, 0},					-- Does not replace anything
	Ziggurat = {false , false, 0, 0},						-- Does not replace anything
	BabelTower = {false , false, 0, 0}						-- Does not replace anything
}

-- Mod Code Below.  DO NOT EDIT BELOW THIS LINE
function DarthCheckSettings()
	if not Unlocker then 
		return false
	end
	for name,data in pairs(Unlocker) do
		local sy = data[1] 
		if type(sy) == "number" then
			if Clamp(sy,1900,3000) ~= sy then
				sy = Clamp(sy,1900,3000)
				print("LockNot Settings Error:",name,"start year is out of bounds. Reset to",sy)
			end
		elseif sy == false then
			-- do nothing
		else
			sy = false
			print("LockNot Settings Error:",name,"start year is invalid. Reset to",sy)
		end
		local keep = data[2]
		if keep ~= true and keep ~= false then
			keep = false
			print("LockNot Settings Error:",name,"keep is invalid.  Reset to",keep)
		end
		local retrofit = data[3]
		if type(retrofit) == "number" then
			if Clamp(retrofit,0,100000) ~= retrofit then
				retrofit = Clamp(retrofit,0,100000)
				print("LockNot Settings Error:",name,"retrofit is out of bounds.  Reset to",retrofit)
			end
		else
			retrofit = 0
			print("LockNot Settings Error:",name,"retrofit is invalid.  Reset to",retrofit)
		end
		local addcost = data[4]
		if type(addcost) == "number" then
			if Clamp(addcost,0,100000) ~= addcost then
				addcost = Clamp(addcost,0,100000)
				print("LockNot Settings Error:",name,"addcost is out of bounds.  Reset to",addcost)
			end
		else
			addcost = 0
			print("LockNot settings Error:",name,"addcost is invalid.  Reset to",addcost)
		end
		Unlocker[name] = {sy, keep, retrofit, addcost}
	end
end

DarthTimelineAddBuildingUnlockEvents = function(self)
		DarthEventWrecker(self)
		Orig_TimelineAddBuildingUnlockEvents(self)
end

function DarthEventWrecker(self)
	local templates = self.event_templates
	for name,template in pairs(self.event_templates) do
		if template.type == "Unlock Building" then
			if template[2] and template[2]:IsKindOf("SA_UnlockBuildings") then
				local sy = template.timeline_start_year
				local unlock = CheckForUnlock(template[2].classes)
				if type(unlock) == "table" then
					if type(unlock[1]) == "number" then
						sy = unlock[1]
					end
				end
				template.timeline_start_year = sy
				self.event_templates[name] = template
			end
		end
	end
end

DarthSAUnlockBuildingsExec = function(self, seq_player)
	local keep = false
	local unlock
	for class in string.gmatch(self.classes, "([^,]+)") do
		unlock = CheckForUnlock(class)
		if type(unlock) == "table" and #unlock == 4 then
			if unlock[2] then
				keep = true
			end
		end
	end
	if keep then
		DarthSAUnlockBuildings(self, seq_player)
		DarthChangeCosts(unlock, self:GetClasses())
	else
		Orig_SAUnlockBuildings(self, seq_player)
	end
end

function DarthSAUnlockBuildings(self, seq_player)
	for class in string.gmatch(self.classes, "([^,]+)") do
		UnlockedBuildings[class] = true
	end
	local classes = self:GetClasses()
	for i = 1, #classes do
		local old_building = GetClassicBuilding(classes[i])
		if old_building then
			UnlockedBuildings[classes[i]] = old_building
		elseif g_Classes[classes[i]]:IsKindOf("Building") and g_Classes[classes[i]]:GetPosition() > 12 then
			UnlockedBuildings[classes[i]] = true
		end
	end
end

local DarthOldBuildings = {Marketplace = {"Marketplace"}, Cabaret = {"Cabaret"}, FishermansWharf = {"FishermansWharf"}, GarbageDump = {"GarbageDump"}, Restaurant = {"Restaurant"}, Apartment_01 = {"Apartment_01","Apartment_02","Apartment_03","Apartment_04"}, PlantFarm_1 = {"PlantFarm_1","PlantFarm_2"}, AnimalFarm = {"AnimalFarm"}, Armory = {"Armory"}, Mine = {"Mine"}, WindTurbine = {"WindTurbine"}, Bank = {"Bank"}, SkyscraperHotel = {"SkyscraperHotel"}, Airport = {"Airport"}, Condominium_01 = {"Condominium_01","Condominium_02","Condominium_03","Condominium_04"}, Cathedral = {"Cathedral"}}
DarthGetCategoryUnlockedBuildings = function(category, challenge_order)
	local unlocked = Orig_GetCategoryUnlockedBuildings(category, challenge_order)
	if terminal.IsKeyPressed(const.vkShift) then
		local classics = {}
		for _,bld in ipairs(unlocked) do
			local oldbuilding = GetClassicBuilding(bld[1])
			if oldbuilding then
				local old_classes = DarthOldBuildings[oldbuilding]
				if #old_classes > 0 and not LockedBuildings[old_classes[1]] then
					table.insert(classics, old_classes)
				end
			end
		end
		if #classics > 0 then
			return classics
		end
	end
	return unlocked
end

DarthBuildMenuShowCategory = function(self, idx)
  local category = self:GetCategoryOrder()[idx]
  local buildings = GetCategoryUnlockedBuildings(category, self.challenge_order)
  self.darthbuildings = buildings
  self.darthcategory = category
  Orig_BuildMenuShowCategory(self, idx)
end

DarthBuildMenuGetCategoryItems = function(self, category)
	local buildings
	if self.darthbuildings then
		buildings = self.darthbuildings
	else
		return
	end
	return buildings
end

DarthBuildMenuTryToPlace = function(self, idx, xbox)
  local category, buildings
  if self.darthbuildings and self.darthcategory then
    buildings = self.darthbuildings
	category = self.darthcategory
  else
    return
  end
  local class_name = buildings[idx][AsyncRand(#buildings[idx]) + 1]
  local startVal
  if g_Classes[class_name]:IsKindOf("Building") then
    startVal = g_Classes[class_name].blueprint_cost
  end
  if startVal and startVal > 0 and not HasBlueprints(category, g_Classes[class_name]) and not IsBuildingFree(class_name) and not ChallengeEditorIsActive() then
    startVal = ApplyModifiers(startVal, "BlueprintCost", "")
    local point = self.point
    do
      ShowPopUpNotifications("PurchaseBlueprints", {g_Classes[class_name].display_name, startVal; silent = true}, function(choice)
        if choice == "Pay" then
          SetBlueprints(category, g_Classes[class_name], true)
          UIPlayer:Payment(-startVal, false, "other_expenses")
          OpenBuildMenu(point, category)
        end
      end
      )
      self:Close(true)
      return 
    end
  end
  if g_Classes[class_name]:IsKindOf("ChallengeMarker") then
    editor.ObjClassList = class_name
    editor.Reload()
    SetEditorBrush(const.ebtPlaceSingleObject, true)
    editor.OnSetBrush()
  else
    ActivateConstruction(class_name, buildings[idx], xbox)
  end
  self:Close(true)
end

function CheckForUnlock(class)
	local startyear, keepold, newbpcost, addcost
	if type(Unlocker[class]) == "table" then
		startyear = Unlocker[class][1]
		keepold = Unlocker[class][2]
		newbpcost = Unlocker[class][3]
		addcost = Unlocker[class][4]
	end
	if startyear ~= nil and keepold ~= nil and type(newbpcost) == "number" and type(addcost) == "number" then
		return {startyear, keepold, newbpcost, addcost}
	else
		return false
	end
end

function DarthChangeCosts(unlock, classes)
	local modern = classes[1]
	local old = GetClassicBuilding(modern)
	if old then
		local old_class = g_Classes[old]
		local old_classes = {}
		if not rawget(old_class, "__autogenerated") then
			old_classes = GetBuildingClassList(old_class.category, old_class.__parents[1])
		else
			old_classes[1] = old
		end
		for j = 1, #old_classes do
			local bld = old_classes[j]
			if type(unlock[3]) == "number" and unlock[3] > 0 then
				local has_bp = nil
				local bpcost = nil
				has_bp = HasBlueprints(g_Classes[bld].category, g_Classes[bld])
				if not has_bp then
					bpcost = g_Classes[bld].blueprint_cost + unlock[3]
					g_Classes[bld].blueprint_cost = bpcost
				else
					g_Classes[bld].blueprint_cost = unlock[3]
				end
				SetBlueprints(g_Classes[bld].category, g_Classes[bld], false)
			end
			if type(unlock[4]) == "number" and unlock[4] > 0 then
				local bldcost = g_Classes[bld].money_cost + unlock[4]
				g_Classes[bld].money_cost = bldcost
			end
		end
	end
end

local DarthExecOnce = false
function DarthLockNot()
	if not DarthExecOnce then
		Orig_TimelineAddBuildingUnlockEvents = Timeline.AddBuildingUnlockEvents
		Orig_SAUnlockBuildings = SA_UnlockBuildings.Exec
		Orig_GetCategoryUnlockedBuildings = GetCategoryUnlockedBuildings
		Orig_BuildMenuShowCategory = BuildMenu.ShowCategory
		DarthExecOnce = true
	end
	DarthCheckSettings()
	
	-- Interrupt the function that adds the events to the timeline and edit them first...
	Timeline.AddBuildingUnlockEvents = DarthTimelineAddBuildingUnlockEvents
	
	-- Alter the function that unlocks new buildings and prevent it from locking old ones..
	SA_UnlockBuildings.Exec = DarthSAUnlockBuildingsExec
	
	-- Alter the function that creates the list of buildings in the build menu so
	-- if the SHIFT key is pressed it builds a list of the old buildings
	GetCategoryUnlockedBuildings = DarthGetCategoryUnlockedBuildings
	
	-- Alter the function that displays the list of buildings in the build menu so it
	-- 		stores the list in the BuildMenu object so (so letting go
	-- 		of the SHIFT button does not change what the buttons do)
	BuildMenu.GetCategoryItems = DarthBuildMenuGetCategoryItems
	
	-- Alter the function that updates the buildmenu so it uses the stored list in the 
	--		BuildMenu object
	BuildMenu.ShowCategory = DarthBuildMenuShowCategory
	
	-- Alter the function that updates the buildmenu so it uses the stored list in the 
	--		BuildMenu object
	BuildMenu.TryToPlace = DarthBuildMenuTryToPlace
	
	print("LockNot by DarthPresidente loaded...")
end

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                DarthLockNot()
                OnMsg.MapPermanentObjectsLoaded = function()
                    DarthLockNot()
                end
            end)
        end
    end
end

-- Back Up
local Original_Unlocker = {
	CityPark = {false , false, 0, 0},						-- Does not replace anything
	Supermarket = {false , true, 125, 125}, 				-- 500 / 5000
	Theater = {false , true, 1000, 1000},					-- 4000 / 6000
	Sanatorium = {false , false, 0, 0},						-- Does not replace anything
	FishFarm = {false , true, 750, 750},					-- 3000 / 6000
	WaterTreatment = {false , true, 1250, 1250},			-- 5000 / 10000
	ShipORant = {false , true, 500, 500},					-- 2000 / 10000
	ApartmentModern = {false , true, 1250, 1250},			-- 5000 / 10000
	BioFarm = {false , true, 375, 375},						-- 1500 / 5000
	OrganicRanch = {false , true, 190, 190},				-- 750 / 4000
	SWAT = {false , true, 750, 750},						-- 3000 / 15000
	BoreholeMine = {false , true, 750, 750},				-- 3000 / 7000
	SolarPlant = {false , true, 1500, 1500},				-- 6000 / 15000
	SkyscraperOffice = {false , false, 0, 0},				-- Does not replace anything
	BankModern = {false , true, 2000, 1000},				-- 8000 / 12000
	SkyscraperHotelModern = {false , true, 4000, 4000},		-- 16000 / 30000
	ElectronicsFactory = {false , false, 0, 0},				-- Does not replace anything
	MetroStation = {false , false, 0, 0},					-- Does not replace anything
	AirportModern = {false , true, 0, 0},					-- 24000 / 24000 - No added costs since they are equal
	CondominiumModern = {false , true, 1500, 1500},			-- 6000 / 12000
	TelecomHQ = {false , false, 0, 0},						-- Does not replace anything
	CarFactory = {false , false, 0,0},						-- Does not replace anything				
	CrystalCathedral = {false , true, 5000, 5000},			-- 20000 / 40000
	SpaceProgram = {false , false, 0, 0},					-- Does not replace anything
	Ziggurat = {false , false, 0, 0},						-- Does not replace anything
	BabelTower = {false , false, 0, 0}						-- Does not replace anything
}
