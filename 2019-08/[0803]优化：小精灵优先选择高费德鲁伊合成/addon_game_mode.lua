--为小精灵找一个指定level星级的德鲁伊棋子
function Find1ChessByIO(team_id,level)
	for uuu,v1 in pairs(GameRules:GetGameModeEntity().mychess[team_id]) do
		if v1 ~= nil and v1.combining ~= true then
			if level == 1 and (v1.chess == 'chess_eh' or v1.chess == 'chess_fur' or v1.chess == 'chess_tp' or v1.chess == 'chess_ld') then
				return v1
			end
			if level == 2 and (v1.chess == 'chess_eh1' or v1.chess == 'chess_fur1' or v1.chess == 'chess_tp1' or v1.chess == 'chess_ld1') then
				return v1
			end
		end
	end
end