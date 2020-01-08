print("WindTurbine Upgrade Mod by DarthPresidente loaded...")
print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))

local AutoYawDrive = {
	{
		icon = "UI/BuildingUpgrates/YawDrive.tga", 
		id = "AutoYawDrive", 
		name = "[[DarthYD1000][Auto Yaw Drive][UpgradeWrapper name]]", 
		price = 1000, 
		rollover = "[[DarthYD1001][Automatically moves the wind turbine into the wind.  Improves power output relative to the altitude of the turbine.][UpgradeWrapper rollover]]"
	}
}
OnMsg.ClassesPreprocess = function()
	WindTurbine.upgrades = AutoYawDrive
	WindTurbineImpl.SetEnabledUpgrade = function(self, upgrade, enable)
		self.cur_upgrades[upgrade.id] = enable
		PowerControl:CheckNewResources()
	end
	WindTurbineImpl.GetProducedPower = function(self, pos)
		if not pos then
			if not rawget(self, "creation_time") then
				return 0
			end
			pos = self:GetPos()
			if not pos:z() or not pos then
				pos = pos:SetZ(terrain.GetHeight(pos))
			end
		end
		local relHeight = MulDivRound(pos:z() - SeaLevel, 100, MaxTerrainElevation)
		if self:IsEnabledUpgrade("AutoYawDrive") then
			return 15 + Clamp(relHeight, 0, 60)
		else
			return 10 + Clamp(relHeight / 3, 0, 30)
		end
	end
end



	