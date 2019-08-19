function RemoveChess(keys)
	local target = keys.target
	local caster = keys.caster
	local position = target:GetAbsOrigin()
	local team_id = target.team_id
	local x = Vector2X(position,team_id)
	local y = Vector2Y(position,team_id)
	local extra_time = 0
	if GetMapName() == 'casual_2x4_ob' or GetMapName() == 'casual_2x4' or GetMapName() == 'ranked_2x4' then
		extra_time = 5
	end

	if string.find(target:GetUnitName(),'chess_') == nil then
		return
	end

	if target.is_removing == true then
		return
	end	
	if keys.force_remove ~= true then
		if (GameRules:GetGameModeEntity().game_status == 2 and target.hand_index == nil) or (GameRules:GetGameModeEntity().game_status == 1 and target.hand_index == nil and (GameRules:GetGameModeEntity().prepare_timer > 33 + extra_time or GameRules:GetGameModeEntity().prepare_timer < 2)) then
	--（略）
end