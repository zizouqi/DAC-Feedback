function FindNextSkipPosition(u)
	local team_id = u.at_team_id or u.team_id
	local skip_postion = nil
	local length2d = 99999
	local pos1 = XY2Vector(u.x,u.y,team_id)
	for x=1,8 do
		for y=1,8 do
			local pos2 = XY2Vector(x,y,team_id)
			if IsGridCanAttackEnemy(x,y,u) == true then
				local next_skip = IsGridCanReach(x,y,u)
				if next_skip ~= nil and (pos2-pos1):Length2D() < length2d then
					skip_postion = next_skip
					length2d = (pos2-pos1):Length2D()
				end
			end
		end
	end
	return skip_postion
end