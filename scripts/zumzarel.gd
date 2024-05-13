extends Enemy
class_name Zumzarel

var robot_speed : float = 200
var robot_health : float = 800
var robot_knockback_resist : float = 0.9
@onready var rotationPlayer: AnimationPlayer = $Rotation

func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	scale = Vector2(2, 2)
	rotationPlayer.play("rotate")
