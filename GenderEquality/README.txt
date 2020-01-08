Title: GenderEquality
Source: https://www.tapatalk.com/groups/tropicomoddng/gender-equality-no-longer-supported-t360.html
Author: DarthPresidente

mod for Modern Times

Rewritten 08/31/2013

I decided to change my whole approach to doing this mod.
I originally created new classes of citizens by copying the tables for existing ones and then
- editing them to fit where I needed them.

Now the mod defines the class from scratch in an OnMsg.ClassesPreprocess function.
This allows the new classes to have the ability to shapeshift.
Shapeshifting allows me to get around the issue of missing animations for entities.
Instead of rewriting a work function so that it bypasses an animation that does not exist for an entity,
the mod shapeshifts the worker to an entity that does have the animation and then shifts them back.

Doing it this way opens up the possibility of adding female variants to soldiers, police, fireman, and swat
- without having to rewrite a ton of their functions that have to do with combat and arrests.

Some users who like to follow and stalk their citizens may not like this change because they will suddenly see their victims turn into dudes.
To them I apologize but it's necessary and I assure you it's only temporary and cosmetic.
The game will still consider them to be females the entire time. These changes also affect how the mod is installed. See below.

What this mod does:

Attempts to make certain jobs available to both genders
To make this work a new class(type) of citizen needed to be created for each position.
The new class was cloned using an existing class of citizen. They will look like an existing class.
Not every class has every type of animation associated with it.

For example: no female class has the animations the miner uses when chipping away at rocks.
This mod attempts to get around that by making the female workers shapeshift into male workers when they are doing a
- job that requires specific animations. This is most noticeable with the Logging Camp.
A female worker will walk into the building, turn into a male, go chop down a tree, bring it back to the building,
then turn back into female form.


New Workers
	TeamsterFemale
		Cloned from: Female Factory Worker
		Works in: Garage, Teamster's Office
	AttendantFemale
		Cloned from: Shopkeeper
		Works in: Aquapark, BalloonRide, BeachSite, FerrisWheel, IslandTourOffice, 		Marina, MovieTheater, Pool, RollerCoaster, Spa, ZeppelinDock, Zoo
	ProfessorFemale
		Cloned from: Bureaucrat
		Works in: AcademyOfScience, BotanicalGarden, College, ColonialMuseum, HorticultureStation, Museum, NuclearPowerPlant, NuclearProgram, RadarDish, WeatherStation
	BishopFemale
		Cloned from: Teacher
		Works in: Cathedral, CrystalCathedral
	BankerFemale
		Cloned from: Bureaucrat
		Works in: Bank, Modern Bank
	MinerFemale
		Cloned from: Female Factory Worker
		Works in: BoreholeMine, Mine, SaltMine
	DoctorFemale
		Cloned from: Engineer
		Works in: HealthClinie, Hospital, Sanatorium
	FishermanFemale
		Cloned from: Female Factory Worker
		Works in: FishermansWharf, FishFarm
    PitBossFemale
        Cloned from: Bureaucrat
        Works in: Casino
    CustomsOfficerFemale
        Cloned from: Bureaucrat
        Works in: CustomsOffice
    DockworkerFemale
        Cloned from: Female Factory Worker
        Works in: Dock, PassengerDock
    GarbagemanFemale
        Cloned from: Female Factory Worker
        Works in: GarbageDump, WaterTreatment
    LumberjackFemale
        Cloned from: Female Factory Worker
        Works in: LoggingCamp
    ProAthleteFemale
        Cloned from: Journalist
        Works in: SportsComplex
    StockBrokerFemale
        Cloned from: Female Office Worker
        Works in: StockExchange
    PolicemanFemale (Added 08/31/2013)
        Cloned from: Bureaucrat
        Works in: PoliceStation, Prison, Dungeon,
    FiremanFemale (Added 09/10/2013)
        Cloned from: Constructor
        Works in: Firestation
    EngineerMale (Added 09/04/2013)
        Cloned from: Constructor and OfficeWorker
        Works in: Airport, AirportModern, ElectricPowerPlant, OilRefinery, OilWell, TelecomHQ
    ShopkeeperMale (Added 09/04/2013)
        Cloned from: OfficeWorker
        Works in: ChildhoodHome, Marketplace, ShoppingMall, SouvenirShop, Supermarket
    MaidMale (Added 09/04/2013)
        Cloned from: Constructor
        Works in: BeachVilla, Bungalow, Hotel, LuxuryHotel, LuxuryLiner, Motel, SkyscraperHotel, SkyscraperHotelModern
    JournalistMale (Added 09/04/2013)
        Cloned from: OfficeWorker
        Works in: MuseumOfModernArt, Newspaper, RadioStation, TVStation
    CookMale (Added 09/04/2013)
        Cloned from: PitBoss
        Works in: CosmicPin, GourmetRestaurant, Restaurant, ShipORant
    BureaucratMale (Added 09/04/2013)
        Cloned from: Banker
        Works in: DiplomaticMinistry, ImmigrationOffice
    TeacherMale (Added 09/04/2013)
        Cloned from: Professor
        Works in: GradeSchool, HighSchool
    BarmaidMale (Added 09/04/2013)
        Cloned from: OfficeWorker
        Works in: Nightclub, Pub
    ShowgirlMale (Added 09/04/2013)
        Cloned from: Lumberjack
        Works in: Cabaret, Theater

New Edict (Added 9/10/2013)
    An edict now activates this mod.
    It's located in the Interior section
    Cost: 1000

WARNINGS

    Using a mod voids eligibility for customer support from the game publisher.
    DO NOT USE WITH SAVED GAMES MADE PRIOR TO INSTALLING THIS MOD.
    DO NOT USE SAVED GAMES MADE WITH THIS MOD AFTER REMOVAL
    This mod might not work with scripted events in campaign or challenges that are looking for X type of workers hired/placed.
    You may have to fire the females and have them replaced by males for certain triggers to be met.

INSTALLATION

If you have a previous version of this mod DELETE IT FIRST.
The download file contains multiple copies of the mod to accommodate differences in installed DLC content.
Unzip the download to your Tropico 4 install folder.

It's possible your combination of DLC content will not work with this download.
If the mod does not seem to work at all please post what DLC content you have installed.
Fixing it is most likely as easy as moving the mod file to the correct directory.

You can check if the mod is loading by opening up the latest log file after exiting the game.
It will be located in "%appdata%\Tropico 4\logs".
If the mod is loaded you should see a line that contains "Gender Equality by DarthPresidente loaded..."
