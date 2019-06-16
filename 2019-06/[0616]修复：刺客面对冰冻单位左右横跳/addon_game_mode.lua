function FindFarthestUnluckyDogAvailablePosition(u)
	local team_id = u.at_team_id or u.team_id
	if u.team_id ~= 4 then
		if RandomInt(0,100) > 50 then
			for j=8,1,-1 do
				for i=8,1,-1 do
					if GameRules:GetGameModeEntity().unit[team_id][j..'_'..i] == nil then
						for _,unit in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
							if unit.team_id ~= u.team_id and (XY2Vector(i,j,team_id) - XY2Vector(unit.x,unit.y,team_id)):Length2D() < u:Script_GetAttackRange() + u:GetHullRadius() + unit:GetHullRadius() then
								return XY2Vector(i,j,team_id)
							end
						end
					end
				end
			end
		else
			for j=8,1,-1 do
				for i=1,8 do
					if GameRules:GetGameModeEntity().unit[team_id][j..'_'..i] == nil then
						for _,unit in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
							if unit.team_id ~= u.team_id and (XY2Vector(i,j,team_id) - XY2Vector(unit.x,unit.y,team_id)):Length2D() < u:Script_GetAttackRange() + u:GetHullRadius() + unit:GetHullRadius() then
								return XY2Vector(i,j,team_id)
							end
						end
					end
				end
			end
		end
	else
		if RandomInt(0,100) > 50 then
			for j=1,8 do
				for i=1,8 do
					if GameRules:GetGameModeEntity().unit[team_id][j..'_'..i] == nil then
						for _,unit in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
							if unit.team_id ~= u.team_id and (XY2Vector(i,j,team_id) - XY2Vector(unit.x,unit.y,team_id)):Length2D() < u:Script_GetAttackRange() + u:GetHullRadius() + unit:GetHullRadius() then
								return XY2Vector(i,j,team_id)
							end
						end
					end
				end
			end
		else
			for j=1,8 do
				for i=8,1,-1 do
					if GameRules:GetGameModeEntity().unit[team_id][j..'_'..i] == nil then
						for _,unit in pairs (GameRules:GetGameModeEntity().to_be_destory_list[team_id]) do
							if unit.team_id ~= u.team_id and (XY2Vector(i,j,team_id) - XY2Vector(unit.x,unit.y,team_id)):Length2D() < u:Script_GetAttackRange() + u:GetHullRadius() + unit:GetHullRadius() then
								return XY2Vector(i,j,team_id)
							end
						end
					end
				end
			end
		end
	end
	return nil
end