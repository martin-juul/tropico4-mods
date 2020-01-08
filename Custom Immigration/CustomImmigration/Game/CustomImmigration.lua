-- 	Custom Immigration 2 mod by DarthPresidente

GlobalVar("CIRegions", {})  -- Do not Alter this line

-- ** General Options **

-- Generations until assimilation
--		Determines how long it takes for a family to assimilate.  Once they assimilate they will 
--			consider themselves Tropicans, speak Spanish, and give their children Spanish names.
local AssimilationThreshold = 2

-- Inheritance Method
--		These are in order of operation.  If InheritByGeneration is set to true then InheritByAge
--			and InheritByParent are ignored.

-- Inherit Tropico First.  Set to true and if either parent are Tropican so will the child be.
local InheritTropicoFirst = true

-- Inherit By Generation.  Child will inherit origin from the parent of the eldest generation. 	
local InheritByGeneration = false

-- Inherit By Age.  Child will inherit origin from the oldest parent by age.
local InheritByAge = false

-- Inherit By Parent.  Set to "Father" "Mother" or "Random".  Case matters!
local InheritByParent = "Father"


-- ** Region List **
--
-- 	Nations are grouped by Region.  There are four regions (Caribbean, Europe, Americas, and Asia).
--		The number each is set to is it's weight.  In defalt configuration that means that there is a:
--		40% chance an immigrant will come from a nation in the Caribbean list
--		40% chance an immigrant will come from a nation in the Europe list
--		10% chance an immigrant will come from a nation in the Americas list.
--		10% chance an immigrant will come from a nation in the Asia list.

CIRegions.List = {
	Caribbean = 40,
	Europe = 40,
	Americas = 10,
	Asia = 10
}

-- ** Nation Lists **
-- 
--	Each region has a list of nations associated with it.  Each nation has a weight similar to the
--		way regions did.  It should be noted that the total weight does not need to add up to 100%
--		nor does it need to reflect an exact percentage of chance.  If each nation in a group is 
--		weighted a 5 then they all have an equal chance just as if they were all weighted 1.

CIRegions.Caribbean = {
	Cuba = 5,
	Jamaica = 5, 
	Bahamas = 5,
	["Puerto Rico"] = 5, 
	Haiti = 5, 
	Venezuela = 5
}
CIRegions.Europe = {
	England = 10, 
	Germany = 10, 
	Italy = 5, 
	France = 10, 
	Spain = 5,
	USSR = 5
}
CIRegions.Americas = {
	US = 5
}
CIRegions.Asia = {
	China = 5
}
CIRegions.Weighted = {}

-- Mod Code.  Do not edit past this line

CICreateWeightedRegionLists = function()
	CIRegions.Weighted.List = {}
	for region, weight in pairs(CIRegions.List) do
		if weight > 0 then
			for x = 1,weight do
				table.insert(CIRegions.Weighted.List, region)
			end
		end
		CIRegions.Weighted[region] = {}
		for nation, nweight in pairs(CIRegions[region]) do
			if nweight > 0 then
				for x = 1,nweight do
					table.insert(CIRegions.Weighted[region], nation)
				end
			end	
		end
	end
end
CIPickRandomNation = function()
	local regionlist = CIRegions.Weighted.List
	if not regionlist then 
		return "Tropico" 
	end
	local region = regionlist[1 + AsyncRand(#regionlist)]
	local nationlist = CIRegions.Weighted[region]
	if not nationlist then 
		return "Tropico" 
	end
	local nation = nationlist[1 + AsyncRand(#nationlist)]
	--DarthDebugPicker(region,nation)
	return nation
end

function DarthSpawnChild(self, class)
	if not class then
		if (self:Random(100) > self.MaleGenderChance) then
			class = "ToddlerMale"
		else
			class = "ToddlerFemale"
		end
	end
	local new = PlaceObject(class)
	new:SetBirthDate(GetYear(), GetMonth())
	self:MakeUnitChild(new)
	NameChildUnit(self,new)
	new.meals = 0
	new.home = self.home
	if new.home then
		new:SetHolder(new.home)
	end
	InitCitizenFactions(new, "Babies")
	if self.emigrate_dock then
		new:SetEmigrant(self.emigrate_dock)
	end
	new:SetRespectValue(new:CalcInitialRespectValue())
	if sel:Find(self) then
		Select(sel[1], true)
	end
	return new
end

local GetParentData = function(self)
	local parent = {age = self:Age(), origin = self.origin, generation = self.generation}
	if not parent.age then parent.age = 0 end
	if not parent.origin then 
		parent.origin = "Tropico"
		self.origin = "Tropico"
	end
	if not parent.generation then
		if parent.origin == "Tropico" then 
			parent.generation = 1 
		else 
			parent.generation = 0 
		end
		self.generation = parent.generation
	end
	return parent
end

function NameChildUnit(mother, unit)
	local moms,dads = GetParentData(mother)
	if mother.spouse then
		dads = GetParentData(mother.spouse)
	else
		dads = {age = 0, origin = false, generation = 0}
	end
	local maxgen = Max(moms.generation,dads.generation)
	if maxgen >= AssimilationThreshold then
		unit.origin = "Tropico"
	elseif InheritTropicoFirst and (moms.origin == "Tropico" or dads.origin == "Tropico") then
		unit.origin = "Tropico"
	elseif InheritByGeneration then
		if dads.generation >= moms.generation then
			unit.origin = dads.origin
		else 
			unit.origin = moms.origin
		end
	elseif InheritByAge then
		if dads.age >= moms.age then
			unit.orign = dads.origin
		else
			unit.origin = moms.origin
		end
	else
		if dads.origin ~= false and (InheritByParent == "Father" or (InheritByParent == "Random" and unit:Random(100) >= 50)) then
			unit.origin = dads.origin
		else
			unit.origin = moms.origin
		end
	end
	local names = Names[Nations[unit.origin].language]
	local first_names = names[unit.gender]
	unit.name = first_names[1 + unit:Random(#first_names)]
	unit.generation = maxgen + 1
end

function DarthImmigration()
	g_Classes.Citizen.SpawnChild = DarthSpawnChild
	g_Classes.Citizen.generation = false
	GenImmigrantNation = function()
		return CIPickRandomNation()
	end
	OnMsg.CitizenCloned = function(old, new)
		local generation = old.generation
		if generation then
			new.generation = generation
		end
	end
	CICreateWeightedRegionLists()
	print("Custom Immigration by DarthPresidente loaded...")
	print("    Version:  	2.0")
	print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))
end

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                DarthImmigration()
                OnMsg.MapPermanentObjectsLoaded = function()
                    DarthImmigration()
                end
            end)
        end
    end
end
function DarthDebugPicker(region,nation)
	if not nation or not region then return end
	local language = Nations[nation].language
	if not language then language = "Spanish" end
	local names,gender = Names[language] , "Female"
	if (AsyncRand(100) > g_Classes.Citizen.MaleGenderChance) then gender = "Male" end
	local first_names = names[gender]
	local fname = first_names[1 + AsyncRand(#first_names)]
	local families = names.Family
	local lname = families[1 + AsyncRand(#families)]
	if type(lname) == "table" then
		if gender ~= "Male" then lname = lname[1] else lname = lname[2] end
	end
	local fullname = Translatef("[[13121][%s1 %s2][]]", fname, lname)
	print("Picked:",region,",",nation,",",gender,",",fullname,",",language)
end