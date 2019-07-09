function ChessAI(u)
	-- (略)
	elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 11 then
							
		local unluckypoint = FindFarthestGridForAbility(u,a)
	
	-- (略)
end

--水人或沙王用：寻找一个最远的并且在技能伤害范围内的格子，
function FindFarthestGridForAbility(u,a)
	local team_id = u.at_team_id or u.team_id
	local length2d = 0
	local pos1 = u:GetAbsOrigin()
	local skip_postion = nil
	local range = 80

	for k,v in pairs(u:FindAbilityByName(a):GetAbilityKeyValues()) do
        if k == "AbilitySpecial" then
            for l,m in pairs(v) do
                if m['width'] then
                    range = m['width']
                end
            end
        end
    end

	for x=1,8 do
		for y=1,8 do
			local pos2 = XY2Vector(x,y,team_id)
			if IsEmptyGrid(team_id,x,y) and IsGridCanAttackEnemyInRange(x,y,u,range) == true then
				if (pos2-pos1):Length2D() > length2d then
					skip_postion = pos2
					length2d = (pos2-pos1):Length2D()
				end
			end
		end
	end

	return skip_postion
end

--判断格子是否在范围内
function IsGridCanAttackEnemyInRange(x,y,u,range)
	local team_id = u.at_team_id or u.team_id
	--遍历所有单位
	for _,enemy in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
		if enemy.team_id ~= u.team_id and enemy:IsInvisible() == false and (XY2Vector(x,y,team_id) - enemy:GetAbsOrigin()):Length2D() < range + enemy:GetHullRadius() + u:GetHullRadius() and enemy:HasModifier('modifier_winter_wyvern_cold_embrace') == false and IsBozangWudi(enemy) == false then
			return true
		end
	end
	return false
end