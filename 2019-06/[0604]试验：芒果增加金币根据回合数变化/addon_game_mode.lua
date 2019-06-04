function ItemMangguo(keys)
	local caster = keys.caster
	AddMana(caster, RandomInt(1,3) + math.floor((GameRules:GetGameModeEntity().battle_round-1)/12))
	EmitSoundOn("DOTA_Item.Mango.Activate",caster)
	play_particle('particles/items3_fx/mango_active.vpcf',PATTACH_ABSORIGIN_FOLLOW,caster,3)
end