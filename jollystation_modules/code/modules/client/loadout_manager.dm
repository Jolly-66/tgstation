#define LOADOUT_ITEM_BACK "back"
#define LOADOUT_ITEM_BELT "belt"
#define LOADOUT_ITEM_EARS "ears"
#define LOADOUT_ITEM_GLASSES "glasses"
#define LOADOUT_ITEM_GLOVES "gloves"
#define LOADOUT_ITEM_HEAD "head"
#define LOADOUT_ITEM_MASK "mask"
#define LOADOUT_ITEM_NECK "neck"
#define LOADOUT_ITEM_SHOES "shoes"
#define LOADOUT_ITEM_UNIFORM "under"
#define LOADOUT_ITEM_MISC "pocket_items"

/mob/verb/debug_open_loadout_manager()
	set name = "(DEBUG) Open Loadouts"
	set category = "OOC"

	var/datum/loadout_manager/tgui = new(usr)
	tgui.ui_interact(usr)

/* Takes an assoc list of [string]s to [typepaths]s
 * (Such as the global assoc lists of loadout items)
 * And formats it into an object for TGUI.
 *
 *  - list[name] is the string / key of the item.
 *  - list[path] is the typepath of the item.
 */
/proc/list_to_data(assoc_item_list)
	if(!LAZYLEN(assoc_item_list))
		return null

	var/list/formatted_list = new(length(assoc_item_list))

	var/array_index = 1
	for(var/path_id in assoc_item_list)
		var/list/formatted_item = list()
		formatted_item["name"] = path_id
		formatted_item["path"] = assoc_item_list[path_id]
		formatted_list[array_index++] = formatted_item

	return formatted_list

/// An empty outfit we fill in with our loadout items to dress our dummy.
/datum/outfit/player_loadout
	name = "Player Loadout"

/// Datum holder for the loadout manager UI.
/datum/loadout_manager
	/// The key of the dummy we use to generate sprites
	var/dummy_key
	/// The client of the person using the UI
	var/client/owner
	/// A ref to the dummy outfit we use
	var/datum/outfit/player_loadout/custom_loadout

/datum/loadout_manager/New(user)
	owner = CLIENT_FROM_VAR(user)
	custom_loadout = new()
	if(!owner.prefs.loadout_list)
		owner.prefs.loadout_list = list()

/datum/loadout_manager/ui_close(mob/user)
	clear_human_dummy(dummy_key)
	qdel(custom_loadout)
	qdel(src)

/datum/loadout_manager/proc/init_dummy()
	dummy_key = "loadoutmanagerUI_[owner.mob]"
	generate_dummy_lookalike(dummy_key, owner.mob)
	unset_busy_human_dummy(dummy_key)
	return

/datum/loadout_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/loadout_manager/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "_LoadoutManager")
		ui.open()

/datum/loadout_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("select_item")
			owner.prefs.loadout_list[params["category"]] = params["path"]
			loadout_to_outfit()

	return TRUE

/datum/loadout_manager/ui_data(mob/user)
	var/list/data = list()
	if(!dummy_key)
		init_dummy()

	var/icon/dummysprite = get_flat_human_icon(null,
		dummy_key = dummy_key,
		outfit_override = custom_loadout,
		showDirs = list(SOUTH),
		)
	data["icon64"] = icon2base64(dummysprite)
	data["selected_loadout"] = owner.prefs.loadout_list

	return data

/datum/loadout_manager/ui_static_data()
	var/list/data = list()

	// [ID] is the displayed name of the slot.
	// [slot] is the internal name of the slot.
	// [contents] is a formatted list of all the possible items for that slot.
	//  - [contents.name] is the key of the item in the global assoc list.
	//  - [contents.path] is the typepath of the item in the global assoc list.
	var/list/loadout_tabs = list()
	loadout_tabs += list(list("id" = "Back", "slot" = LOADOUT_ITEM_BACK, "contents" = list_to_data(GLOB.loadout_backs)))
	loadout_tabs += list(list("id" = "Belt", "slot" = LOADOUT_ITEM_BELT, "contents" = list_to_data(GLOB.loadout_belts)))
	loadout_tabs += list(list("id" = "Ears", "slot" = LOADOUT_ITEM_EARS, "contents" = list_to_data(GLOB.loadout_ears)))
	loadout_tabs += list(list("id" = "Glasses", "slot" = LOADOUT_ITEM_GLASSES, "contents" = list_to_data(GLOB.loadout_glasses)))
	loadout_tabs += list(list("id" = "Gloves", "slot" = LOADOUT_ITEM_GLOVES, "contents" = list_to_data(GLOB.loadout_gloves)))
	loadout_tabs += list(list("id" = "Headgear", "slot" = LOADOUT_ITEM_HEAD, "contents" = list_to_data(GLOB.loadout_helmets)))
	loadout_tabs += list(list("id" = "Mask", "slot" = LOADOUT_ITEM_MASK, "contents" = list_to_data(GLOB.loadout_masks)))
	loadout_tabs += list(list("id" = "Neck", "slot" = LOADOUT_ITEM_NECK, "contents" = list_to_data(GLOB.loadout_necks)))
	loadout_tabs += list(list("id" = "Shoes", "slot" = LOADOUT_ITEM_SHOES, "contents" = list_to_data(GLOB.loadout_shoes)))
	loadout_tabs += list(list("id" = "Uniform", "slot" = LOADOUT_ITEM_UNIFORM, "contents" = list_to_data(GLOB.loadout_unders)))
	loadout_tabs += list(list("id" = "Misc. Items", "slot" = LOADOUT_ITEM_MISC, "contents" = list_to_data(GLOB.loadout_pocket_items)))

	data["loadout_tabs"] = loadout_tabs

	return data

/// Turns our client's assoc list of loadout items into actual items on our dummy outfit.
/datum/loadout_manager/proc/loadout_to_outfit()
	var/list/loadout = owner.prefs.loadout_list
	if(!LAZYLEN(loadout))
		return null

	for(var/slot in loadout)
		switch(slot)
			if(LOADOUT_ITEM_BACK)
				custom_loadout.back = loadout[slot]
			if(LOADOUT_ITEM_BELT)
				custom_loadout.belt = loadout[slot]
			if(LOADOUT_ITEM_EARS)
				custom_loadout.ears = loadout[slot]
			if(LOADOUT_ITEM_GLASSES)
				custom_loadout.glasses = loadout[slot]
			if(LOADOUT_ITEM_GLOVES)
				custom_loadout.gloves = loadout[slot]
			if(LOADOUT_ITEM_HEAD)
				custom_loadout.head = loadout[slot]
			if(LOADOUT_ITEM_MASK)
				custom_loadout.mask = loadout[slot]
			if(LOADOUT_ITEM_NECK)
				custom_loadout.neck = loadout[slot]
			if(LOADOUT_ITEM_SHOES)
				custom_loadout.shoes = loadout[slot]
			if(LOADOUT_ITEM_UNIFORM)
				custom_loadout.uniform = loadout[slot]
			if(LOADOUT_ITEM_MISC)
				if(custom_loadout.backpack_contents)
					custom_loadout.backpack_contents += loadout[slot]
				else
					custom_loadout.backpack_contents = list(loadout[slot])
