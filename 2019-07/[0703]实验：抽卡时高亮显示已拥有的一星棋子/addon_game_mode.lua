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

	CustomGameEventManager:Send_ServerToTeam(team_id,"show_draw_card",{
		key = GetClientKey(team_id),
		chesses = curr_chess_table,
		cards = cards,
		curr_money = h:GetMana(),
		unlock = unlock,
	})
end