extends CharacterBody2D

#constants
const SPEED : float = 300.0

#player attributes
var health : float = 100.0
@onready var sprite_2d = $Sprite2D


func _process(delta):
	
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	
	if horizontal_direction:
		position.x += horizontal_direction * SPEED * delta
	
	if horizontal_direction < 0:
		sprite_2d.flip_h = true
	elif horizontal_direction > 0:
		sprite_2d.flip_h = false
	
	if vertical_direction:
		position.y += vertical_direction * SPEED * delta
	
	move_and_slide()
