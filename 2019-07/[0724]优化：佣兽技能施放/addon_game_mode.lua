-- 新增了一个召唤物技能表，也方便今后为召唤物技能进行扩展
GameRules:GetGameModeEntity().summon_ability_list = {
	visage_dragon_1 = 'visage_grave_chill',
	visage_dragon_2 = 'visage_grave_chill',
	visage_dragon_3 = 'visage_grave_chill',
}

-- 为黄泉颤抖增加施法类型
GameRules:GetGameModeEntity().ability_behavior_list = {
	--（略）
	visage_grave_chill = 21,
}

-- 在 function ChessAI(u) 中同时也读取 summon_ability_list 表
-- 第一处修改行原为：a = GameRules:GetGameModeEntity().chess_ability_list[u:GetUnitName()]
function ChessAI(u)
	--（略）

	a = GameRules:GetGameModeEntity().chess_ability_list[u:GetUnitName()] or GameRules:GetGameModeEntity().summon_ability_list[u:GetUnitName()]
	
	--（略）

	elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 21 then
		-- 佣兽寻找攻速最快的敌人
		local unluckydog_1 = nil
		local speed_1 = 0.1
		for i1,v1 in pairs(GameRules:GetGameModeEntity().to_be_destory_list[u.at_team_id or u.team_id]) do
			if v1:GetAttacksPerSecond() > speed_1 and v1.team_id ~= u.team_id and v1:HasModifier("modifier_visage_grave_chill") ~= true then
				speed_1 = v1:GetAttacksPerSecond()
				unluckydog_1 = v1
			end
		end
		if unluckydog_1 ~= nil then
			local newOrder = {
		 		UnitIndex = u:entindex(), 
		 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
		 		TargetIndex = unluckydog_1:entindex(), --Optional.  Only used when targeting units
		 		AbilityIndex = u:FindAbilityByName(a):entindex(), --Optional.  Only used when casting abilities
		 		Position = nil, --Optional.  Only used when targeting the ground
		 		Queue = 0 --Optional.  Used for queueing up abilities
		 	}
			ExecuteOrderFromTable(newOrder)
			return RandomFloat(0.5,2) + ai_delay
		end

	--（略）
end


-- 注释掉 VisageSummonBabyDragon 中的施法逻辑
function VisageSummonBabyDragon(keys)
	--（略）

	Timers:CreateTimer(0.1,function()
		local w = SummonOneMinion(caster,'visage_dragon_'..level)
		ExtendBeastBuff(w,caster)
		play_particle('particles/units/heroes/hero_visage/visage_summon_familiars.vpcf',PATTACH_ABSORIGIN_FOLLOW,w,5)
		AddAbilityAndSetLevel(w,'visage_grave_chill',level)
		-- Timers:CreateTimer(0.2,function()
		-- 	if unluckydog_1 ~= nil then
		-- 		local newOrder_1 = {
		-- 	 		UnitIndex = w:entindex(), 
		-- 	 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
		-- 	 		TargetIndex = unluckydog_1:entindex(), 
		-- 	 		AbilityIndex = w:FindAbilityByName("visage_grave_chill"):entindex(), 
		-- 	 		Position = nil, 
		-- 	 		Queue = 0 
		-- 	 	}
		-- 		ExecuteOrderFromTable(newOrder_1)
		-- 	end
		-- end)

		Timers:CreateTimer(0.6,function()
			local w2 = SummonOneMinion(caster,'visage_dragon_'..level)
			ExtendBeastBuff(w2,caster)
			play_particle('particles/units/heroes/hero_visage/visage_summon_familiars.vpcf',PATTACH_ABSORIGIN_FOLLOW,w2,5)
			AddAbilityAndSetLevel(w2,'visage_grave_chill',level)
			-- Timers:CreateTimer(0.2,function()
			-- 	if unluckydog_2 ~= nil then
			-- 		local newOrder_2 = {
			-- 	 		UnitIndex = w2:entindex(), 
			-- 	 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
			-- 	 		TargetIndex = unluckydog_2:entindex(), 
			-- 	 		AbilityIndex = w2:FindAbilityByName("visage_grave_chill"):entindex(), 
			-- 	 		Position = nil, 
			-- 	 		Queue = 0 
			-- 	 	}
			-- 		ExecuteOrderFromTable(newOrder_2)
			-- 	end
			-- end)
			if level == 3 then
				Timers:CreateTimer(1.1,function()
					local w3 = SummonOneMinion(caster,'visage_dragon_'..level)
					ExtendBeastBuff(w3,caster)
					play_particle('particles/units/heroes/hero_visage/visage_summon_familiars.vpcf',PATTACH_ABSORIGIN_FOLLOW,w3,5)
					AddAbilityAndSetLevel(w3,'visage_grave_chill',level)
					-- Timers:CreateTimer(0.2,function()
					-- 	if unluckydog_3 ~= nil then
					-- 		local newOrder_3 = {
					-- 	 		UnitIndex = w3:entindex(), 
					-- 	 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
					-- 	 		TargetIndex = unluckydog_3:entindex(), 
					-- 	 		AbilityIndex = w3:FindAbilityByName("visage_grave_chill"):entindex(), 
					-- 	 		Position = nil, 
					-- 	 		Queue = 0 
					-- 	 	}
					-- 		ExecuteOrderFromTable(newOrder_3)
					-- 	end
					-- end)
				end)
			end
		end)
	end)
end