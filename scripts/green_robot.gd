extends Enemy
class_name GreenRobot

var robot_speed : float = 100
var robot_health : float = 100
var robot_knockback_strength : float = 500

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_strength = robot_knockback_strength
	scale = Vector2(2, 2)
