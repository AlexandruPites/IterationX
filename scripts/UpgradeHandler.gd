extends Node2D
class_name UpgradeHandler

const MAX_LEVEL : int = 9
const AUGMENT_MAX_LEVEL : int = 5

const max_nr_weapons : int = 6
const max_nr_augments : int = 6

var nr_weapons : int = 0
var nr_augments : int = 0

var inventory : Dictionary = {}
var augments : Dictionary = {}
var weapon_levels : Dictionary = {}
var augment_levels : Dictionary = {}

@onready var player: Player = $"../Player"
@onready var weapons_list: InventoryUI = %WeaponList
@onready var augment_list: InventoryUI = %AugmentList

var game : Node

func _ready() -> void:
	game = get_node("/root/Game")
	var file : FileAccess = FileAccess.open("res://text_files/unlocked_upgrades.txt", FileAccess.READ)
	var levels : Dictionary = {}
	levels = weapon_levels
	while !file.eof_reached():
		var line : String = file.get_line()
		if line != "" and line != "::augments::":
			levels[line] = 0
		if line == "::augments::":
			levels = augment_levels
	file.close()
	
	# DO NOT EVER DO THIS, THIS IS SO BAD
	# incomplete representation but it works
	var bullshitImplementation : RandomItem = RandomItem.new()
	bullshitImplementation.item_name = 'shotgun'
	# this could very well break in the future
	# call deferred is very important, otherwise it gets added before ui is _ready
	update_weapon_level.call_deferred(bullshitImplementation)
			
func update_weapon_level(changedItem : RandomItem) -> void:
	if weapon_levels[changedItem.item_name] == 0:
		add_weapon(changedItem.item_name)
	else:
		weapon_levels[changedItem.item_name] += 1
		var handler : Node = inventory[changedItem.item_name].handler
		handler.update_stats(weapon_levels[changedItem.item_name])
	print(weapon_levels)
	
func update_augment_level(changedItem : RandomItem) -> void:
	if augment_levels[changedItem.item_name] == 0:
		add_augment(changedItem.item_name)
	else:
		augment_levels[changedItem.item_name] += 1
		var handler : Node = augments[changedItem.item_name]
		handler.update_stats(augment_levels[changedItem.item_name])
	player.modifiers.update_property(augments[changedItem.item_name])
	player.calc_stats()
	for i : String in inventory:
		var elm : ProjectileReference = inventory[i]
		if is_instance_valid(elm.handler):
			elm.handler.modifiers.update_property(augments[changedItem.item_name])
			elm.handler.calc_stats()
	print(augment_levels)
	
	
func add_weapon(weapon_name : String) -> void:
	nr_weapons += 1
	weapon_levels[weapon_name] = 1
	var format_string : String = "res://scenes/weapons/%s/%s_handler.tscn"
	var resource : Resource = load(format_string % [weapon_name, weapon_name])
	var instance : Node = resource.instantiate()
	instance.player = player
	
	var temp : ProjectileReference = ProjectileReference.new()
	temp.resource = resource
	temp.weapon_name = weapon_name
	temp.handler = instance
	inventory[weapon_name] = temp
	weapons_list.add_item(weapon_name, true)
	add_child(temp.handler)
	
func add_augment(augment_name : String) -> void:
	nr_augments += 1
	augment_levels[augment_name] = 1
	var format_string : String = "res://scenes/augments/%s.tscn"
	var resource : Resource = load(format_string % augment_name)
	var instance : Augment = resource.instantiate()
	augments[augment_name] = instance
	augment_list.add_item(augment_name, false)
	add_child(instance)
	
func choose_level_ups() -> Array[RandomItem]:
	var choices : Array[RandomItem] = []
	var copy_dict : Dictionary = {}
	
	for elem : String in weapon_levels.keys():
		if weapon_levels[elem] < MAX_LEVEL:
			if not (weapon_levels[elem] == 0 and nr_weapons >= max_nr_weapons):
				copy_dict[elem] = weapon_levels[elem]
			
	for elem : String in augment_levels.keys():
		if elem in augments:
			if augment_levels[elem] < augments[elem].max_level:
				if not (augment_levels[elem] == 0 and nr_augments >= max_nr_augments):
					copy_dict[elem] = augment_levels[elem]
		else:
			if augment_levels[elem] < AUGMENT_MAX_LEVEL:
				if not (augment_levels[elem] == 0 and nr_augments >= max_nr_augments):
					copy_dict[elem] = augment_levels[elem]
			
	for i in range(3):
		if copy_dict.keys().size() > 0:
			var chosen : String = copy_dict.keys().pick_random()
			var random : RandomItem = RandomItem.new()
			random.item_name = chosen
			
			if chosen in weapon_levels.keys():
				random.is_weapon = true
				random.level_up_text = "Weapon\n+1 level\n" + chosen + "\nCurrent level: " + str(weapon_levels[chosen])
			else:
				random.is_weapon = false
				random.level_up_text = "Augment\n+1 level\n" + chosen + "\nCurrent level: " + str(augment_levels[chosen])
			choices.append(random)
			copy_dict.erase(chosen)
		else:
			choices.append(null)
	return choices
	
func check_if_exists() -> void:
	for i : String in inventory.keys():
		var elem : ProjectileReference = inventory[i]
		if not is_instance_valid(elem.handler):
			elem.handler = elem.resource.instantiate()
			elem.handler.player = player
			add_child(elem.handler)
						
						
				
				
