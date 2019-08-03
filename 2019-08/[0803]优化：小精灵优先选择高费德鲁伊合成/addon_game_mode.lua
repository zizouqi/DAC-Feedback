--为小精灵找一个指定level星级的德鲁伊棋子
function Find1ChessByIO(team_id,level)
	local cost = 0
	local combine_chess = nil
	for uuu,v1 in pairs(GameRules:GetGameModeEntity().mychess[team_id]) do
		if v1 ~= nil and v1.combining ~= true and EntIndexToHScript(v1.index):FindAbilityByName('is_druid') ~= nil then
			local chess = EntIndexToHScript(v1.index)
			if GetChessStar(chess) == level and cost < GameRules:GetGameModeEntity().chess_2_mana[GetChessTypeName(chess)] then
				cost = GameRules:GetGameModeEntity().chess_2_mana[GetChessTypeName(chess)]
				combine_chess = v1
			end
		end
	end
	return combine_chess
end