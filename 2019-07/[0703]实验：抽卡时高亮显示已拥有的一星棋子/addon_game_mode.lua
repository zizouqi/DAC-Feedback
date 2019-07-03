function Draw5ChessAndShow(team_id, unlock)
	local h = TeamId2Hero(team_id)
	if h.chesslock == true then
		CustomGameEventManager:Send_ServerToTeam(h:GetTeam(),"show_draw_card",{
			key = GetClientKey(h:GetTeam()),
			cards = nil,
			curr_money = h:GetMana(),
			auto_unlock = true,
		})
		h.chesslock = false
		return
	end
	--把上次剩的洗回棋库
	h.ban_chess_list = {}
	if h.curr_chess_table ~= nil then
		for _,chess in pairs(h.curr_chess_table) do
			if chess ~= nil then
				table.insert(h.ban_chess_list,chess)
				AddAChessToChessPool(chess)
			end
		end
	end
	h.curr_chess_table = {}
	--抽！
	local cards,curr_chess_table = RandomNDrawChessNew(team_id,5)
	h.curr_chess_table = curr_chess_table
	level_one_chess = FindLevelOneChess(h)

	CustomGameEventManager:Send_ServerToTeam(team_id,"show_draw_card",{
		key = GetClientKey(team_id),
		chesses = curr_chess_table,
		cards = cards,
		level_one_chess = level_one_chess,
		curr_money = h:GetMana(),
		unlock = unlock,
	})
end

function FindLevelOneChess(hero)
	local level_one_chess = ''
	if hero ~= nil then
		for k,v in pairs(GameRules:GetGameModeEntity().to_be_destory_list[hero.team_id]) do
			if GetChessStar(v) == 1 then
				level_one_chess = level_one_chess..v:GetUnitName()..','
			end
		end
		if hero.hand_entities ~= nil then
			for k,v in pairs(hero.hand_entities) do
				--prt(v:GetUnitName())
				--prt(GetChessStar(v))
				if GetChessStar(v) == 1 then
					level_one_chess = level_one_chess..v:GetUnitName()..','
				end
			end
		end
	end
	return level_one_chess
end