/datum/antagonist/traitor/intiltrator
	name = "Infiltrator"
	hijack_speed = 1
	employer = "The Syndicate"
	give_objectives = FALSE
	should_give_codewords = FALSE
	should_equip = FALSE
	finalize_antag = FALSE

/datum/antagonist/traitor/intiltrator/on_gain()
	if(!GLOB.admin_objective_list)
		generate_admin_objective_list()

	var/list/objectives_to_choose = GLOB.admin_objective_list.Copy() - blacklisted_similar_objectives

	linked_advanced_datum = new /datum/advanced_antag_datum/traitor/infiltrator(src)
	linked_advanced_datum.setup_advanced_antag()
	linked_advanced_datum.possible_objectives = objectives_to_choose
	return ..()

/// Greet the antag with big menacing text.
/datum/antagonist/traitor/intiltrator/greet()
	linked_advanced_datum.greet_message(owner.current)

/datum/antagonist/traitor/intiltrator/roundend_report()
	var/list/result = list()

	result += printplayer(owner)
	result += "<b>[owner]</b> was \a <b>[linked_advanced_datum.name], sent to infiltrate [station_name()]</b>[employer? ", employed by <b>[employer]</b>":""]."
	if(linked_advanced_datum.backstory)
		result += "<b>[owner]'s</b> backstory was the following: <br>[linked_advanced_datum.backstory]"

	var/TC_uses = 0
	var/uplink_true = FALSE
	var/purchases = ""

	if(should_equip)
		LAZYINITLIST(GLOB.uplink_purchase_logs_by_key)
		var/datum/uplink_purchase_log/H = GLOB.uplink_purchase_logs_by_key[owner.key]
		if(H)
			uplink_true = TRUE
			TC_uses = H.total_spent
			purchases += H.generate_render(FALSE)

	if(LAZYLEN(linked_advanced_datum.our_goals))
		var/count = 1
		for(var/datum/advanced_antag_goal/goal as anything in linked_advanced_datum.our_goals)
			result += goal.get_roundend_text(count)
			count++
		if(uplink_true)
			result += "<br>They were afforded <b>[linked_advanced_datum.starting_points]</b> tc to accomplish these tasks."

	if(uplink_true)
		var/uplink_text = "(used [TC_uses] TC) [purchases]"
		result += uplink_text
	else if (!should_equip)
		result += "<br>The [name] never obtained their uplink!"

	return result.Join("<br>")

/datum/antagonist/traitor/intiltrator/roundend_report_footer()
	return "<br>And thus ends another attempted Syndicate infiltration on board [station_name()]."

/// An extra button for the TP, to open the goal panel
/datum/antagonist/traitor/intiltrator/get_admin_commands()
	. = ..()
	.["View Goals"] = CALLBACK(src, .proc/show_advanced_traitor_panel, usr)

/// An extra button for check_antagonists, to open the goal panel
/datum/antagonist/traitor/intiltrator/antag_listing_commands()
	. = ..()
	. += "<a href='?_src_=holder;[HrefToken()];admin_check_goals=[REF(src)]'>Show Goals</a>"

/datum/antagonist/traitor/intiltrator/equip(silent = FALSE)
	var/mob/living/carbon/human/traitor_mob = owner.current
	if (!istype(traitor_mob))
		return

	var/obj/item/implant/uplink/infiltrator_implant = new(traitor_mob)
	infiltrator_implant.implant(traitor_mob, null, silent = TRUE)
	if(!silent)
		to_chat(traitor_mob, "<span class='boldnotice'>[employer] has cunningly implanted you with a Syndicate Uplink to assist in your infiltration. Simply trigger the uplink to access it.</span>")
