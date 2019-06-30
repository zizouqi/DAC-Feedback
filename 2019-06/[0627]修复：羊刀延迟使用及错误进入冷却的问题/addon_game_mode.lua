function TriggerSheepStick(u)
	if u:FindModifierByName("modifier_item_yangdao") == nil then
		return 
	end

	for slot=0,5 do
		if u:GetItemInSlot(slot)~= nil then
			local ability = u:GetItemInSlot(slot)
			local name = ability:GetAbilityName()
			if name == 'item_yangdao' and ability:IsCooldownReady() == true then
				if u:FindAbilityByName("crab_voodoo") == nil then
					AddAbilityAndSetLevel(u,'crab_voodoo')
				end
				local dog = FindHighLevelUnluckyDog(u)
				if u:IsNull() ~= true and dog ~= nil and dog:IsNull() ~= true then
					local newOrder = {
				 		UnitIndex = u:entindex(), 
				 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
				 		TargetIndex = dog:entindex(), 
				 		AbilityIndex = u:FindAbilityByName("crab_voodoo"):entindex(), 
				 		Position = nil, 
				 		Queue = 0 
				 	}
					ExecuteOrderFromTable(newOrder)
					Timers:CreateTimer(0.3,function()
						if dog:HasModifier('modifier_shadow_shaman_voodoo') then
							ability:StartCooldown(15)
							RemoveAllKnightBuff(dog)
						end
					end)
				end
				return 1
			end
		end
	end
end