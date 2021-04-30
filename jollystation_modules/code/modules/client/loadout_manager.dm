/datum/loadout_manager
	var/client/owner

/datum/loadout_manager/New(user)
	owner = CLIENT_FROM_VAR(user)

/datum/loadout_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/loadout_manager/ui_close(mob/user)
	qdel(src)

/datum/loadout_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "_LoadoutManager")
		ui.open()
