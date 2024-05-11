extends Enemy
class_name Robot

var robot_speed : float = 50
var robot_health : float = 100
var robot_knockback_resist : float = 1

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
