/client/proc/send_german_train()
	set category = "WW2"
	set name = "Send train (German)"

	var/direction = input("Make the train go forwards, backwards, or stop?") in list("Forwards", "Backwards", "Stop", "Cancel")

	if (!direction || direction == "Cancel")
		return

	for (var/obj/train_lever/german/lever in world)
		if (istype(lever))
			lever.automatic_function(direction, src)
			break

	if (direction == "Forwards")
		direction = "to the FOB"

	else if (direction == "Backwards")
		direction = "back to the base"

	else if (direction == "Stop")
		message_admins("[src]/[mob] tried to stop the german train.")
		return

	message_admins("[src]/[mob] tried to send the german train [direction].")

/client/proc/allow_join_geforce()
	set category = "WW2"
	set name = "Toggle joining (German)"

	ticker.can_latejoin_geforce = !ticker.can_latejoin_geforce
	world << "<font color=red>You [(ticker.can_latejoin_geforce) ? "can" : "can't"] join the Germans [(ticker.can_latejoin_geforce) ? "now" : "anymore"].</font>"
	message_admins("[src]/[mob] changed the geforce latejoin setting.")

/client/proc/allow_join_ruforce()
	set category = "WW2"
	set name = "Toggle joining (Russian)"

	ticker.can_latejoin_ruforce = !ticker.can_latejoin_ruforce
	world << "<font color=red>You [(ticker.can_latejoin_ruforce) ? "can" : "can't"] join the Russians [(ticker.can_latejoin_ruforce) ? "now" : "anymore"].</font>"
	message_admins("[src]/[mob] changed the ruforce latejoin setting.")

/client/proc/allow_rjoin_geforce()
	set category = "WW2"
	set name = "Toggle reinforcements (German)"

	if (reinforcements_master)
		reinforcements_master.locked["GERMAN"] = !reinforcements_master.locked["GERMAN"]
		world << "<font color=red>Reinforcements [(!reinforcements_master.locked["GERMAN"]) ? "can" : "can't"] join the Germans [(!reinforcements_master.locked["GERMAN"]) ? "now" : "anymore"].</font>"
		message_admins("[src]/[mob] changed the geforce reinforcements setting.")
	else
		src << "<span class = danger>WARNING: No reinforcements master found.</span>"

/client/proc/allow_rjoin_ruforce()
	set category = "WW2"
	set name = "Toggle reinforcements (Russian)"

	if (reinforcements_master)
		reinforcements_master.locked["RUSSIAN"] = !reinforcements_master.locked["RUSSIAN"]
		world << "<font color=red>Reinforcements [(!reinforcements_master.locked["RUSSIAN"]) ? "can" : "can't"] join the Russians [(!reinforcements_master.locked["RUSSIAN"]) ? "now" : "anymore"].</font>"
		message_admins("[src]/[mob] changed the ruforce reinforcements setting.")
	else
		src << "<span class = danger>WARNING: No reinforcements master found.</span>"


/client/proc/force_reinforcements_geforce()
	set category = "WW2"
	set name = "Quickspawn reinforcements (German)"

	var/list/l = reinforcements_master.reinforcement_pool["GERMAN"]

	if (reinforcements_master)
		if (l.len)
			reinforcements_master.allow_quickspawn["GERMAN"] = 1
			reinforcements_master.german_countdown = 0
			message_admins("[src]/[mob] tried to send reinforcements for the Germans.")
		else
			src << "<span class = danger>Nobody is in the German reinforcement pool.</span>"
	else
		src << "<span class = danger>WARNING: No reinforcements master found.</span>"

/client/proc/force_reinforcements_ruforce()
	set category = "WW2"
	set name = "Quickspawn reinforcements (Russian)"

	var/list/l = reinforcements_master.reinforcement_pool["RUSSIAN"]

	if (reinforcements_master)
		if (l.len)
			reinforcements_master.allow_quickspawn["RUSSIAN"] = 1
			reinforcements_master.russian_countdown = 0
			message_admins("[src]/[mob] tried to send reinforcements for the Russians.")
		else
			src << "<span class = danger>Nobody is in the Russian reinforcement pool.</span>"
	else
		src << "<span class = danger>WARNING: No reinforcements master found.</span>"

/client/proc/toggle_autobalance()
	set category = "WW2"
	set name = "Toggle autobalance"

	job_master.autobalance = !job_master.autobalance
	world << "<font size=3>Autobalance is now [(job_master.autobalance) ? "enabled" : "disabled"].</font>"
	message_admins("[src]/[mob] changed the autobalance settings.")

/client/proc/show_battle_report()
	set category = "WW2"
	set name = "Show battle report"

	var/alive_en = 0
	var/alive_ru = 0
//	var/alive_civ = 0

	var/heavily_injured_en = 0
	var/heavily_injured_ru = 0
//	var/heavily_injured_civ = 0

	for(var/mob/living/carbon/human/H in human_mob_list)
		if(H.stat == DEAD)
			continue
		var/datum/job/job = H.original_job
		if(!job)
			usr << "\red [H] have no job!"
			continue
		switch(job.department_flag)
			if(GEFORCE)
				alive_en++
			if(RUFORCE)
				alive_ru++
		//	if(CIVILIAN)
			//	alive_civ++

		if(H.health > 0)
			continue

		switch(job.department_flag)
			if(GEFORCE)
				heavily_injured_en++
			if(RUFORCE)
				heavily_injured_ru++
		//	if(CIVILIAN)
		//		heavily_injured_civ++


	usr << "German Side: [alive_en] alive and [heavily_injured_en] heavily injured."
	usr << "Russian Side: [alive_ru] alive and [heavily_injured_ru] heavily injured."
//	usr << "Civilians: [alive_civ] alive and [heavily_injured_civ] heavily injured."

	var/public = alert(usr, "Show it to public?",,"Yes", "No")

	if(public == "Yes")
		world << "<font size=4>Battle status report:</font>"
		world << "<font size=3>German Side: [alive_en] alive and [heavily_injured_en] heavily injured.</font>"
		world << "<font size=3>Russian Side: [alive_ru] alive and [heavily_injured_ru] heavily injured.</font>"
	//	world << "<font size=3>Civilians: [alive_civ] alive and [heavily_injured_civ] heavily injured.</font>"
		message_admins("[src] showed everyone the battle report.")

/client/proc/generate_hit_table()
	set category = "WW2"
	set name = "Hit tables"
	set background = 1

	var/list/types = typesof(/obj/item/weapon/gun/projectile)

	var/gun_type = input(usr, "Select gun type", "Hit tables") as null|anything in types
	if(!gun_type)
		return

	var/obj/item/weapon/gun/projectile/gun = new gun_type()
	var/mob/living/carbon/human/dummy = new()

	usr << "Generating hit table..."
	var/list/distances = list(3, 5, 7, 9)
	var/dat = "<h3>Generated hit table for [gun.name]. Target: chest.</h3><b>Simulated!</b><br>"
	//Wielded
	if(gun.can_wield)
		dat += "<h4>----Wielded----</h4>"
		dat += "<table><tr><td>Distance</td>"
		for(var/dist in distances)
			dat += "<td>[dist] tiles</td>"
		dat += "</tr>"
		for(var/datum/firemode/fm in gun.firemodes)
			dat += "<tr><td>[fm.name]</td>"
			for(var/dist in distances)
				var/text = ""
				for(var/i = 1 to min(fm.burst, 5))
					var/acc = fm.accuracy[min(i, fm.accuracy.len)] + gun.accuracy
					var/miss_mod = min(max(15 * (dist - 2) - round( 15 * acc), 0), 100)
					var/hits = 0
					for(var/shot = 1 to 1000)
						if(get_zone_with_miss_chance("chest", dummy, miss_mod, 1) != null)
							hits++
					if(hits <= 0)
						text += "0"
					else
						text += "[round(hits / 10)]"
					if(i != min(fm.burst, 5))
						text += "/"
					else
						text += "%"
				dat += "<td>[text]</td>"
			dat += "</tr>"
		dat += "</table>"
	//Unwielded
	if((gun.can_wield && !gun.must_wield) || !gun.can_wield)
		dat += "<h4>----Unwielded----</h4>"
		dat += "<table><tr><td>Distance</td>"
		for(var/dist in distances)
			dat += "<td>[dist] tiles</td>"
		dat += "</tr>"
		for(var/datum/firemode/fm in gun.firemodes)
			dat += "<tr><td>[fm.name]</td>"
			for(var/dist in distances)
				var/text = ""
				for(var/i = 1 to min(fm.burst, 5))
					var/acc = fm.accuracy[min(i, fm.accuracy.len)] + gun.accuracy - 2
					var/miss_mod = min(max(15 * (dist - 2) - round( 15 * acc), 0), 100)
					var/hits = 0
					for(var/shot = 1 to 1000)
						if(get_zone_with_miss_chance("chest", dummy, miss_mod, 1) != null)
							hits++
					if(hits <= 0)
						text += "0"
					else
						text += "[round(hits / 10)]"
					if(i != min(fm.burst, 5))
						text += "/"
					else
						text += "%"
				dat += "<td>[text]</td>"
			dat += "</tr>"
		dat += "</table>"
	if(gun.can_scope)
		dat += "<h4>----Scoped----</h4>"
		dat += "<table><tr><td>Distance</td>"
		for(var/dist in distances)
			dat += "<td>[dist] tiles</td>"
		dat += "</tr>"
		for(var/datum/firemode/fm in gun.firemodes)
			dat += "<tr><td>[fm.name]</td>"
			for(var/dist in distances)
				var/text = ""
				for(var/i = 1 to min(fm.burst, 5))
					var/acc = fm.accuracy[min(i, fm.accuracy.len)] + gun.scoped_accuracy
					var/miss_mod = min(max(15 * (dist - 2) - round( 15 * acc), 0), 100)
					var/hits = 0
					for(var/shot = 1 to 1000)
						if(get_zone_with_miss_chance("chest", dummy, miss_mod, 1) != null)
							hits++
					if(hits <= 0)
						text += "0"
					else
						text += "[round(hits / 10)]"
					if(i != min(fm.burst, 5))
						text += "/"
					else
						text += "%"
				dat += "<td>[text]</td>"
			dat += "</tr>"
		dat += "</table>"

	usr << browse(dat, "window='Hit table';size=800x400;can_close=1;can_resize=1;can_minimize=1;titlebar=1")

/*
/client/proc/set_daytime()
	set category = "Prishtina"
	set name = "Set daytime"

	var/list/modes = list("Brighty day" = "#FFFFFF", "Cloudy day" = "#999999", "Very cloudy day" = "#777777", "Sunset" = "#FFC966", "Bright night" = "#444444", "Dark night" = "#111111", "Sunrise" = "#DEDF64", "Special" = "#FF77FF")

	var/daytime = input(usr, "Select daytime", "Daytime changing.") as null|anything in modes

	if(!daytime)
		return

	var/color = modes[daytime]
	config.starlight_color = color

	world << "Changing daytime and weather to [daytime]. This may take a while. Be patient."
	spawn(10)
		for (var/area/prishtina/a_p in world)
			if (istype(a_p, /area/prishtina))
				a_p.changeDayTime(dayime)*/
	/*	for(var/turf/T)
			if(T.z == 1)
				T.update_starlight()*/

/client/proc/message_russians()
	set category = "WW2"
	set name = "Message Russians"

	var/msg = input(usr, "Send what?", "Message Russians") as text

	var/ick_ock = input(usr, "Make this an IC message?", "Message Russians") in list("Yes", "No")
	if (ick_ock == "Yes")
		ick_ock = 1
	else
		ick_ock = 0

	if (msg)
		for (var/mob/living/carbon/human/H in player_list)
			if (istype(H) && H.client)
				if (H.original_job && H.original_job.team == "RUSSIAN")
					var/msg_start = ick_ock ? "<b>IMPORTANT MESSAGE FROM THE KREMLIN:</b>" : "<b>MESSAGE TO THE RUSSIAN TEAM FROM ADMINS:</b>"
					var/msg_end = ick_ock ? "<i> - Stalin</i>" : ""
					H << "[msg_start] <span class = 'notice'>[msg]</span>[msg_end]"

		src << "You sent '[msg]' to the Russian team."
		message_admins("[src]/[mob] sent '[msg]' to the Russian team.")

/client/proc/message_germans()
	set category = "WW2"
	set name = "Message Germans"

	var/msg = input(usr, "Send what?", "Message Germans") as text

	var/ick_ock = input(usr, "Make this an IC message?", "Message Germans") in list("Yes", "No")

	if (ick_ock == "Yes")
		ick_ock = 1
	else
		ick_ock = 0

	if (msg)
		for (var/mob/living/carbon/human/H in player_list)
			if (istype(H) && H.client)
				if (H.original_job && H.original_job.team == "GERMAN")
					var/msg_start = ick_ock ? "<b>IMPORTANT MESSAGE FROM DIE REICHSTAG:</b>" : "<b>MESSAGE TO THE GERMAN TEAM FROM ADMINS:</b>"
					var/msg_end = ick_ock ? "<i> - Adolf Hitler</i>" : ""
					H << "[msg_start] <span class = 'notice'>[msg]</span>[msg_end]"

		src << "You sent '[msg]' to the German team."
		message_admins("[src]/[mob] sent '[msg]' to the German team.")

/client/proc/message_SS()
	set category = "WW2"
	set name = "Message the S.S."

	var/msg = input(usr, "Send what?", "Message the S.S.") as text

	var/ick_ock = input(usr, "Make this an IC message?", "Message the S.S.") in list("Yes", "No")

	if (ick_ock == "Yes")
		ick_ock = 1
	else
		ick_ock = 0

	if (msg)
		for (var/mob/living/carbon/human/H in player_list)
			if (istype(H) && H.client)
				if (H.original_job && H.original_job.team == "GERMAN" && H.original_job.is_SS)
					var/msg_start = ick_ock ? "<b>IMPORTANT MESSAGE FROM DIE REICHSTAG TO THE S.S. :</b>" : "<b>MESSAGE TO THE S.S. FROM ADMINS:</b>"
					var/msg_end = ick_ock ? "<i> - Adolf Hitler</i>" : ""
					H << "[msg_start] <span class = 'notice'>[msg]</span>[msg_end]"

		src << "You sent '[msg]' to the S.S."
		message_admins("[src]/[mob] sent '[msg]' to the S.S.")