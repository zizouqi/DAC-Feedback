function DAC:OnRequestBuyChess(keys)

	--（略）

	--判断手牌里是否有两个一样的，有的话直接合成
	local have_exist_count,chess1,chess2,chess3 = Find2SameChessInHand(h,chess)

	--（略）

	--直接合成一个2星的 或者 添加一个1星的
	local have_exist_count,chess1,chess2 = Find2SameChessInHand(h,chess)
	if have_exist_count >= 2 and chess1 ~= nil and chess2 ~= nil and h.is_auto_combine == 1 then

		CombineChessPlus({[1] = chess1,[2] = chess2},(chess..'1'))

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
			hero.hand_entities[hand_index] = nil

	--（略）

end