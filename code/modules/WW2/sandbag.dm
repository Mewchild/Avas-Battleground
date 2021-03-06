// this now inherits from window as its an easy way to give it the same
// multidirectional collision behavior

#define SANDBAG_BLOCK_ITEMS_CHANCE 90

/obj/structure/window/sandbag
	name = "sandbag"
	icon_state = "sandbag"
	layer = MOB_LAYER + 0.01 //just above mobs
	anchored = 1

/obj/structure/window/sandbag/attack_hand(var/mob/user as mob)
	if (alert(user, "Dismantle the sandbag?", "", "Continue", "Stop") == "Continue")
		visible_message("<span class='danger'>[user] starts dismantling the sandbag wall.</span>", "<span class='danger'>You start dismantling the sandbag wall.</span>")
		if (do_after(user, rand(70,80), src))
			visible_message("<span class='danger'>[user] finishes dismantling the sandbag wall.</span>", "<span class='danger'>You finish dismantling the sandbag wall.</span>")
			qdel(src)

/obj/structure/window/sandbag/ex_act(severity)
	switch(severity)
		if(1.0)
			PoolOrNew(/obj/structure/window/sandbag, src.loc)
			PoolOrNew(/obj/structure/window/sandbag, src.loc)
			PoolOrNew(/obj/structure/window/sandbag, src.loc)
			qdel(src)
			return
		if(2.0)
			PoolOrNew(/obj/structure/window/sandbag, src.loc)
			PoolOrNew(/obj/structure/window/sandbag, src.loc)
			qdel(src)
			return
		else
			if (prob(50))
				return ex_act(2.0)
	return

/obj/structure/window/sandbag/New(location, var/mob/creator)
	loc = location
	flags |= ON_BORDER

	if (creator && ismob(creator))
		dir = creator.dir
	else
		var/ndir = creator
		dir = ndir

	set_dir(dir)

	switch (dir)
		if (NORTH)
			layer = MOB_LAYER - 0.01
			pixel_y = 0
		if (SOUTH)
			layer = MOB_LAYER + 0.01
			pixel_y = 0
		if (EAST)
			layer = MOB_LAYER - 0.05
			pixel_x = 0
		if (WEST)
			layer = MOB_LAYER - 0.05
			pixel_x = 0

//incomplete sandbag structures
/obj/structure/window/sandbag/incomplete
	name = "incomplete sandbag"
	icon_state = "sandbag_33%"
	var/progress = 0
	var/maxProgress = 5


/obj/structure/window/sandbag/incomplete/ex_act(severity)
	qdel(src)

/obj/structure/window/sandbag/incomplete/attackby(obj/O as obj, mob/user as mob)
	if (istype(O, /obj/item/weapon/sandbag))
		var/obj/item/weapon/sandbag/sandbag = O
		progress += (sandbag.sand_amount + 1)
		if (progress >= maxProgress/2)
			icon_state = "sandbag_66%"
			if (progress >= maxProgress)
				icon_state = "sandbag"
				new/obj/structure/window/sandbag(loc, dir)
				qdel(src)
		visible_message("<span class='danger'>[user] adds a bag to [src].</span>")
		qdel(O)


/obj/structure/window/sandbag/incomplete/check_cover(obj/item/projectile/P, turf/from)
	var/effectiveness_percentage = min((progress+1)/maxProgress, 100) //10% to 100%
	effectiveness_percentage -= 10
	var/turf/cover = get_turf(src)
	if(!cover)
		return 1
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1
	if (get_turf(P.original) == cover)
		var/chance = 20
		if (ismob(P.original))
			var/mob/M = P.original
			if (M.lying)
				chance += 70				//Lying down lets you catch less bullets
		if(get_dir(loc, from) == dir)	//Flipped tables catch mroe bullets
			chance += 50
		else
			return 1					//But only from one side
		chance *= effectiveness_percentage
		chance /= 100
		if(prob(chance))
			//visible_message("<span class='warning'>[P] hits \the [src]!</span>")
			return 0
	return 1


/obj/structure/window/sandbag/set_dir(direction)
	dir = direction

/obj/structure/window/sandbag/proc/check_cover(obj/item/projectile/P, turf/from)
	var/turf/cover = get_turf(src)
	if(!cover)
		return 1
	if (get_dist(P.starting, loc) <= 1) //Tables won't help you if people are THIS close
		return 1

		/*
	if (get_turf(P.original) == cover)
		var/chance = 20
		if (ismob(P.original))
			var/mob/M = P.original
			if (M.lying)
				chance += 70				//Lying down lets you catch less bullets
		if(get_dir(loc, from) == dir)	//Flipped tables catch mroe bullets
			chance += 50
		else
			return 1					//But only from one side
		if(prob(chance))
			visible_message("<span class='warning'>[P] hits \the [src]!</span>")
			return 0

	return 1
			*/
	var/chance = 70 - (P.penetrating * 3)
	if(prob(chance))
		visible_message("<span class='warning'>[P] hits \the [src]!</span>")
		return 0
	else
		return 1

// sandbag window overrides


/obj/structure/window/sandbag/examine(mob/user)
	user << "That's a sandbag."
	return 1

/obj/structure/window/sandbag/take_damage(var/damage = 0, var/sound_effect = 1)
	return 0

/obj/structure/window/sandbag/apply_silicate(var/amount)
	return 0

/obj/structure/window/sandbag/updateSilicate()
	return 0

/obj/structure/window/sandbag/shatter(var/display_message = 1)
	return 0

/obj/structure/window/sandbag/bullet_act(var/obj/item/projectile/Proj)
	return 0

/obj/structure/window/sandbag/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			qdel(src)
			return
		if(3.0)
			if(prob(50))
				qdel(src)

/obj/structure/window/sandbag/is_full_window()
	return 0

/obj/structure/window/sandbag/proc/is_beyond(var/atom/a)
	if (dir == EAST && x > a.x)
		return 1
	if (dir == WEST && x < a.x)
		return 1
	if (dir == NORTH && y > a.y)
		return 1
	if (dir == SOUTH && y < a.y)
		return 1
	return 0

/obj/structure/window/sandbag/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)

	if (!istype(mover, /obj/item))
		if(get_dir(loc, target) & dir)
			return !density
		else
			return 1
	else
		if (istype(mover, /obj/item/projectile))
			var/obj/item/projectile/proj = mover
			proj.last_throw_source = (proj.firer ? get_turf(proj.firer) : null)

			if (proj.firer && (get_step(proj.firer, proj.firer.dir) == get_turf(src) || proj.firer.loc == get_turf(src)))
				return 1

		if (!mover.last_throw_source)
		//	if (config.debug) world << "[mover] can't pass [src]"
			return 0
		else
		//	if (config.debug)
			//	world << "direction to the sandbag of [mover]: [get_dir(mover.last_throw_source, get_turf(src))]"
			//	world << "direction of src: [dir]"
			switch (get_dir(mover.last_throw_source, get_turf(src)))
				if (NORTH, NORTHEAST)
					if (dir == EAST || dir == WEST || dir == NORTH)
				//		if (config.debug)world << "[mover] can pass [src]"
						return 1
				if (SOUTH, SOUTHEAST)
					if (dir == EAST || dir == WEST || dir == SOUTH)
				//		if (config.debug)world << "[mover] can pass [src]"
						return 1
				if (EAST)
					if (dir != WEST)
				//		if (config.debug)world << "[mover] can pass [src]"
						return 1
				if (WEST)
					if (dir != EAST)
				//		if (config.debug)world << "[mover] can pass [src]"
						return 1

			if (prob(SANDBAG_BLOCK_ITEMS_CHANCE))
			//	if (config.debug)world << "[mover] is blocked by src [src]"
				visible_message("<span class = 'warning'>[mover] hits the sandbag!</span>")
				return 0
			else
		//		if (config.debug)world << "[mover] can pass [src]"
				return 1

/obj/structure/window/sandbag/CheckExit(atom/movable/O as mob|obj, target as turf)
	if(get_dir(O.loc, target) == dir)
		if (ismob(O))
			return 0
	return 1

/obj/structure/window/hitby(AM as mob|obj)
	return 0 // don't move

/obj/structure/window/sandbag/attack_tk(mob/user as mob)
	return 0

/obj/structure/window/sandbag/attack_generic(var/mob/user, var/damage)
	return 0

/obj/structure/window/sandbag/rotate()
	return


/obj/structure/window/sandbag/revrotate()
	return

/obj/structure/window/sandbag/is_fulltile()
	return 0

/obj/structure/window/sandbag/update_verbs()
	verbs -= /obj/structure/window/proc/rotate
	verbs -= /obj/structure/window/proc/revrotate

//merges adjacent full-tile windows into one (blatant ripoff from game/smoothwall.dm)
/obj/structure/window/sandbag/update_icon()
	return

/obj/structure/window/sandbag/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	return

/obj/item/weapon/sandbag
	name = "sandbags"
	icon_state = "sandbag"
	icon = 'icons/obj/items.dmi'
	w_class = 1
	var/sand_amount = 0

/*

/obj/item/weapon/sandbag/attack_self(mob/user as mob)
	if(sand_amount < 4)
		user << "\red You need more sand to make wall."
		return
	for(var/obj/structure/window/sandbag/baggy in src.loc)
		if(baggy.dir == user.dir)
			user << "\red There is no more space."
			return

	var/obj/structure/window/sandbag/bag = new(src.loc)
	bag.set_dir(user.dir)
	user.drop_item()
	qdel(src)
	*/

/obj/item/weapon/sandbag/attackby(obj/O as obj, mob/user as mob)
	if(istype(O, /obj/item/weapon/ore/glass))
		if(sand_amount >= 4)
			user << "\red [name] is full!"
			return
		user.drop_item()
		qdel(O)
		sand_amount++
		w_class++
		update_icon()
		user << "You need [4 - sand_amount] more units."



//obj/item/weapon/ore/glass
