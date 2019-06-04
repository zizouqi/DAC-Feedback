function ItemMangguo(keys)
	local caster = keys.caster
	AddMana(caster, RandomInt(1,5))
	EmitSoundOn("DOTA_Item.Mango.Activate",caster)
	play_particle('particles/items3_fx/mango_active.vpcf',PATTACH_ABSORIGIN_FOLLOW,caster,3)
end