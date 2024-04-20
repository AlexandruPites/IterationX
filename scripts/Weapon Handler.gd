extends Node2D
class_name WeaponHandler


var inventory : Array[Resource] = []
var names : Array[String] = []
var timers : Array[Timer] = []

@onready var player: Player = $".."
var parent_pos : Vector2
var game : Node

func _ready() -> void:
	game = get_node("/root/Game")
	add_weapon("4-way")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("accept") or true:
		shoot()
	
func add_weapon(name : String) -> void:
	var format_string : String = "res://scenes/weapons/%s.tscn"
	inventory.append(load(format_string % name))
	names.append(name)
	var timer : Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 0.3
	timers.append(timer)
	add_child(timer)
	
func shoot() -> void:
	parent_pos = get_parent().position
	for i in range(inventory.size()):
		var weapon : Resource = inventory[i]
		if timers[i].is_stopped():
			timers[i].start()
			match names[i]:
				"4-way":
					var instances : Array[Projectile]
					var mult : Array[Vector2] = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]
					
					for j in range(4):
						var instance : Projectile = weapon.instantiate()
						instance.position = parent_pos
						instance.velocity *= mult[j]
						game.add_child(instance)
				
				
