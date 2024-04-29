extends Node2D
class_name WeaponHandler

const MAX_LEVEL : int = 9

var inventory : Dictionary = {}
var levels : Dictionary = {}

@onready var player: Player = $"../Player"
var game : Node

func _ready() -> void:
	game = get_node("/root/Game")
	var file : FileAccess = FileAccess.open("res://text_files/weapons.txt", FileAccess.READ)
	while !file.eof_reached():
		var line : String = file.get_line()
		if line != "":
			levels[line] = 0
	print(levels)
	file.close()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Input.is_action_pressed("reject"):
		shoot()
	else:
		for i : String in inventory:
			var elm : ProjectileReference = inventory[i]
			if is_instance_valid(elm.handler):
				elm.handler.queue_free()
			
func update_weapon_level(changedItem : RandomItem) -> void:
	if levels[changedItem.item_name] == 0:
		add_weapon(changedItem.item_name)
	else:
		levels[changedItem.item_name] += 1
		var handler : Node = inventory[changedItem.item_name].handler
		handler.update_stats(levels[changedItem.item_name])
	print(levels)
	
func add_weapon(weapon_name : String) -> void:
	levels[weapon_name] = 1
	var format_string : String = "res://scenes/weapons/%s/%s_handler.tscn"
	print((format_string % [weapon_name, weapon_name]))
	var resource : Resource = load(format_string % [weapon_name, weapon_name])
	var instance : Node = resource.instantiate()
	instance.player = player
	
	var temp : ProjectileReference = ProjectileReference.new()
	temp.resource = resource
	temp.weapon_name = weapon_name
	temp.handler = instance
	inventory[weapon_name] = temp
	add_child(temp.handler)
	
func choose_level_ups() -> Array[RandomItem]:
	var choices : Array[RandomItem] = []
	var copy_dict : Dictionary = {}
	for elem : String in levels.keys():
		if levels[elem] < MAX_LEVEL:
			copy_dict[elem] = levels[elem]
			
	for i in range(3):
		if copy_dict.keys().size() > 0:
			var chosen : String = copy_dict.keys().pick_random()
			var random : RandomItem = RandomItem.new()
			random.item_name = chosen
			random.level_up_text = "+1 level\n" + chosen + "\nCurrent level: " + str(levels[chosen])
			choices.append(random)
			copy_dict.erase(chosen)
		else:
			choices.append(null)
	return choices
	
func shoot() -> void:
	for i : String in inventory.keys():
		var elem : ProjectileReference = inventory[i]
		if not is_instance_valid(elem.handler):
			elem.handler = elem.resource.instantiate()
			elem.handler.player = player
			add_child(elem.handler)
						
						
				
				
