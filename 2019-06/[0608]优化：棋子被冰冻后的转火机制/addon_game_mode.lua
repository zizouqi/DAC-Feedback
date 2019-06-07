function IsGridCanAttackEnemy(x,y,u)
	local team_id = u.at_team_id or u.team_id
	local attack_range = u:Script_GetAttackRange() or 210
	--遍历所有单位
	for _,enemy in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
		if enemy.team_id ~= u.team_id and enemy:IsInvisible() == false and (XY2Vector(x,y,team_id) - enemy:GetAbsOrigin()):Length2D() < attack_range + enemy:GetHullRadius() + u:GetHullRadius() then
			return true
		end
	end
	return false
end


-- function FindAClosestEnemyAndAttack(u) 内
	if closest_enemy ~= nil then
		u.attack_target = closest_enemy
		if u:GetAttackTarget() == nil or u:GetAttackTarget():FindModifierByName('modifier_winter_wyvern_cold_embrace') ~= nil then
			local newOrder = {
		 		UnitIndex = u:entindex(), 
		 		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		 		TargetIndex = u.attack_target:entindex(), 
		 		Queue = 0 
		 	}
			ExecuteOrderFromTable(newOrder)
		elseif string.find(u:GetUnitName(), 'pve') ~= nil then
			local newOrder = {
		 		UnitIndex = u:entindex(), 
		 		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		 		TargetIndex = u.attack_target:entindex(), 
		 		Queue = 0 
		 	}
			ExecuteOrderFromTable(newOrder)
		end
		return 1
	elseif closest_enemy_alt ~= nil then
		u.attack_target = closest_enemy_alt
		if u:GetAttackTarget() == nil then
			local newOrder = {
		 		UnitIndex = u:entindex(), 
		 		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
		 		TargetIndex = u.attack_target:entindex(), 
		 		Queue = 0 
		 	}
			ExecuteOrderFromTable(newOrder)
		end
		return 1
	else
		u.attack_target = nil
		return nil
	end