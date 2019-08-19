function Find2SameChessInHandOrOnBoard(caster,chess)
	if chess == 'chess_io1' or chess == 'chess_io' then
		--2星小精灵不参与合成
		return 0,nil,nil,nil
	end
	local count = 0
	local chess1 = nil
	local chess2 = nil
	local chess3 = nil
	if caster ~= nil and caster.hand_entities ~= nil then  -- and GameRules:GetGameModeEntity().is_game_test == false
		for _,v in pairs(GameRules:GetGameModeEntity().to_be_destory_list[caster.team_id]) do
			prt(v.team_id)
			if IsUnitExist(v) == true and v:GetUnitName() == chess and (v:FindAbilityByName('is_druid') == nil or (v:FindAbilityByName('is_druid') ~= nil and GetChessStar(v) == 2)) and v.is_in_battle ~= true and v.is_moving ~= true then
				count = count + 1
				if count == 1 then
					chess1 = v
				end
				if count == 2 then
					chess2 = v
				end
				if count == 3 then
					chess3 = v
				end
			end
		end
	--(略)
end