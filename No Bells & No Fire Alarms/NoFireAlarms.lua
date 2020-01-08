-- NoFireAlarm Mod by DarthPresidente
-- Eliminates the sound when selecting a firestation with
-- an active fire

SilentFireStationOnSelect = function(self)
	GarageBase.OnSelect(self)
end
function DarthNoAlarms()
	g_Classes.FireStation.OnSelect = SilentFireStationOnSelect
	print("NoFireAlarm mod by DarthPresidente loaded...")
	print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))
end
local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                DarthNoAlarms()
                OnMsg.MapPermanentObjectsLoaded = function()
                    DarthNoAlarms()
                end
            end)
        end
    end
end