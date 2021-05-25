/datum/disease/hyperthermia
    name = "Hyperthermia"
    max_stages = 3
    spread_text = "None"
    spread_flags = 
    cure_text = "Cryoxadone"
    cures = 
    agent = "Long exposure to hot conditions."
    viable_mobtypes = list(/mob/living/carbon/human)
    cure_chance = 100
    desc = "Sever heat exposure and possible dehydration. Monitoring is required in case of vomiting and sudden collapses. If left untreated and in hot conditions for too long, brain damage may occur."
    severity = DISEASE_SEVERITY_HARMFUL

/datum/disease/brainrot/stage_act(delta_time, times_fired)

