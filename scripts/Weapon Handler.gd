extends Node2D
class_name WeaponHandler

const MAX_LEVEL : int = 9

var inventory : Array[ProjectileReference] = []
var sword : Projectile
var ref : Dictionary = {}

@onready var player: Player = $"../Player"
var game : Node

func _ready() -> void:
	game = get_node("/root/Game")
	add_weapon("4-way")
	add_weapon("katanatata")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not Input.is_action_pressed("reject"):
		shoot()
	else:
		if is_instance_valid(sword):
			sword.queue_free()
			
func update_weapon_level(changedItem : RandomItem) -> void:
	ref[changedItem.item_name] += 1
	print(ref)
	
func add_weapon(weapon_name : String) -> void:
	ref[weapon_name] = 0
	var format_string : String = "res://scenes/weapons/%s.tscn"
	
	var resource : Resource = load(format_string % weapon_name)
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
	for elem : String in ref.keys():
		if ref[elem] < MAX_LEVEL:
			copy_dict[elem] = ref[elem]
			
	for i in range(3):
		if copy_dict.keys().size() > 0:
			var chosen : String = copy_dict.keys().pick_random()
			var random : RandomItem = RandomItem.new()
			random.item_name = chosen
			random.level_up_text = "+1 level\n" + chosen
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
					var mult : Array[Vector2] = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
					
					for j in range(4):
						var instance : Projectile = weapon.instantiate()
						instance.position = player.position
						instance.velocity *= mult[j]
						game.add_child(instance)
				"katanatata":
					if !is_instance_valid(sword):
						sword = weapon.instantiate()
						sword.position = player.position
						game.add_child(sword)
						
						
				
				
