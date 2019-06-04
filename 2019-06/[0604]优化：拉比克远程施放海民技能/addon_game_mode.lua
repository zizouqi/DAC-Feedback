elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 5 then
	--近身单位目标
	local unluckydog = FindUnluckyDog190(u)
	if unluckydog ~= nil then
		local newOrder = {
	 		UnitIndex = u:entindex(), 
	 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
	 		TargetIndex = unluckydog:entindex(), --Optional.  Only used when targeting units
	 		AbilityIndex = u:FindAbilityByName(a):entindex(), --Optional.  Only used when casting abilities
	 		Position = nil, --Optional.  Only used when targeting the ground
	 		Queue = 0 --Optional.  Used for queueing up abilities
	 	}
		ExecuteOrderFromTable(newOrder)
		if unluckydog:FindModifierByName('modifier_gs_give_fuhun') ~= nil then
			CopyAbility2FuhunUnit(u,unluckydog,a)
		end
		return RandomFloat(0.5,2) + ai_delay
	end