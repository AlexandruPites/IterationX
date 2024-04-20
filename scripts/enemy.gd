extends CharacterBody2D

const SPEED : float = 50
var health : float = 100

@onready var player : CharacterBody2D = $"../Player"
@onready var sprite_2d: Sprite2D = $Sprite2D

var player_pos : Vector2 = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	
	var diff : Vector2 = player.position - position
	
	if diff.x < 0:
		sprite_2d.flip_h = true
	elif diff.x > 0:
		sprite_2d.flip_h = false
	
	velocity = diff.normalized() * SPEED
	move_and_slide()
