extends Enemy
class_name Torpalod

var robot_speed : float = 200
var robot_health : float = 1100
var robot_knockback_resist : float = 0.8

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	scale = Vector2(2, 2)
