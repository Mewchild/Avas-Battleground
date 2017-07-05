/datum/reagent/proc/mask_check(var/mob/living/carbon/human/m)
	if (m && istype(m))
		if (m.wear_mask && istype(m.wear_mask, /obj/item/clothing/mask/gas))
			var/obj/item/clothing/mask/gas/mask = m.wear_mask
			if (mask.check_can_block(src))
				return TRUE
	return FALSE

/datum/reagent/proc/eye_damage(var/mob/living/carbon/human/m, var/severity = 1) // damage eyes
	if (mask_check(m)) return
	if (m && istype(m) && severity)
		var/base = rand(2,3)
		if (base > 2)
			m << "<span class = 'danger'>The gas burns your eyes!</span>"
			m.emote("scream")
			m.adjustFireLossByPart(base, "eyes")
			m.Weaken(rand(2,3))
			m.eye_blurry = max(m.eye_blurry+2, 0)

/datum/reagent/proc/external_damage(var/mob/living/carbon/human/m, var/severity = 1) // damage skin
	if (m && istype(m) && severity)
		var/base = rand(3,5)
		if (base > 2)
			m << "<span class = 'danger'>The gas burns your skin!</span>"
			if (prob(50))
				m.emote("scream")
			m.adjustFireLoss(base)
			if (prob(50))
				m.Weaken(rand(4,5))

/datum/reagent/proc/internal_damage(var/mob/living/carbon/human/m, var/severity = 1) // damage things like lungs
	if (mask_check(m)) return
	if (m && istype(m) && severity)
		var/base = rand(7,10)
		if (base > 2)
			m << "<span class = 'danger'>The gas burns your lungs!</span>"
			m.emote("scream")
			m.adjustFireLossByPart(base, "chest")
			if (prob(70))
				m.Weaken(rand(3,4))

/datum/reagent/proc/open_wound_damage(var/mob/living/carbon/human/m, var/severity = 1) // damage wounded skin
	if (m && istype(m) && severity)
		var/base = (m.getBruteLoss() + m.getFireLoss())/10
		base += rand(3,5)
		if (base > 2)
			m << "<span class = 'danger'>The gas burns the open wounds on your skin!</span>"
			if (prob(50))
				m.emote("scream")
			m.adjustFireLoss(base)
			if (prob(50))
				m.Weaken(rand(4,5))

/proc/get_severity(var/amount)
	switch (amount)
		if (0)
			return 0
		if (1 to 5)
			return 1
		if (6 to 10)
			return 2
		if (11 to INFINITY)
			return 3
//blue cross
/datum/reagent/toxin/xylyl_bromide
	name = "Xylyl Bromide"
	id = "xylyl_bromide"
	description = "A deadly gas." // todo: better description - Kachnov
	taste_mult = 1.5
	reagent_state = GAS
	color = "#ffd700"
	strength = 30
	touch_met = 5
	alpha = 51
//	meltdose = 4

/datum/reagent/toxin/xylyl_bromide/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		eye_damage(L, get_severity(amount))
		external_damage(L, get_severity(amount))

//yellow cross
/datum/reagent/toxin/mustard_gas
	name = "Mustard Gas"
	id = "mustard_gas"
	description = "A deadly gas." // todo: better description - Kachnov
	reagent_state = GAS
	color = "#A2CD5A"
	strength = 30
	touch_met = 5
//	meltdose = 4

/datum/reagent/toxin/mustard_gas/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		eye_damage(L, get_severity(amount)*2)
		external_damage(L, get_severity(amount)*2)
		internal_damage(L, get_severity(amount)*2)

/datum/reagent/toxin/mustard_gas/white_phosphorus
	name = "White Phosphorus Gas"
	id = "white_phosphorus_gas"
	description = "A deadly gas." // todo: better description - Kachnov
	reagent_state = GAS
	color = "#FFFFFF"
	strength = 30
	touch_met = 5
//	meltdose = 4

/datum/reagent/toxin/white_phosphorus/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		eye_damage(L, get_severity(amount)*2)
		external_damage(L, get_severity(amount)*2)
		internal_damage(L, get_severity(amount)*2)
//green cross
/datum/reagent/toxin/chlorine_gas
	name = "Chlorine Gas"
	id = "chlorine_gas"
	description = "A deadly gas." // todo: better description - Kachnov
	reagent_state = GAS
	color = "#ffd700"
	strength = 30
	touch_met = 5
	alpha = 128
//	meltdose = 4


/datum/reagent/toxin/chlorine_gas/touch_mob(var/mob/living/L, var/amount)
	if(istype(L))
		eye_damage(L, get_severity(amount))
		external_damage(L, get_severity(amount)*2)
		open_wound_damage(L, get_severity(amount)*2)