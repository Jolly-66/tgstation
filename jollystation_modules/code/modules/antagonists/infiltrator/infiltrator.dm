/// -- Infiltrator antag. Advanced traitors but they get some nukops gear in their uplink. --
/datum/antagonist/traitor/traitor_plus/intiltrator
	name = "Infiltrator"
	hijack_speed = 1
	advanced_antag_path = /datum/advanced_antag_datum/traitor/infiltrator
	antag_hud_type = ANTAG_HUD_OPS
	antag_hud_name = "synd"

/datum/antagonist/traitor/traitor_plus/intiltrator/apply_innate_effects(mob/living/mob_override)
	var/mob/living/living_antag = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, living_antag)
	living_antag.faction |= ROLE_SYNDICATE

/datum/antagonist/traitor/traitor_plus/intiltrator/remove_innate_effects(mob/living/mob_override)
	var/mob/living/living_antag = mob_override || owner.current
	remove_antag_hud(antag_hud_type, living_antag)
	living_antag.faction -= ROLE_SYNDICATE

/datum/antagonist/traitor/traitor_plus/intiltrator/on_removal()
	var/obj/item/implant/uplink/infiltrator/infiltrator_implant = locate() in owner.current
	var/obj/item/implant/weapons_auth/weapons_implant = locate() in owner.current
	if(infiltrator_implant)
		to_chat(owner.current, "<span class='danger'>You hear a whirring in your ear as your [infiltrator_implant.name] deactivates and becomes non-functional!</span>")
		qdel(infiltrator_implant)
	if(weapons_implant)
		to_chat(owner.current, "<span class='danger'>You hear a click in your [prob(50) ? "right" : "left"] arm as your [weapons_implant.name] deactivates and becomes non-functional!</span>")
		qdel(weapons_implant)
	. = ..()

/datum/antagonist/traitor/traitor_plus/intiltrator/roundend_report()
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

/datum/antagonist/traitor/traitor_plus/intiltrator/roundend_report_footer()
	return "<br>And thus ends another attempted Syndicate infiltration on board [station_name()]."

/datum/antagonist/traitor/traitor_plus/intiltrator/equip(silent = FALSE)
	var/mob/living/carbon/human/traitor_mob = owner.current
	if (!istype(traitor_mob))
		return

	var/obj/item/implant/uplink/infiltrator/infiltrator_implant = new(traitor_mob)
	var/obj/item/implant/weapons_auth/weapons_implant = new(traitor_mob)
	infiltrator_implant.implant(traitor_mob, traitor_mob, TRUE)
	weapons_implant.implant(traitor_mob, traitor_mob, TRUE)
	if(!silent)
		to_chat(traitor_mob, "<span class='boldnotice'>[employer] has cunningly implanted you with an [infiltrator_implant] to assist in your infiltration. You can trigger the uplink to stealthily access it.</span>")
		to_chat(traitor_mob, "<span class='boldnotice'>[employer] has wisely implanted you with a [weapons_implant] to allow you to use syndicate weaponry. You can now fire weapons with Syndicate firing pins.</span>")

/// infiltrator uplink implant.
/obj/item/implant/uplink/infiltrator
	name = "infiltrator uplink implant"
	uplink_type = UPLINK_INFILTRATOR
