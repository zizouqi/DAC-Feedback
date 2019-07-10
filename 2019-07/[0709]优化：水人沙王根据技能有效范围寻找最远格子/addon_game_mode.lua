function ChessAI(u)
	-- (略)
	elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 11 then
							
		local unluckypoint = FindFarthestGridForAbility(u,a)
	
	-- (略)
end

--水人或沙王用：寻找一个技能伤害最多敌人的最远格子
function FindFarthestGridForAbility(u,a)
	local team_id = u.at_team_id or u.team_id
	local length2d = 0
	local pos1 = u:GetAbsOrigin()
	local skip_postion = nil
	local range = 100
	local target_count = 0

	for k,v in pairs(u:FindAbilityByName(a):GetAbilityKeyValues()) do
        if k == "AbilitySpecial" then
            for l,m in pairs(v) do
            	-- 水人技能宽度
                if m['width'] then
                    range = m['width']
                end
                -- 沙王技能宽度
                if m['burrow_width'] then
                	range = m['burrow_width']
                end
            end
        end
    end

	for x=1,8 do
		for y=1,8 do
			local pos2 = XY2Vector(x,y,team_id)
			local count_temp = TargetCountForMorph(x,y,u,range)
			if IsEmptyGrid(team_id,x,y) and IsGridCanAttackEnemy(x,y,u) and count_temp > 0 then
				-- 伤害更多单位优先
				if count_temp > target_count then
					target_count = count_temp
					skip_postion = pos2
					length2d = (pos2-pos1):Length2D()
				-- 在伤害单位数相同的情况下，距离更远优先
				elseif count_temp == target_count and (pos2-pos1):Length2D() > length2d then
					skip_postion = pos2
					length2d = (pos2-pos1):Length2D()
				end
			end
		end
	end

	return skip_postion
end

--计算位移到目标格时，能伤害到的单位个数
function TargetCountForMorph(x,y,u,range)
	local team_id = u.at_team_id or u.team_id
	local count = 0
	local ability_distance = (u:GetAbsOrigin() - XY2Vector(x,y,team_id)):Length2D()
	--遍历所有单位
	for _,enemy in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
		if enemy.team_id ~= u.team_id and enemy:IsInvisible() == false and IsBozangWudi(enemy) == false then
			local enemy_to_startpoint = (enemy:GetAbsOrigin() - u:GetAbsOrigin()):Length2D()
			local enemy_to_endpoint = (enemy:GetAbsOrigin() - XY2Vector(x,y,team_id)):Length2D()
			local p = (ability_distance + enemy_to_startpoint + enemy_to_endpoint) / 2
			local shortest_distance = 9999
			-- 三个点为钝角三角形，取最短距离
			if math.pow(enemy_to_startpoint, 2) >= math.pow(ability_distance, 2) + math.pow(enemy_to_endpoint, 2) then
		    	shortest_distance = enemy_to_endpoint
		    elseif math.pow(enemy_to_endpoint, 2) >= math.pow(ability_distance, 2) + math.pow(enemy_to_startpoint, 2) then
		    	shortest_distance = enemy_to_startpoint
		    -- 利用海伦公式计算敌方单位到施法路径间的最短距离
		    else
			    shortest_distance = math.sqrt(p * (p - ability_distance) * (p - enemy_to_startpoint) * (p - enemy_to_endpoint)) * 2 / ability_distance
			end
			-- 此处距离判断没有加上施法单位的半径，因为从沙王的实测来看位移技能用下面的公式更合理
		    if shortest_distance <= range + enemy:GetHullRadius() then
		    	count = count + 1
		    end
		end
	end
	return count
end