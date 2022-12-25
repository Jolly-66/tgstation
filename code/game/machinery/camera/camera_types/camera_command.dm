/obj/machinery/camera/command
	name = "command camera"
	// Generic c_tag in case this gets used, doesn't hurt to have it set
	c_tag = "Command-Area Monitoring Camera"
	// Network isn't initially listed here since each camera is "public" + the department, plus the parent list is public

// Head offices
/obj/machinery/camera/command/cmo
	c_tag = "Chief Medical Officer's Office"
	network = list("public", "medbay")

/obj/machinery/camera/command/hop
	c_tag = "Head of Personnel's Office"
	network = list("public", "service")

/obj/machinery/camera/command/hos
	c_tag = "Head of Security's Office"
	network = list("public", "security")

/obj/machinery/camera/command/qm
	c_tag = "Quartermaster's Office"
	network = list("public", "cargo")

/obj/machinery/camera/command/rd
	c_tag = "Research Directors Office"
	network = list("public", "research")

// Generic command areas
/obj/machinery/camera/command/eva
	c_tag = "E.V.A Storage"

/obj/machinery/camera/command/gateway_access
	c_tag = "Gateway - Access"

/obj/machinery/camera/command/gateway_atirum
	c_tag = "Gateway - Atirum"

/obj/machinery/camera/command/showroom
	c_tag = "Showroom"

/obj/machinery/camera/command/teleporter_command
	c_tag = "Teleporter Room - Command"

// Ai specific arreas
/obj/machinery/camera/command/ai_chamber
	c_tag = "AI Chamber"
	network = list("aicore")

/obj/machinery/camera/command/ai_upload
	c_tag = "AI Upload Chamber"
	network = list("aiupload")

/obj/machinery/camera/command/ai_minisat_antechamber
	c_tag = "MiniSat - Antechamber"
	network = list("minisat")

/obj/machinery/camera/command/ai_minisat_exterior
	c_tag = "MiniSat Exterior"
	network = list("minisat")

/obj/machinery/camera/command/ai_minisat_foyer
	c_tag = "MiniSat - Foyer"
	network = list("minisat")
