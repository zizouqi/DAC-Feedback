function GetChessAbilityCD(u)
	local cd = 9999
	if IsUnitExist(u) == false then
		return cd
	end
	local ability_name = GameRules:GetGameModeEntity().chess_ability_list[u:GetUnitName()]
	local ability = u:FindAbilityByName(ability_name)
	if GetChessTypeName(u) == 'chess_rubick' and u.steal_ability ~= nil then
		ability = u:FindAbilityByName(u.steal_ability)
	end
	local cd = math.floor(ability:GetCooldownTimeRemaining())
	return cd
end

function ReduceChessAbilityCD(u,sec)
	if IsUnitExist(u) == false then
		return
	end
	if sec == nil then
		return
	end
	local ability_name = GameRules:GetGameModeEntity().chess_ability_list[u:GetUnitName()]
	local ability = u:FindAbilityByName(ability_name)
	if GetChessTypeName(u) == 'chess_rubick' and u.steal_ability ~= nil then
		ability = u:FindAbilityByName(u.steal_ability)
	end
	local cd = ability:GetCooldownTimeRemaining()
	local cd_new = cd - sec
	if cd_new < 0 then
		cd_new = 0
	end
	if cd_new <= 0 then
		ability:EndCooldown()
	else
		ability:EndCooldown()
		ability:StartCooldown(cd_new)
	end
end