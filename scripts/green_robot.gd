extends Enemy
class_name GreenRobot

var robot_speed : float = 100
var robot_health : float = 400
var robot_knockback_resist : float = 0.8

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	scale = Vector2(1.5, 1.5)
