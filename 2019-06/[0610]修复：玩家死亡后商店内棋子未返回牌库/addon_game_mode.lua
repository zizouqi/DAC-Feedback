function SyncHP(hero)
	-- (略)
	if hero:GetHealth() <= 0 then
		--玩家死亡
		-- (略)
		--清理商店残留棋子
		if hero.curr_chess_table ~= nil then
			for _,chess in pairs(hero.curr_chess_table) do
				if chess ~= nil then
					AddAChessToChessPool(chess)
				end
			end
		end
		-- (略)
	end
	-- (略)
end
