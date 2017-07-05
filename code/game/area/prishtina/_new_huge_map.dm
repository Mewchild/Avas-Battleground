// uses /area/prishtina/field

// "wormhole" areas: doesn't include trains since they don't get their area copied

// where all this stuff is

/area/prishtina/void
	icon_state = "dark"
	name = "the void"

/area/prishtina/void/german
	icon_state = "red2"
	name = "what the fuck is this"

/area/prishtina/void/german/ss_train
	icon_state = "red2"
	name = "Waffen-S.S. Train"

/area/prishtina/void/german/ss_train/entrance
	icon_state = "red2"
	name = "S.S. Train Entrance Room"

/area/prishtina/void/german/ss_train/command
	icon_state = "blue2"
	name = "S.S. Train Command Room"

/area/prishtina/void/german/ss_train/command/office
	icon_state = "blue-red2"
	name = "S.S. Train Command Office"

/area/prishtina/void/german/ss_train/prison
	icon_state = "blue-red"
	name = "S.S. Train Prison"

/area/prishtina/void/german/ss_train/prison/cell1
	icon_state = "blue-red-d"
	name = "S.S. Train Prison Cell #1"

/area/prishtina/void/german/ss_train/prison/cell2
	icon_state = "purple"
	name = "S.S. Train Prison Cell #2"

/area/prishtina/void/german/ss_train/prison/cell3
	icon_state = "red2"
	name = "S.S. Train Prison Cell #3"

/area/prishtina/void/german/ss_train/prison/cell4
	icon_state = "blue2"
	name = "S.S. Train Prison Cell #4"

/area/prishtina/void/german/ss_train/gas_chamber
	icon_state = "blue-red2"
	name = "S.S. Train Gas Chamber"

// end of wormhole areas

// no man's land

/area/prishtina/no_mans_land
	dynamic_lighting = 0

// german areas

/area/prishtina/german

/area/prishtina/german/main_area
	name = "German Base"
	icon_state = "red2"
	dynamic_lighting = 0

/area/prishtina/german/train_zone
	name = "Train Zone"
	icon_state = "blue2"

/area/prishtina/german/train_starting_zone
	icon_state = "blue-red2"
	name = "Train Boarding"
	dynamic_lighting = 0

/area/prishtina/german/train_landing_zone
	icon_state = "blue-red"
	name = "Train Unboarding"
	dynamic_lighting = 0

/area/prishtina/german/resting_area_1
	name = "Resting Area #1"
	icon_state = "blue-red-d"

/area/prishtina/german/resting_area_2
	name = "Resting Area #2"
	icon_state = "purple"

/area/prishtina/german/resting_area_3
	name = "Resting Area #3"
	icon_state = "red2"

/area/prishtina/german/resting_area_4
	name = "Resting Area #4"
	icon_state = "blue2"

/area/prishtina/german/cargo
	name = "Cargo"
	icon_state = "blue-red2"

/area/prishtina/german/armory
	name = "Armory"
	icon_state = "blue-red"

/area/prishtina/german/cafeteria
	name = "Cafeteria"
	icon_state = "blue-red-d"

/area/prishtina/german/kitchen
	name = "Kitchen"
	icon_state = "purple"

// because the german showers and drying rooms are disconnected, giving them the same color
 // - Kachnov

/area/prishtina/german/shower1
	name = "Showers #1"
	icon_state = "red2"
	dynamic_lighting = 0

/area/prishtina/german/shower2
	name = "Showers #2"
	icon_state = "red2"
	dynamic_lighting = 0

/area/prishtina/german/shower3
	name = "Showers #3"
	icon_state = "red2"
	dynamic_lighting = 0

/area/prishtina/german/drying1
	name = "Drying Room #1"
	icon_state = "blue2"
	dynamic_lighting = 0

/area/prishtina/german/drying2
	name = "Drying Room #2"
	icon_state = "blue2"
	dynamic_lighting = 0

/area/prishtina/german/drying3
	name = "Drying Room #3"
	icon_state = "blue2"
	dynamic_lighting = 0

/area/prishtina/german/ss_torture_room
	name = "S.S. Interrogation Room" // "Interrogation"
	icon_state = "blue-red2"

/area/prishtina/german/ss_torture_room/tools
	name = "S.S. Interrogation Room Tools"
	icon_state = "blue-red"

/area/prishtina/german/ss_torture_room/cell1
	name = "S.S. Interrogation Room Cell #1"
	icon_state = "blue-red-d"

/area/prishtina/german/ss_torture_room/cell2
	name = "S.S. Interrogation Room Cell #2"
	icon_state = "purple"

/area/prishtina/german/command
	name = "Command"
	icon_state = "purple"

/area/prishtina/german/command/office
	name = "Feldwebel's Office"
	icon_state = "blue-red-d"

/area/prishtina/german/briefing
	name = "Briefing"
	icon_state = "red2"
	dynamic_lighting = 0

/area/prishtina/german/base_defenses
	name = "Base Defenses"
	icon_state = "blue2"
	dynamic_lighting = 0

/area/prishtina/german/engineering
	name = "Engineering"
	icon_state = "blue-red"

/area/prishtina/german/janitor
	name = "Janitor's Closet"
	icon_state = "blue-red2"

/area/prishtina/german/medical
	name = "Medical Area"
	icon_state = "blue-red2"

// soviet areas

/area/prishtina/soviet
	name = "soviet"

/area/prishtina/soviet/bunker_entrance
	name = "Bunker Entrance"
	icon_state = "red2"

/area/prishtina/soviet/immediate_outside_defenses
	name = "Bunker Defenses"
	icon_state = "blue2"
	dynamic_lighting = 0

/area/prishtina/soviet/forward_defenses
	name = "Bunker Defenses"
	icon_state = "blue-red2"
	dynamic_lighting = 0
// bunker areas

/area/prishtina/soviet/bunker
	name = "soviet bunker"

/area/prishtina/soviet/bunker/tunnel
	icon_state = "purple"
	name = "soviet bunker"

/area/prishtina/soviet/bunker/entrance
	icon_state = "red2"
	name = "entrance"

/area/prishtina/soviet/bunker/main_hallway
	icon_state = "blue2"
	name = "main hallway"

/area/prishtina/soviet/bunker/briefing
	icon_state = "blue-red2"
	name = "briefing"

/area/prishtina/soviet/bunker/cargo
	icon_state = "blue-red"
	name = "cargo"

/area/prishtina/soviet/bunker/engineering
	icon_state = "blue-red-d"
	name = "engineering"

/area/prishtina/soviet/bunker/medical
	icon_state = "green"
	name = "medical area"

/area/prishtina/soviet/bunker/janitor
	icon_state = "purple"
	name = "janitor's closet"

/area/prishtina/soviet/bunker/command
	icon_state = "red2"
	name = "command"

/area/prishtina/soviet/bunker/command/office
	icon_state = "blue2"
	name = "Commandir's Office"

/area/prishtina/soviet/bunker/armory
	icon_state = "blue-red2"
	name = "Armory"

/area/prishtina/soviet/bunker/showers
	icon_state = "blue-red"
	name = "Showers"

/area/prishtina/soviet/bunker/cafeteria
	icon_state = "blue-red-d"
	name = "Cafeteria"

/area/prishtina/soviet/bunker/kitchen
	icon_state = "green"
	name = "Kitchen"

/area/prishtina/soviet/bunker/resting_area
	icon_state = "purple"
	name = "Resting Area"

/area/prishtina/soviet/bunker/brig
	icon_state = "red2"
	name = "Brig"

/area/prishtina/soviet/bunker/brig/cell1
	icon_state = "blue2"
	name = "Brig Cell #1"

/area/prishtina/soviet/bunker/brig/cell2
	icon_state = "blue-red2"
	name = "Brig Cell #2"

