function DAC:OnRequestBuyChess(keys)

	--（略）

	--判断是否有两个一样的棋子，有的话直接合成
	local have_exist_count,chess1,chess2,chess3 = Find2SameChessInHandOrOnBoard(h,chess)

	--（略）

	--直接合成一个2/3星的 或者 添加一个1星的
	local have_exist_count,chess1,chess2 = Find2SameChessInHandOrOnBoard(h,chess)
	if have_exist_count >= 2 and chess1 ~= nil and chess2 ~= nil and h.is_auto_combine == 1 then
		local advanve_chess = chess..'1'
		local advanve_have_exist_count,advanve_chess1,advanve_chess2 = Find2SameChessInHandOrOnBoard(h,advanve_chess)
		if advanve_have_exist_count >= 2 then
			CombineChessPlus({[1] = chess1,[2] = chess2,[3] = advanve_chess1,[4] = advanve_chess2},(chess..'11'))
		else
			CombineChessPlus({[1] = chess1,[2] = chess2},(chess..'1'))
		end

		-- local items_table = GetAllItemsInUnits({
		-- 	[1] = chess1,
		-- 	[2] = chess2,
		-- })
		-- RemoveChess({ caster = h, target = chess1, is_sell = false })
		-- RemoveChess({ caster = h, target = chess2, is_sell = false })
		-- chess = chess..'1'
		
		-- Timers:CreateTimer(0.3,function()
		-- 	local uu = CreateChessInHand(h,chess,"particles/units/unit_greevil/loot_greevil_death.vpcf")
		-- 	PlayCombineSound(uu)
		-- 	GiveItems2Unit(items_table,uu)

		-- 	ShowStarsOnChess(uu)
		-- 	--发弹幕
		-- 	CustomGameEventManager:Send_ServerToAllClients("bullet",{
		-- 		player_id = TeamId2Hero(team_id):GetPlayerID(),
		-- 		vip = TeamId2Hero(team_id).is_vip,
		-- 		target = chess,
		-- 	})

		-- 	Timers:CreateTimer(0.5,function()
		-- 		--二次合成？
		-- 		TriggerCombineHand(h,chess)
		-- 	end)
		-- end)
	else
		CreateChessInHand(h,chess)
	end
end


function CombineChessPlus(units, advance_unit_name)

	--（略）

	--移除低级棋子
	for _,u in pairs(units) do
		if u.hand_index ~= nil then
			GameRules:GetGameModeEntity().hand[team_id][u.hand_index] = 0
			hero.hand_entities[u.hand_index] = nil

	--（略）

end


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
			if IsUnitExist(v) == true and v:GetUnitName() == chess and v:FindAbilityByName('is_druid') == nil then
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
		for _,v in pairs(caster.hand_entities) do
			if IsUnitExist(v) == true and v:GetUnitName() == chess and v:FindAbilityByName('is_druid') == nil then
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
		return count,chess1,chess2,chess3
	else
		return 0,nil,nil,nil
	end
end