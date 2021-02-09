//Skyrat SS13 code adapted for Jollystation, originally written by Azarak and coauthored by Gandalf2k15.
/datum/mind
		var/datum/ambitions/my_ambitions

/datum/mind/proc/ambition_submit()
	for(var/datum/antagonist/A in antag_datums)
		if(A.uses_ambitions)
			A.ambitions_add()
