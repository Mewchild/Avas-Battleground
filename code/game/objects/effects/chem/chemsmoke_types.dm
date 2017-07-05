/obj/effect/effect/smoke/chem/payload
	last_duration = 200
	random_destination = 1

	New()
		..()

		for (var/datum/reagent/r in reagents.reagent_list)
			src.color = r.color
			src.alpha = r.alpha

/obj/effect/effect/smoke/chem/payload/chlorine_gas
	reagent_id = "chlorine_gas"

/obj/effect/effect/smoke/chem/payload/mustard_gas
	reagent_id = "mustard_gas"

/obj/effect/effect/smoke/chem/payload/white_phosphorus_gas
	reagent_id = "white_phosphorus_gas"

/obj/effect/effect/smoke/chem/payload/xylyl_bromide
	reagent_id = "xylyl_bromide"