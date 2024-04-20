extends Node2D
class_name WeaponHandler


var inventory : Array[Resource] = []
var names : Array[String] = []
@onready var player: Player = $".."
var parent_pos : Vector2
var game : Node

func _ready() -> void:
	game = get_node("/root/Game")
	add_weapon("4-way")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("accept") or true:
		print("shoot")
		shoot()
	
func add_weapon(name : String) -> void:
	var format_string : String = "res://scenes/weapons/%s.tscn"
	inventory.append(load(format_string % name))
	names.append(name)
	
func shoot() -> void:
	parent_pos = get_parent().position
	for i in range(inventory.size()):
		var weapon : Resource = inventory[i]
		match names[i]:
			"4-way":
				var instance1 : Projectile = weapon.instantiate()
				var instance2 : Projectile = weapon.instantiate()
				var instance3 : Projectile = weapon.instantiate()
				var instance4 : Projectile = weapon.instantiate()
				instance1.position = parent_pos
				instance2.position = parent_pos
				instance3.position = parent_pos
				instance4.position = parent_pos
				instance1.velocity *= Vector2(1, 0)
				instance2.velocity *= Vector2(-1, 0)
				instance3.velocity *= Vector2(0, 1)
				instance4.velocity *= Vector2(0, -1)
				game.add_child(instance1)
				game.add_child(instance2)
				game.add_child(instance3)
				game.add_child(instance4)
				
				
