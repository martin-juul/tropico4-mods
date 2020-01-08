print("QuickDestroy Snippet by DarthPresidente loaded...")
print("    SourceFile:", debug.getinfo(1).source:match("@(.*)$"))

OnMsg.ClassesPreprocess = function()
	Building.SetDemolishing = Building_SetDemolishing
end

Building_SetDemolishing = function(self, demolishing)
	if not demolishing then
		demolishing = false
	end
	if demolishing == self.demolishing or self.demolishing and self.demolish_initiated then
		return 
	end
	self.demolishing = demolishing
	self.demolish_initiated = false
	if self.demolishing then
		if self:IsKindOf("ShackGroup") then
			Msg("DemolishObject", self)
			DoneObject(self)
			return 
		elseif self:IsKindOf("LuxuryLiner") then
			self:SetCommand("WaitDemolish")
		else
			self:PlaceExplosives()
			g_ConstructionControl:AddDemolition(self)
		end
		self:PriorityAttachObject("Bomb", "Bomb", true)
		if terminal.IsKeyPressed(const.vkShift) then
			self:SetCommand("SelfDestroy")
		end
	else
		if self:IsKindOf("LuxuryLiner") then
			self:SetCommand(false)
		else
			self:RemoveExplosives()
			g_ConstructionControl:RemoveDemolition(self)
			self.bomber = false
		end
		self:PriorityDetachObject("Bomb", true)
	end
end