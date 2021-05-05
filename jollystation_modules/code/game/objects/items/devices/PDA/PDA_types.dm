/// -- PDA extension and additions. --
/proc/get_modular_PDA_regions()
	return list(/obj/item/pda/heads/bridge_officer = list(REGION_COMMAND))

/obj/item/pda
	var/alt_icon = 'jollystation_modules/icons/obj/pda.dmi'

/obj/item/pda/heads/bridge_officer
	name = "bridge officer PDA"
	default_cartridge = /obj/item/cartridge/hos
	icon_state = "pda-bo"

/obj/item/pda/heads/bridge_officer/update_appearance()
	if(icon_state == initial(icon_state))
		icon = alt_icon
	else
		icon = initial(icon)

	. = ..()
