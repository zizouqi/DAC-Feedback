--新增一个施法类型，用于优化火女施法逻辑
elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 17 then
	local unluckydog = FindUnluckyDogByAbilityDamage(u,a)
	if unluckydog ~= nil then
		local newOrder = {
	 		UnitIndex = u:entindex(), 
	 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
	 		TargetIndex = unluckydog:entindex(), --Optional.  Only used when targeting units
	 		AbilityIndex = u:FindAbilityByName(a):entindex(), --Optional.  Only used when casting abilities
	 		Position = nil, --Optional.  Only used when targeting the ground
	 		Queue = 0 --Optional.  Used for queueing up abilities
	 	}
		ExecuteOrderFromTable(newOrder)
		if a == 'lina_laguna_blade' then
			local level = u:FindAbilityByName('lina_laguna_blade'):GetLevel()
			InvisibleUnitCast({
				caster = u,
				ability = 'give_fiery_soul',
				level = level,
				unluckydog = u,
			})
		end
		if unluckydog:FindModifierByName('modifier_gs_give_fuhun') ~= nil then
			CopyAbility2FuhunUnit(u,unluckydog,a)
		end

		return RandomFloat(0.5,2) + ai_delay
	end

--新增 function，寻找血量与技能伤害量最相近的棋子
function FindUnluckyDogByAbilityDamage(u,ability)
	local unluckydog = nil
	local hp_abs = 9999
	local hp_estimate = u:FindAbilityByName(ability):GetAbilityDamage()
	for _,unit in pairs (GameRules:GetGameModeEntity().to_be_destory_list[u.at_team_id or u.team_id]) do
		if unit.team_id ~= u.team_id and unit:IsNull() == false and unit:IsAlive() == true then
			--魔法伤害，引入魔抗系数进行计算
			if u:FindAbilityByName(ability):GetAbilityDamageType() == 2 then
				if math.abs(unit:GetHealth() - hp_estimate * (1 - unit:GetBaseMagicalResistanceValue())) < hp_abs then
					unluckydog = unit
					hp_abs = math.abs(unit:GetHealth() - hp_estimate * (1 - unit:GetBaseMagicalResistanceValue()))
				end
			--物理及纯粹伤害
			else
				if math.abs(unit:GetHealth() - hp_estimate) < hp_abs then
					unluckydog = unit
					hp_abs = math.abs(unit:GetHealth() - hp_estimate)
				end
			end
		end
	end
	return unluckydog
end