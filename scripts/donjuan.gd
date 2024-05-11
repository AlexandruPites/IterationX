extends Enemy
class_name DonJuan

var robot_speed : float = 150
var robot_health : float = 700
var robot_knockback_resist : float = 0.25

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	scale = Vector2(1.5, 1.5)
