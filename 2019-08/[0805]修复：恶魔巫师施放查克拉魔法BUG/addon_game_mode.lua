function GetChessAbilityCD(u)
	local cd = 9999
	if IsUnitExist(u) == false then
		return cd
	end
	local ability_name = GameRules:GetGameModeEntity().chess_ability_list[u:GetUnitName()]
	local ability = u:FindAbilityByName(ability_name)
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