function ChessAI(u)
	-- (略)
	elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 11 then
							
		local unluckypoint = FindFarthestCanAttackEnemyEmptyGrid(u)
	
	-- (略)
end