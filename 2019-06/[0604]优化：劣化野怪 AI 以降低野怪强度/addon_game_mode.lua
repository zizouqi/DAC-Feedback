	--已经有目标
	if u:GetAttackTarget() ~= nil and u:GetAttackTarget() ~= nil and u:GetAttackTarget():IsNull() == false and u:GetAttackTarget():IsInvisible() == false and u:GetAttackTarget():IsAlive() == true and (u:GetAttackTarget():GetAbsOrigin() - u:GetAbsOrigin()):Length2D() < u:Script_GetAttackRange() + u:GetAttackTarget():GetHullRadius() + u:GetHullRadius() and string.find(u:GetUnitName(), 'pve') == nil then
		-- local newOrder = {
	 -- 		UnitIndex = u:entindex(), 
	 -- 		OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
	 -- 		TargetIndex = u.attack_target:entindex(), 
	 -- 		Queue = 1 
	 -- 	}
		-- ExecuteOrderFromTable(newOrder)
		if u:GetAttackTarget():FindModifierByName('modifier_winter_wyvern_cold_embrace') == nil then
			return 1
		end
	end
	local team_id = u.at_team_id or u.team_id
	local all_unit = GameRules:GetGameModeEntity().to_be_destory_list[team_id]
	local attack_range = u:Script_GetAttackRange()
	local closest_enemy = nil
	local closest_enemy_alt = nil
	local closest_distance = 9999
	local closest_distance_alt = 9999

	for _,v in pairs(all_unit) do
		if v ~= nil and v:IsNull() == false and v:IsAlive() == true then
			if v.team_id ~= u.team_id and v:IsInvisible() == false then
				local d = (v:GetAbsOrigin() - u:GetAbsOrigin()):Length2D()
				if d < closest_distance and d < attack_range + v:GetHullRadius() + u:GetHullRadius() and v:HasModifier('modifier_winter_wyvern_cold_embrace') ~= true then
					closest_enemy = v
					closest_distance = d
				end
				if d < closest_distance_alt and d < attack_range + v:GetHullRadius() + u:GetHullRadius() then
					closest_enemy_alt = v
					closest_distance_alt = d
				end
			end
		end
	end

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