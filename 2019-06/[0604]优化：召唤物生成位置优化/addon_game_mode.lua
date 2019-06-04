function FindEmptyGridAtUnit(u)
	local team_id = u.at_team_id or u.team_id

	--优先选取面前的空格子
	local forward_v  = u:GetAbsOrigin() + u:GetForwardVector():Normalized()*128
	local forward_x = Vector2X(forward_v,team_id)
	local forward_y = Vector2Y(forward_v,team_id)
	if IsIn8x8(forward_x,forward_y) == true and IsEmptyGrid(team_id,forward_x,forward_y) == true then
		debug('FindEmptyGridAtUnit选中x='..forward_x..',y='..forward_y)
		return XY2Vector(forward_x,forward_y,team_id)
	end

	--遍历身边的格子
	local random1 = RandomInt(0, 1)
	local random2 = 1
	
	if random1 == 0 then
		random1 = -1
	end
	if u.team_id == 4 then
		random2 = -1
	end
	
	for y = 1*random2,-1*random2,-1*random2 do
		for x = -1*random1,1*random1,random1 do
			if IsIn8x8(u.x+x,u.y+y) == true and IsEmptyGrid(team_id,u.x+x,u.y+y) == true then
				debug('FindEmptyGridAtUnit选中x='..(u.x+x)..',y='..(u.y+y))
				return XY2Vector(u.x+x,u.y+y,team_id)
			end
		end
	end

	for xx = -2,2 do
		for yy = -2,2 do
			if IsIn8x8(u.x+xx,u.y+yy) == true and IsEmptyGrid(team_id,u.x+xx,u.y+yy) == true then
				debug('FindEmptyGridAtUnit选中x='..(u.xx+x)..',y='..(u.y+yy))
				return XY2Vector(u.x+xx,u.y+yy,team_id)
			end
		end
	end

	return nil
end