-- NoBells Mod by DarthPresidente
-- Eliminates the annoying LOUD bell sounds when selecting a
-- Cathedral or Church

function DarthSTFU(self)
	-- DO ABSOLUTELY NOTHING!
end
function DarthNoBells()
	g_Classes.Church.OnSelect = nil
	g_Classes.Cathedral.OnSelect = nil
	print("NoBells mod by DarthPresidente loaded...")
	print("    Version:  	1.0")
	print("    SourceFile:	game/NoBells.lua")
end
local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                DarthNoBells()
                OnMsg.MapPermanentObjectsLoaded = function()
                    DarthNoBells()
                end
            end)
        end
    end
end