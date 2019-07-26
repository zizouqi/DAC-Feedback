function ChessAI(u)
	--（略）

	elseif GameRules:GetGameModeEntity().ability_behavior_list[a] == 20 then
		--屠夫的连招
		local unluckydog = FindUnluckyDogFarthest(u)
		if unluckydog ~= nil then
			u.hook_unluckydog = unluckydog
			local newOrder = {
		 		UnitIndex = u:entindex(), 
		 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
		 		TargetIndex = unluckydog:entindex(),
		 		AbilityIndex = u:FindAbilityByName(a):entindex(),
		 		Position = nil,
		 		Queue = 0
		 	}
			ExecuteOrderFromTable(newOrder)

			unluckydog.hook_cb = (function(uuu)
				if IsUnitExist(uuu.hook_unluckydog) == true then
					uuu.is_comboing = true --is_comboing为true的时候，不会执行其他AI打断连招操作
					local new_position = FindClosestEmptyGrid(uuu.hook_unluckydog)
					--改变目标位置
					ChangeUnitPosition(uuu.hook_unluckydog, new_position, true)

					play_particle("particles/econ/items/pudge/pudge_ti6_immortal/pudge_meathook_witness_impact_ti6.vpcf",PATTACH_ABSORIGIN_FOLLOW,uuu.hook_unluckydog,3)

					if ((new_position - uuu:GetAbsOrigin()):Length2D() < 200) then
						--肢解
						uuu:SwapAbilities('pudge_meat_hook_lua','pudge_dismember', false, true)
						Timers:CreateTimer(0.1,function()
							if uuu:FindAbilityByName('pudge_dismember') ~= nil then
								ExecuteOrderFromTable({
							 		UnitIndex = uuu:entindex(), 
							 		OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
							 		TargetIndex = uuu.hook_unluckydog:entindex(), --Optional.  Only used when targeting units
							 		AbilityIndex = u:FindAbilityByName('pudge_dismember'):entindex(), --Optional.  Only used when casting abilities
							 		Position = nil, --Optional.  Only used when targeting the ground
							 		Queue = 0 --Optional.  Used for queueing up abilities
							 	})
							 	if uuu:GetUnitName() == 'chess_pudge11' then
							 		EmitSoundOn("dac.pudge.fresh_meat",uuu)
							 	end
							 	
							 	Timers:CreateTimer(2,function()
							 		if IsUnitExist(uuu) == false then
							 			return
							 		end
							 		if uuu:IsChanneling() == false then
								 		uuu:SwapAbilities('pudge_dismember','pudge_meat_hook_lua', false, true)
								 		uuu.is_comboing = nil
								 		return
								 	end
							 		return 0.1
							 	end)
							end
						end)
					else
						--不肢解
						uuu.is_comboing = nil
					end
				end
			end)
			return 1 + ai_delay
		end

	--（略）

	--不攻击就走动
	if u.attack_target == nil then

	--（略）
end