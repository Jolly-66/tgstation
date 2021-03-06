/// -- Modular security clothing. --
/obj/item/clothing/under/rank/security/bridge_officer
	name = "bridge officer uniform"
	desc = "A formal blue suit and tie kitted out with padding for protection worn by the officers that work the bridge. Someone owes you a beer..."
	icon_state = "blueshift"
	inhand_icon_state = "blueshift"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 50, WOUND = 10)
	sensor_mode = SENSOR_COORDS
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/bridge_officer/black
	desc = "A distinguished black suit kitted out with padding for protection worn by the officers that work the bridge."
	icon = 'icons/obj/clothing/under/suits.dmi'
	worn_icon = 'icons/mob/clothing/under/suits.dmi'
	icon_state = "really_black_suit"
	inhand_icon_state = "lawyer_black"

/obj/item/clothing/under/rank/security/bridge_officer/black/skirt //putting this here god fucking forbid it pulls the lawyers black suit
	name = "bridge officer black suitskirt"
	desc = "A distinguished black suit kitted out with padding for protection worn by the officers that work the bridge."
	icon_state = "really_black_suit_skirt"
	inhand_icon_state = "lawyer_black"
	dying_key = DYE_REGISTRY_JUMPSKIRT
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
