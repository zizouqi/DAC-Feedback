function Find2SameChessInHandOrOnBoard(caster,chess)
	--（略）
	if caster ~= nil and caster.hand_entities ~= nil then  -- and GameRules:GetGameModeEntity().is_game_test == false
		for _,v in pairs(GameRules:GetGameModeEntity().to_be_destory_list[caster.team_id]) do
			if IsUnitExist(v) == true and v:GetUnitName() == chess and (v:FindAbilityByName('is_druid') == nil or (v:FindAbilityByName('is_druid') ~= nil and GetChessStar(v) == 2)) and v.is_in_battle ~= true and v.is_moving ~= true then
	--（略）
end 

function CombineChessPlus(units, advance_unit_name)
	--（略）

	if u2 ~= nil and u2:HasAbility('is_druid') and string.find(u2:GetUnitName(),'11') == nil and druid_count >= 4 then
		--德鲁伊（4）：两个一样的2星可以合
		table.insert(units,u2)
		advance_unit_name = advance_unit_name..'1'

		if IsChessInHand(u2) == false then
			is_target_in_hand = false
			p = u2:GetAbsOrigin()
			y = u2.y
			x = u2.x
		end

	--（略）
end