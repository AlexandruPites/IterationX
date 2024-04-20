extends Node2D
class_name WeaponHandler


const PROJECTILE = preload("res://scenes/projectile.tscn")
var inventory : Array[Resource] = [PROJECTILE]
@onready var player: Player = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("accept"):
		print("shoot")
		shoot()
	
func shoot() -> void:
	for weapon in inventory:
		var instance : Projectile = PROJECTILE.instantiate()
		instance.position = get_parent().position
		if player.is_left():
			instance.velocity = -instance.velocity
		get_node("/root/Game").add_child(instance)
