-- GenderEquality Mod by DarthPresidente
-- 
-- Version 1 

print("Gender Equality by DarthPresidente loaded...")
print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))

OnMsg.ClassesPreprocess = function()
	Mother_Fix()
	Lady_Teamster()
	Lady_Attendant()
	Lady_Professor()
	Lady_Bishop()
	Lady_Priest()
	Lady_Lumberjack()
	Lady_Banker()
	Lady_Miner()
	Lady_Doctor()
	Lady_Fisher()
	Lady_PitBoss()
	Lady_CustomsOfficer()
	Lady_Dockworker()
	Lady_Garbageman()
	Lady_Athlete()
	Lady_StockBroker()
	Lady_Policeman()
	Lady_Fireman()
	Guy_Engineer()
	Guy_Shopkeeper()
	Guy_Maid()
	Guy_Journalist()
	Guy_Cook()
	Guy_Bureaucrat()
	Guy_Teacher()
	Guy_Barmaid()
	Guy_Showgirl()
end
function Mother_Fix()
	-- Redfines Mothers so they can shapeshift
	local MotherInit = Mother.Init
	local MotherGameInit = Mother.GameInit
	local MotherDoRest = Mother.DoRest
	local MotherBearCheck = Mother.BearCheck
	UndefineClass("Mother")
	DefineClass.Mother = {
		__parents = {"Citizen", "Shapeshifter", "Female"}, 
		display_name = "[[10885][Mother][]]", 
		display_name_plural = "[[10886][Mothers][]]", 
		entity = "Mother",
		profession_skill = false, 
		is_pregnant = true, 
		needs_list = MotherNeeds, 
		can_fight = false, 
		becomeThought = false, 
		random_color = true, 
		bear_time = false
	}
	Mother.Init = MotherInit
	Mother.GameInit = MotherGameInit
	Mother.DoRest = MotherDoRest
	Mother.BearCheck = MotherBearCheck
end
function Lady_Teamster()
	DefineClass.TeamsterFemale = {__parents = {"Worker", "Female"}, display_name = "[[10917][Teamster][]]", display_name_plural = "[[10918][Teamsters][]]", entity = "FactoryWorker_F", profession_skill = "Teamster", ProductionCarryAmount = 1000, working_car = "Truck_02", becomeThought = "become Teamster", workThought = "work Teamster", caste = "Low", random_color = true, work_end_time = false}
	TeamsterFemale.DoWork = Teamster.DoWork
	TeamsterFemale.FindBuildingToLoad = Teamster.FindBuildingToLoad
	TeamsterFemale.GetCarryAmount = Teamster.GetCarryAmount
	TeamsterFemale.TutorialDoWork = Teamster.TutorialDoWork
end
function Lady_Attendant()
	DefineClass.AttendantFemale = {__parents = {"Citizen", "Shapeshifter", "Female"}, entity = "Shopkeeper", display_name = "[[10847][Attendant][]]", display_name_plural = "[[10848][Attendants][]]", profession_skill = "Attendant", working_car = "OffRoad_03", caste = "Middle", random_color = true}
	AttendantFemale.DoWork = Attendant.DoWork
	-- Need to shape shift at the Aquapark because of animations
	AttendantFemale.DoWorkAquaPark = function(self, work_time)
		self:ChangeEntity(g_Classes.Attendant:GetEntity())
		local OK = Attendant.DoWorkAquaPark(self, work_time)
		self:ChangeEntity(g_Classes.AttendantFemale:GetEntity())
		return OK
	end
	AttendantFemale.DoWorkIslandTourOffice = Attendant.DoWorkIslandTourOffice
	AttendantFemale.DoWorkBeachSite = Attendant.DoWorkBeachSite
	AttendantFemale.DoWorkBalloonRide = Attendant.DoWorkBalloonRide
	AttendantFemale.DoWorkFerrisWheel = Attendant.DoWorkFerrisWheel
end
function Lady_Professor()
	DefineClass.ProfessorFemale = {__parents = {"Citizen", "Shapeshifter", "Female"}, display_name = "[[10897][Professor][]]", display_name_plural = "[[10898][Professors][]]", entity = "Bureaucrat_F", profession_skill = "Professor", becomeThought = "become Professor", workThought = "work Professor", caste = "Middle", random_color = true}
	ProfessorFemale.DoWork = Professor.DoWork
	-- Shape shift due to animations
	ProfessorFemale.DoWorkColonialMuseum = function(self, work_time)
		self:ChangeEntity(g_Classes.Professor:GetEntity())
		local OK = Professor.DoWorkColonialMuseum(self, work_time)
		self:ChangeEntity(g_Classes.ProfessorFemale:GetEntity())
		return OK
	end
	-- Shape shift due to animations
	ProfessorFemale.Digg = function(self, tree)
		self:ChangeEntity(g_Classes.Professor:GetEntity())
		local OK = Professor.Digg(self, tree)
		self:ChangeEntity(g_Classes.ProfessorFemale:GetEntity())
		return OK
	end
	ProfessorFemale.DoWorkHarvest = Professor.DoWorkHarvest
end
function Lady_Bishop()
	EventToText["work LadyBishop"] = {"[[DarthGE1000][What if God was one of us][]]", "[[DarthGE1001][We got to pray just to make it today][]]", "[[DarthGE1002][It's hard to be religious when certain people are never incinerated by bolts of lightning][]]"}
	EventToText["become LadyBishop"] = {"[[DarthGE1003][(New Job) I am going to get paid to read from a Book everyone already owns][]]", "[[DarthGE1004][(New Job) I guess I have to follow those 10 commandments now][]]"}
	DefineClass.BishopFemale = {__parents = {"Citizen", "Shapeshifter", "Female"}, display_name = "[[10853][Bishop][]]", display_name_plural = "[[10854][Bishops][]]", entity = "Teacher", profession_skill = "Bishop", caste = "High", becomeThought = "become LadyBishop", workThought = "work LadyBishop"}
	-- Shapeshift due to animations
	BishopFemale.DeclareHeretic = function(self, obj, player_initiated)
		self:ChangeEntity(g_Classes.Bishop:GetEntity())
		local OK = Bishop.DeclareHeretic(self, obj, player_initiated)
		self:ChangeEntity(g_Classes.BishopFemale:GetEntity())
		return OK
	end
	BishopFemale.DoWork = Bishop.DoWork
end
function Lady_Priest()
	EventToText["work LadyPriest"] = {"[[DarthGE1005][What if God was one of us][]]", "[[DarthGE1006][We got to pray just to make it today][]]", "[[DarthGE1007][It's hard to be religious when certain people are never incinerated by bolts of lightning][]]"}
	EventToText["become LadyPriest"] = {"[[DarthGE1008][(New Job) I am going to get paid to read from a Book everyone already owns][]]", "[[DarthGE1009][(New Job) I guess I have to follow those 10 commandments now][]]"}
	DefineClass.PriestFemale = {__parents = {"Citizen", "Female"}, display_name = "[[10853][Bishop][]]", display_name_plural = "[[10854][Bishops][]]", entity = "Teacher", profession_skill = "Bishop", caste = "High", becomeThought = "become LadyPriest", workThought = "work LadyPriest"}
	PriestFemale.DoWork = Priest.DoWork
end
function Lady_Lumberjack()
	DefineClass.LumberjackFemale = {__parents = {"Worker", "Shapeshifter", "Female"}, display_name = "[[10879][Lumberjack][]]", display_name_plural = "[[10880][Lumberjacks][]]", entity = "FactoryWorker_F", profession_skill = "Lumberjack", becomeThought = "become Lumberjack", workThought = "work Lumberjack", caste = "Low", random_color = true, trunk = false}
	LumberjackFemale.ReplaceTree = Lumberjack.ReplaceTree
	LumberjackFemale.DoWork = function(self, work_time)
		self:ChangeEntity(g_Classes.Lumberjack:GetEntity())
		local OK = Lumberjack.DoWork(self, work_time)
		self:ChangeEntity(g_Classes.LumberjackFemale:GetEntity())
		return OK
	end
end
function Lady_Banker()
	EventToText["work LadyBanker"] = {"[[DarthGE1010][If I eat more will I become too big to fail?][]]", "[[DarthGE1011][No income?  No problem!  Here's your loan][]]"}
	EventToText["become LadyBanker"] = {"[[DarthGE1012][(New Job) I can't wait to QE my stock portfolio][]]"}
	DefineClass.BankerFemale = {__parents = {"Citizen", "Female"}, entity = "Bureaucrat_F", display_name = "[[10849][Banker][]]", display_name_plural = "[[10850][Bankers][]]", profession_skill = "Banker", working_car = "Car_01", caste = "High", random_color = true, becomeThought = "become LadyBanker", workThought = "work LadyBanker"}
	BankerFemale.DoBribe = Banker.DoBribe
	BankerFemale.DoWork = Banker.DoWork
end
function Lady_Miner()
	DefineClass.MinerFemale = {
		__parents = {"Worker", "Shapeshifter", "Female"}, display_name = "[[10883][Miner][]]", display_name_plural = "[[10884][Miners][]]", entity = "FactoryWorker_F", profession_skill = "Miner", becomeThought = "become Miner", workThought = "work Miner", caste = "Low", random_color = true}
	MinerFemale.DoWork = function(self, work_time)
		self:ChangeEntity(g_Classes.Miner:GetEntity())
		local OK = Miner.DoWork(self, work_time)
		self:ChangeEntity(g_Classes.MinerFemale:GetEntity())
		return OK
	end
	MinerFemale.DoBoreholeWork = Miner.DoBoreholeWork
end
function Lady_Doctor()
	DefineClass.DoctorFemale = {__parents = {"Citizen", "Female"}, display_name = "[[10866][Doctor][]]", display_name_plural = "[[10867][Doctors][]]", entity = "Engineer", profession_skill = "Doctor", becomeThought = "become Doctor", workThought = "work Doctor", caste = "High"}
	DoctorFemale.DoWork = Citizen.DoWork
end
function Lady_Fisher()
	EventToText["work LadyFisher"] = {"[[DarthGE1013][I think there is a hole in my net][]]","[[DarthGE1014][Here fishy fishy fishy][]]"}
	EventToText["become LadyFisher"] = {"[[DarthGE1015][(New Job) I wonder what shampoo works on fish smell][]]"}
	DefineClass.FishermanFemale = {__parents = {"Worker", "Shapeshifter", "Female"}, display_name = "[[10874][Fisherman][]]", display_name_plural = "[[10875][Fishermen][]]", entity = "FactoryWorker_F", profession_skill = "Fisherman", caste = "Low", becomeThought = "become LadyFisher", workThought = "work LadyFisher", random_color = true}
 	-- Shapeshift due to animations
	FishermanFemale.DoWork = function(self, work_time)
		self:ChangeEntity(g_Classes.Fisherman:GetEntity())
		local OK = Fisherman.DoWork(self, work_time)
		self:ChangeEntity(g_Classes.FishermanFemale:GetEntity())
		return OK
	end
end
function Lady_PitBoss()
	EventToText["work LadyPitBoss"] = {"[[DarthGE1016][I would have totally busted Rain Man][]]","[[DarthGE1017][Hey!  Was that Danny Ocean?][]]"}
	EventToText["become LadyPitBoss"] = {"[[DarthGE1018][(New Job) Don't even think about cheating while I am on the job][]]"}
	DefineClass.PitBossFemale = {__parents = {"Citizen", "Female"}, display_name = "[[10889][Pit Boss][]]", display_name_plural = "[[10890][Pit bosses][]]", entity = "Bureaucrat_F", profession_skill = "PitBoss", becomeThought = "become LadyPitBoss", workThought = "work LadyPitBoss", caste = "High"}
end
function Lady_CustomsOfficer()
	DefineClass.CustomsOfficerFemale = {__parents = {"Citizen", "Female"}, entity = "Bureaucrat_F", display_name = "[[17874][Customs Officer][]]", display_name_plural = "[[17875][Customs officers][]]", profession_skill = "CustomsOfficer", becomeThought = "become CustomsOfficer", workThought = "work CustomsOfficer", caste = "Middle"}
end
function Lady_Dockworker()
	EventToText["work LadyDockworker"] = {"[[DarthGE1019][I'd nap on the job but I am afraid I'd wake up in Russia][]]","[[DarthGE1020][Why do cargo ships always smell so bad?][]]"}
	EventToText["become LadyDockworker"] = {"[[DarthGE1021][(New Job) I lift things up and put them down...on a ship][]]"}
	DefineClass.DockworkerFemale = {__parents = {"Citizen", "Female"}, entity = "FactoryWorker_F", display_name = "[[10864][Dockworker][]]", display_name_plural = "[[10865][Dockworkers][]]", profession_skill = "Dockworker", caste = "Low", work_end_time = false, becomeThought = "become LadyDockworker", workThought = "work LadyDockworker", random_color = true}
 	DockworkerFemale.DummyWorkCycle = Dockworker.DummyWorkCycle
	DockworkerFemale.DoWorkTradeDock = Dockworker.DoWorkTradeDock
	DockworkerFemale.DoWork = Dockworker.DoWork
end
function Lady_Garbageman()
	EventToText["work LadyGarbageman"] = {"[[DarthGE1022][One person's trash is still trash to me][]]","[[DarthGE1023][It's amazing what people throw out][]]"}
	EventToText["become LadyGarbageman"] = {"[[DarthGE1024][(New Job) I love the smell of garbage in the morning][]]"}
	DefineClass.GarbagemanFemale = {__parents = {"Worker", "Female"}, display_name = "[[16361][Garbageman][]]", display_name_plural = "[[16980][Garbagemen][]]", profession_skill = "Garbageman", ProductionCarryAmount = 1000, working_car = "Truck_02", caste = "Low", entity = "FactoryWorker_F", random_color = true, becomeThought = "become LadyGarbageman", workThought = "work LadyGarbageman", work_end_time = false}
 	GarbagemanFemale.DoWork = Garbageman.DoWork
end
function Lady_Athlete()
	EventToText["work LadyAthlete"] = {"[[DarthGE1025][Today is a must win.  We have to step up and make plays][]]","[[DarthGE1026][We're taking it one game at a time][]]"}
	EventToText["become LadyAthlete"] = {"[[DarthGE1027][(New Job) I'm going to give 110% when speaking in sports cliches][]]"}
	DefineClass.ProAthleteFemale = {__parents = {"Citizen", "Female"}, display_name = "[[10895][Pro Athlete][]]", display_name_plural = "[[10896][Pro athletes][]]", entity = "Journalist_F", profession_skill = "ProAthlete", caste = "Middle", becomeThought = "become LadyAthlete", workThought = "work LadyAthlete", random_color = true}
end
function Lady_StockBroker()
	DefineClass.StockBrokerFemale = {__parents = {"Citizen", "Female"}, display_name = "[[17882][Stock Broker][]]", display_name_plural = "[[17883][Stock Brokers][]]", entity = "OfficeWorker_F", profession_skill = "StockBroker", becomeThought = "become StockBroker", workThought = "work StockBroker", caste = "High", entity = "Banker"}
end
function Lady_Policeman()
	--  Complicated one.  First have to store all the policeman functions into local vars
	--	Then we have to undefine Policeman
	--	Then redefine it but without the "Male" parent
	--  Then tie the original functions back into the new version
	--	Then define a male and female version
	--  All this so that various functions in the game that deal with conflicts and criminals
	--    that use IsKindOf("Policeman") return true for both female and male policeman
	local PolicemanShootout = Policeman.Shootout
	local PolicemanDoArrest = Policeman.DoArrest
	local PolicemanPursue = Policeman.Pursue
	local PolicemanDoWork = Policeman.DoWork
	local PolicemanDoWorkPrison = Policeman.DoWorkPrison
	local PolicemanDoWorkDungeon = Policeman.DoWorkDungeon
	local PolicemanDoWorkPoliceStation = Policeman.DoWorkPoliceStation
	UndefineClass("Policeman")
	DefineClass.Policeman = {__parents = {"Armed"}, display_name = "[[10891][Policeman][]]", display_name_plural = "[[10892][Policemen][]]", profession_skill = "Policeman", mindist = 300, maxdist = 500, working_car = "PoliceCar", battle_car = "PoliceCar", becomeThought = "become Policeman", workThought = "work Policeman", caste = "Middle", car_neighbourhood_radius = 35000, neighbourhood_radius = 10000, fightThought = "fighting Soldier"}
	Policeman.Shootout = PolicemanShootout
	Policeman.DoArrest = PolicemanDoArrest
	Policeman.Pursue = PolicemanPursue
	Policeman.DoWork = PolicemanDoWork
	Policeman.DoWorkPrison = PolicemanDoWorkPrison
	Policeman.DoWorkDungeon = PolicemanDoWorkDungeon
	Policeman.DoWorkPoliceStation = PolicemanDoWorkPoliceStation
 	DefineClass.PolicemanMale = {__parents = {"Policeman", "Male"}, entity = "Policeman"}
	DefineClass.PolicemanFemale = {__parents = {"Policeman", "Shapeshifter", "Female"}, entity = "Bureaucrat_F"}
	PolicemanFemale.Shootout = function(self, obj)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.Shootout(self,obj)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.DoArrest = function(self, obj, player_initiated)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.DoArrest(self, obj, player_initiated)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.Pursue = function(self, suspect)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.Pursue(self, suspect)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.DoWork = function(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.DoWork(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.DoWorkPrison = function(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.DoWorkPrison(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.DoWorkDungeon = function(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.DoWorkDungeon(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	PolicemanFemale.DoWorkPoliceStation = function(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanMale:GetEntity())
		local OK = Policeman.DoWorkPoliceStation(self, worktime, task)
		self:ChangeEntity(g_Classes.PolicemanFemale:GetEntity())
		return OK
	end
	Dungeon.male_worker_class = "PolicemanMale"
	PoliceStation.male_worker_class = "PolicemanMale"
	Prison.male_worker_class = "PolicemanMale"
	-- Need to fix SWAT team member.  SWAT team inherits from Policeman which now has no gender
	Fix_SWAT()
end
function Fix_SWAT()
	local SWATInit = SWATmember.Init
	local SWATDoWork = SWATmember.DoWork
	local SWATDoKill = SWATmember.DoKill
	UndefineClass("SWATmember")
	DefineClass.SWATmember = {__parents = {"PolicemanMale", "Military"}, display_name = "[[28917][SWAT member][]]", display_name_plural = "[[28918][SWAT members][]]", profession_skill = "SWATmember", caste = "Middle", entity = "SWATMember", becomeThought = "become SWAT Member", workThought = "work SWAT Member", fightThought = "fighting Soldier", fightForCoupThought = "fight for coup", fightAgainstCoupThought = "fight against coup", caste = "Middle"}
	SWATmember.Init = SWATInit
	SWATmember.DoWork = SWATDoWork
	SWATmember.DoKill = SWATDoKill
end
function Lady_Fireman()
	DefineClass.FiremanFemale = {__parents = {"Citizen", "Shapeshifter", "Female"}, entity = "Constructor_F", display_name = "[[17876][Fireman][]]", display_name_plural = "[[17877][Firemen][]]", profession_skill = "Fireman", becomeThought = "become Fireman", workThought = "work Fireman", caste = "Middle", working_car = "FireTruck"}
	FiremanFemale.DoWork = Fireman.DoWork
	FiremanFemale.GoToFireStation = function(self, fs)
		self:ChangeEntity(g_Classes.Fireman:GetEntity())
		local OK = Fireman.GoToFireStation(self, fs)
		self:ChangeEntity(g_Classes.FiremanFemale:GetEntity())
		return OK
	end
	FiremanFemale.GoToFire = function(self, fire)
		self:ChangeEntity(g_Classes.Fireman:GetEntity())
		local OK = Fireman.GoToFire(self, fire)
		self:ChangeEntity(g_Classes.FiremanFemale:GetEntity())
		return OK
	end
	FiremanFemale.Extinguish = function(self, fire)
		self:ChangeEntity(g_Classes.Fireman:GetEntity())
		local OK = Fireman.Extinguish(self, fire)
		self:ChangeEntity(g_Classes.FiremanFemale:GetEntity())
		return OK
	end
end
function Guy_Engineer()
	DefineClass.EngineerMale1 = {__parents = {"Worker", "Male"}, entity = "OfficeWorker_M", display_name = "[[10868][Engineer][]]", display_name_plural = "[[10869][Engineers][]]", profession_skill = "Engineer", caste = "Middle", random_color = true}
	DefineClass.EngineerMale2 = {__parents = {"Worker", "Shapeshifter", "Male"}, entity = "Constructor", display_name = "[[10868][Engineer][]]", display_name_plural = "[[10869][Engineers][]]", profession_skill = "Engineer", caste = "Middle", random_color = true}
	EngineerMale1.DoWork = Engineer.DoWork
	EngineerMale2.DoWork = function(self, worktime)
		local wp = self.workplace
		if wp:IsKindOf("OilWell") then
			self:ChangeEntity(g_Classes.Engineer:GetEntity())
		end
		local OK = Engineer.DoWork(self, worktime)
		self:ChangeEntity(g_Classes.EngineerMale2:GetEntity())
		return OK
	end
end
function Guy_Shopkeeper()
	DefineClass.ShopkeeperMale = {__parents = {"Citizen", "Male"}, display_name = "[[10907][Shopkeeper][]]", display_name_plural = "[[10908][Shopkeepers][]]", entity = "OfficeWorker_M", profession_skill = "Shopkeeper", caste = "Middle", random_color = true}
	ShopkeeperMale.DoWork = Shopkeeper.DoWork
	ShopkeeperMale.DoWorkMarketplace = Shopkeeper.DoWorkMarketplace
	ShopkeeperMale.DoWorkSupermarket = Shopkeeper.DoWorkSupermarket
	ShopkeeperMale.DoWorkSouvenirShop = Shopkeeper.DoWorkSouvenirShop
end
function Guy_Maid()
	DefineClass.MaidMale = {__parents = {"Citizen", "Shapeshifter", "Male"}, display_name = "[[DarthGE1028][Handyman][]]", display_name_plural = "[[DarthGE1029][Handymen][]]", profession_skill = "Maid", caste = "Low", entity = "Constructor"}
	MaidMale.CleanTable = function(self, touristAccom, chain)
		self:ChangeEntity(g_Classes.Maid:GetEntity())
		local OK = Maid.CleanTable(self, touristAccom, chain)
		self:ChangeEntity(g_Classes.MaidMale:GetEntity())
		return OK
	end
	MaidMale.CleanWindow = function(self, touristAccom, chain)
		self:ChangeEntity(g_Classes.Maid:GetEntity())
		local OK = Maid.CleanWindow(self, touristAccom, chain)
		self:ChangeEntity(g_Classes.MaidMale:GetEntity())
		return OK
	end
	MaidMale.Clean = Maid.Clean
	MaidMale.TryClean = Maid.TryClean
	MaidMale.GoClean = Maid.GoClean
	MaidMale.DoWork = Maid.DoWork
end
function Guy_Journalist()
	DefineClass.JournalistMale = {__parents = {"Worker", "Shapeshifter", "Male"}, entity = "OfficeWorker_M", display_name = "[[10877][Journalist][]]", display_name_plural = "[[10878][Journalists][]]", profession_skill = "Journalist", caste = "Middle", random_color = true}
	JournalistMale.DoWork = function(self, worktime)
		local workplace = self.workplace
		if workplace:IsKindOf("MuseumOfModernArt") then
			self:ChangeEntity(g_Classes.Journalist:GetEntity())
		end
		local OK = Journalist.DoWork(self, worktime)
		self:ChangeEntity(g_Classes.JournalistMale:GetEntity())
		return OK
	end
end
function Guy_Cook()
	DefineClass.CookMale = {__parents = {"Citizen", "Male"}, display_name = "[[10862][Cook][]]", display_name_plural = "[[10863][Cooks][]]", entity = "PitBoss", profession_skill = "Cook", caste = "Middle"}
end
function Guy_Bureaucrat()
	DefineClass.BureaucratMale = {__parents = {"Citizen", "Male"}, display_name = "[[10855][Bureaucrat][]]", display_name_plural = "[[10856][Bureaucrats][]]", entity = "Banker", profession_skill = "Bureaucrat", caste = "High", random_color = true}
end
function Guy_Teacher()
	DefineClass.TeacherMale = {__parents = {"Citizen", "Male"}, display_name = "[[10915][Teacher][]]", display_name_plural = "[[10916][Teachers][]]", entity = "Professor", profession_skill = "Teacher", becomeThought = "become Teacher", workThought = "work Teacher", caste = "Middle", random_color = true}
end
function Guy_Barmaid()
	DefineClass.BarmaidMale = {__parents = {"Citizen", "Shapeshifter", "Male"}, display_name = "[[DarthGE1030][Bartender][]]", display_name_plural = "[[DarthGE1031][Bartenders][]]", entity = "OfficeWorker_M", profession_skill = "Barmaid", caste = "Middle", random_color = true}
	BarmaidMale.FindSeat = Barmaid.FindSeat
	BarmaidMale.DoWork = function(self, worktime)
		if self.workplace.class == "Pub" then
			self:ChangeEntity(g_Classes.Barmaid:GetEntity())
		end
		local OK = Barmaid.DoWork(self, worktime)
		self:ChangeEntity(g_Classes.BarmaidMale:GetEntity())
		return OK
	end
end
function Guy_Showgirl()
	DefineClass.ShowgirlMale = {__parents = {"Citizen", "Male"}, entity = "Lumberjack", display_name = "[[DarthGE1032][Chippendale][]]", display_name_plural = "[[DarthGE1033][Chippendales][]]", profession_skill = "Showgirl", caste = "Middle", random_color = true}
end

DefineClass.EdictGenderEquality = {
	__parents = {"Edict"}, 
	id = "GenderEquality", 
	display_name = "[[DarthGE1034][Gender Equality][]]", 
	rollover = "[[DarthGE1035][Jobs are no longer gender specific][]]", 
	description = "[[DarthGE1036][Enacting this edict will put an end to work place gender bias in the Nation of Tropico.  All jobs will be permanently be available to both men and women.][]]", 
	icon = "UI/edicts/genderequality.tga", 
	duration = "permanent", 
	cost = 1000, 
}
EdictGenderEquality.Requirement = function(self, check_only)
end
 
EdictGenderEquality.Init = function(self)
	MakeJobsEqual()
end
function MakeJobsEqual()
	TeamstersOffice.female_worker_class = "TeamsterFemale"
	Garage.female_worker_class = "TeamsterFemale"
	AquaPark.female_worker_class = "AttendantFemale"
	BalloonRide.female_worker_class = "AttendantFemale"
	BeachSite.female_worker_class = "AttendantFemale"
	FerrisWheel.female_worker_class = "AttendantFemale"
	IslandTourOffice.female_worker_class = "AttendantFemale"
	Marina.female_worker_class = "AttendantFemale"
	MovieTheater.female_worker_class = "AttendantFemale"
	Pool.female_worker_class = "AttendantFemale"
	RollerCoaster.female_worker_class = "AttendantFemale"
	Spa.female_worker_class = "AttendantFemale"
	ZeppelinDock.female_worker_class = "AttendantFemale"
	Zoo.female_worker_class = "AttendantFemale"
	AcademyOfScience.female_worker_class = "ProfessorFemale"
	BotanicalGarden.female_worker_class = "ProfessorFemale"
	College.female_worker_class = "ProfessorFemale"
	ColonialMuseum.female_worker_class = "ProfessorFemale"
	HorticultureStation.female_worker_class = "ProfessorFemale"
	Museum.female_worker_class = "ProfessorFemale"
	NuclearPowerPlant.female_worker_class = "ProfessorFemale"
	NuclearProgram.female_worker_class = "ProfessorFemale"
	RadarDish.female_worker_class = "ProfessorFemale"
	WeatherStation.female_worker_class = "ProfessorFemale"
	Cathedral.female_worker_class = "BishopFemale"
	CrystalCathedral.female_worker_class = "BishopFemale"
	Church.female_worker_class = "PriestFemale"
	LoggingCamp.female_worker_class = "LumberjackFemale"
	Bank.female_worker_class = "BankerFemale"
	BankModern.female_worker_class = "BankerFemale"
	BoreholeMine.female_worker_class = "MinerFemale"
	ExcavationSite.female_worker_class = "MinerFemale"
	Mine.female_worker_class = "MinerFemale"
	SaltMine.female_worker_class = "MinerFemale"
	HealthClinic.female_worker_class = "DoctorFemale"
	Hospital.female_worker_class = "DoctorFemale"
	Sanatorium.female_worker_class = "DoctorFemale"
	FishermansWharf.female_worker_class = "FishermanFemale"
	FishFarm.female_worker_class = "FishermanFemale"
	Casino.female_worker_class = "PitBossFemale"
	CustomsOffice.female_worker_class = "CustomsOfficerFemale"
	Dock.female_worker_class = "DockworkerFemale"
	PassengerDock.female_worker_class = "DockworkerFemale"
	GarbageDump.female_worker_class = "GarbagemanFemale"
	WaterTreatment.female_worker_class = "GarbagemanFemale"
	SportsComplex.female_worker_class = "ProAthleteFemale"
	StockExchange.female_worker_class = "StockBrokerFemale"
	Dungeon.female_worker_class = "PolicemanFemale"
	PoliceStation.female_worker_class = "PolicemanFemale"
	Prison.female_worker_class = "PolicemanFemale"
	FireStation.female_worker_class = "FiremanFemale"
	Airport.male_worker_class = "EngineerMale1"
	AirportModern.male_worker_class = "EngineerMale1"
	ElectricPowerPlant.male_worker_class = "EngineerMale2"
	OilRefinery.male_worker_class = "EngineerMale2"
	OilWell.male_worker_class = "EngineerMale2"
	TelecomHQ.male_worker_class = "EngineerMale1"
	ChildhoodHome.male_worker_class = "ShopkeeperMale"
	Marketplace.male_worker_class = "ShopkeeperMale"
	ShoppingMall.male_worker_class = "ShopkeeperMale"
	SouvenirShop.male_worker_class = "ShopkeeperMale"
	Supermarket.male_worker_class = "ShopkeeperMale"
	BeachVilla.male_worker_class = "MaidMale"
	Bungalow.male_worker_class = "MaidMale"
	Hotel.male_worker_class = "MaidMale"
	LuxuryHotel.male_worker_class = "MaidMale"
	LuxuryLiner.male_worker_class = "MaidMale"
	Motel.male_worker_class = "MaidMale"
	SkyscraperHotel.male_worker_class = "MaidMale"
	SkyscraperHotelModern.male_worker_class = "MaidMale"
	MuseumOfModernArt.male_worker_class = "JournalistMale"
	Newspaper.male_worker_class = "JournalistMale"
	RadioStation.male_worker_class = "JournalistMale"
	TVStation.male_worker_class = "JournalistMale"
	CosmicPin.male_worker_class = "CookMale"
	GourmetRestaurant.male_worker_class = "CookMale"
	Restaurant.male_worker_class = "CookMale"
	ShipORant.male_worker_class = "CookMale"
	DiplomaticMinistry.male_worker_class = "BureaucratMale"
	ImmigrationOffice.male_worker_class = "BureaucratMale"
	GradeSchool.male_worker_class = "TeacherMale"
	HighSchool.male_worker_class = "TeacherMale"
	Nightclub.male_worker_class = "BarmaidMale"
	Pub.male_worker_class = "BarmaidMale"
	Cabaret.male_worker_class = "ShowgirlMale"
	Theater.male_worker_class = "ShowgirlMale"
end
table.insert(EdictCategories[5], "EdictGenderEquality")
OnMsg.LoadGame = function()
	if ActiveEdicts.GenderEquality then
		MakeJobsEqual()
	end
end







