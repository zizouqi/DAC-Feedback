elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 19 then
	-- 蝙蝠火
	local unluckypoint = FindFarthestCanAttackEnemyEmptyGrid(u)
	if unluckypoint ~= nil then
		local newOrder = {
	 		UnitIndex = u:entindex(), 
	 		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
	 		TargetIndex = nil, --Optional.  Only used when targeting units
	 		AbilityIndex = u:FindAbilityByName(a):entindex(), --Optional.  Only used when casting abilities
	 		Position = nil, --Optional.  Only used when targeting the ground
	 		Queue = 0 --Optional.  Used for queueing up abilities
	 	}
		ExecuteOrderFromTable(newOrder)

		-- 跳跃
		local target_x = Vector2X(unluckypoint,u.at_team_id or u.team_id)
		local target_y = Vector2Y(unluckypoint,u.at_team_id or u.team_id)
		local xx = u.x
		local yy = u.y
		GameRules:GetGameModeEntity().unit[u.at_team_id or u.team_id][yy..'_'..xx] = nil
		GameRules:GetGameModeEntity().unit[u.at_team_id or u.team_id][target_x..'_'..target_y] = 1
		u:SetForwardVector((unluckypoint - u:GetAbsOrigin()):Normalized())
		u.is_moving = true
		BlinkChessX({
			p = unluckypoint,
			caster = u,
			blink_type = 'jump',
		})
		u.y_x = target_y..'_'..target_x
		u.y = target_y
		u.x = target_x
		
		return RandomFloat(0.5,2) + ai_delay
	end