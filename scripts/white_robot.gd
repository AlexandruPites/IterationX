extends Enemy
class_name WhiteRobot

var robot_speed : float = 25
var robot_health : float = 500
var robot_knockback_resist : float = 0.1

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
