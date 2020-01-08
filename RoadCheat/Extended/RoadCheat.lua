-- 	RoadCheat mod by DarthPresidente
-- 
-- 	What it does:
--		Allows building of overlapping roads!

--	How it works:
--		Simply hold down the CTRL key to allow crossing over of roads during building.


local DarthExecOnce = false
local Orig_RCGBR
function DarthRoadCheat()
	if not DarthExecOnce then
		Orig_RCGBR = road_construction.GetBlockingRoads
		DarthExecOnce = true
	end
	road_construction.GetBlockingRoads = function(self, road_obj, crossroad1, crossroad2)
		if terminal.IsKeyPressed(const.vkControl) then
			return false, false
		end
		return Orig_RCGBR(self, road_obj, crossroad1, crossroad2)
	end
	rs_enum_distance = 30000
	rs_urban_distance = 26000
	print("RoadCheat mod by DarthPresidente loaded...")
	print("    Version:  	1.0 - Extended Roads Edition")
	print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))
end

local FiredOnce = false
OnMsg.UASetMode = function(actions,mode)
    if not FiredOnce then
        if(mode == "Boot") then
            FiredOnce = true
            CreateRealTimeThread(function()
                DarthRoadCheat()
                OnMsg.MapPermanentObjectsLoaded = function()
                    DarthRoadCheat()
                end
            end)
        end
    end
end