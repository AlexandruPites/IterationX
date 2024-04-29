extends Node2D
class_name WeaponHandler

const MAX_LEVEL : int = 9

var inventory : Array[ProjectileReference] = []
var levels : Dictionary = {}
var single_instance_weapons : Dictionary = {}

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
		for elm : String in single_instance_weapons.keys():
			if is_instance_valid(single_instance_weapons[elm]):
				single_instance_weapons[elm].queue_free()
			
func update_weapon_level(changedItem : RandomItem) -> void:
	if levels[changedItem.item_name] == 0:
		add_weapon(changedItem.item_name)
	else:
		levels[changedItem.item_name] += 1
		if changedItem.item_name in single_instance_weapons.keys():
			single_instance_weapons[changedItem.item_name].level = levels[changedItem.item_name]
			single_instance_weapons[changedItem.item_name].update_stats()
	print(levels)
	
func add_weapon(weapon_name : String) -> void:
	levels[weapon_name] = 1
	var format_string : String = "res://scenes/weapons/%s.tscn"
	
	var resource : Resource = load(format_string % weapon_name)
	
	var instance : Projectile = resource.instantiate()
	if instance.single_instance:
		single_instance_weapons[weapon_name] = null
	instance.queue_free()
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.3
	
	var temp : ProjectileReference = ProjectileReference.new()
	temp.projectile_name = weapon_name
	temp.timer = timer
	temp.resource = resource
	inventory.append(temp)
	add_child(temp.timer)
	
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
	for elem in inventory:
		var weapon : Resource = elem.resource
		if elem.timer.is_stopped():
			elem.timer.start()
			match elem.projectile_name:
				"4-way":
					var instances : Array[Projectile]
					var mult : Array[Vector2] = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1), Vector2(0, 1),
												 Vector2(0.707, -0.707), Vector2(0.707, 0.707), Vector2(-0.707, 0.707), Vector2(-0.707, -0.707)]
					
					for j in range(min(levels["4-way"], 8)):
						var instance : Projectile = weapon.instantiate()
						instance.level = levels[elem.projectile_name]
						instance.position = player.position
						instance.velocity *= mult[j]
						game.add_child(instance)
				"katanatata":
					if !is_instance_valid(single_instance_weapons["katanatata"]):
						single_instance_weapons["katanatata"] = weapon.instantiate()
						var sword : Projectile = single_instance_weapons["katanatata"]
						sword.level = levels[elem.projectile_name]
						sword.position = player.position
						single_instance_weapons["katanatata"] = sword
						game.add_child(sword)
				"ak-47":
					var instance : Projectile = weapon.instantiate()
					instance.level = levels[elem.projectile_name]
					instance.position = player.position
					game.add_child(instance)
						
						
				
				
