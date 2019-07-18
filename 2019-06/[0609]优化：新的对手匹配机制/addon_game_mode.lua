-- 新增的全局变量
GameRules:GetGameModeEntity().alive_player_table = {}
GameRules:GetGameModeEntity().current_round = {}
GameRules:GetGameModeEntity().last_round = {}
GameRules:GetGameModeEntity().last_2nd_round = {}
GameRules:GetGameModeEntity().last_3rd_round = {}


function AllocateABattleRoundV3()
	local finished = false
	local trytime = 0
	GameRules:GetGameModeEntity().alive_player_table = {}

	local alive_player_count = 0
	--统计玩家死活
	for u,v in pairs(GameRules:GetGameModeEntity().counterpart) do
		if TeamId2Hero(u) ~= nil and TeamId2Hero(u):IsNull() == false and TeamId2Hero(u):IsAlive() == true then
			--活玩家
			GameRules:GetGameModeEntity().counterpart[u] = u
			alive_player_count = alive_player_count + 1
			table.insert(GameRules:GetGameModeEntity().alive_player_table, RandomInt(1, 99) * 100 + u)
		else
			--死玩家
			GameRules:GetGameModeEntity().counterpart[u] = -1
		end
	end
	table.sort(GameRules:GetGameModeEntity().alive_player_table)

	GameRules:GetGameModeEntity().last_3rd_round = GameRules:GetGameModeEntity().last_2nd_round
	GameRules:GetGameModeEntity().last_2nd_round = GameRules:GetGameModeEntity().last_round
	GameRules:GetGameModeEntity().last_round = GameRules:GetGameModeEntity().current_round

	while finished == false and trytime < 10000 do
		trytime = trytime + 1
		GameRules:GetGameModeEntity().current_round = {}
		for i, v in pairs(GameRules:GetGameModeEntity().alive_player_table) do
			local home = GameRules:GetGameModeEntity().alive_player_table[i] % 100
			local away = nil
			if GameRules:GetGameModeEntity().alive_player_table[i + 1] ~= nil then
				away = GameRules:GetGameModeEntity().alive_player_table[i + 1] % 100
			else
				away = GameRules:GetGameModeEntity().alive_player_table[1] % 100
			end
			GameRules:GetGameModeEntity().counterpart[home] = away
			table.insert(GameRules:GetGameModeEntity().current_round, home * 100 + away)
		end

		finished = true
		for i, v in pairs(GameRules:GetGameModeEntity().current_round) do
			if alive_player_count >= 7 then
				finished = not (IsValueInTable(v, GameRules:GetGameModeEntity().last_round) or IsValueInTable(v, GameRules:GetGameModeEntity().last_2nd_round) or IsValueInTable(v, GameRules:GetGameModeEntity().last_3rd_round))
			elseif alive_player_count >= 5 then 
				finished = not (IsValueInTable(v, GameRules:GetGameModeEntity().last_round) or IsValueInTable(v, GameRules:GetGameModeEntity().last_2nd_round))
			elseif alive_player_count >= 3 then 
				finished = not (IsValueInTable(v, GameRules:GetGameModeEntity().last_round))
			elseif alive_player_count >= 1 then 
				finished = true
			else
				return
			end
		end

		-- 不符合条件，重新排序匹配
		if finished ~= true then
			GameRules:GetGameModeEntity().alive_player_table = {}
			for u,v in pairs(GameRules:GetGameModeEntity().counterpart) do
				if TeamId2Hero(u) ~= nil and TeamId2Hero(u):IsNull() == false and TeamId2Hero(u):IsAlive() == true then
					--活玩家
					GameRules:GetGameModeEntity().counterpart[u] = u
					alive_player_count = alive_player_count + 1
					table.insert(GameRules:GetGameModeEntity().alive_player_table, RandomInt(1, 99) * 100 + u)
				else
					--死玩家
					GameRules:GetGameModeEntity().counterpart[u] = -1
				end
			end
			table.sort(GameRules:GetGameModeEntity().alive_player_table)
		end
	end

	local round_info = ''
	for i, v in pairs(GameRules:GetGameModeEntity().last_3rd_round) do
		round_info = round_info..v..'  '
	end
	prt('LAST 3RD ROUND: '..round_info)
	local round_info = ''
	for i, v in pairs(GameRules:GetGameModeEntity().last_2nd_round) do
		round_info = round_info..v..'  '
	end
	prt('LAST 2ND ROUND: '..round_info)
	local round_info = ''
	for i, v in pairs(GameRules:GetGameModeEntity().last_round) do
		round_info = round_info..v..'  '
	end
	prt('LAST ROUND: '..round_info)
	round_info = ''
	for i, v in pairs(GameRules:GetGameModeEntity().current_round) do
		round_info = round_info..v..'  '
	end
	prt('CURRENT ROUND: '..round_info)
	prt('Trytime: '..trytime..'    Finished: '..finished)
end
function IsValueInTable(value, table)
	for k,v in pairs(table) do
	  if v == value then
	  	return true
	  end
	end
	return false
end


-- function StartAPrepareRound() 中 AllocateABattleRound() 修改为 AllocateABattleRoundV3()
function StartAPVPRound()
	--（略）
	--分配对手
	if GameRules:GetGameModeEntity().p2_mode == true then
		AllocateP2Counterpart()
	else
		AllocateABattleRoundV3()
	end
	--（略）
end