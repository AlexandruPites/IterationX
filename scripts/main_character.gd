extends CharacterBody2D

#constants
const SPEED = 300.0

#player attributes
var health = 100
var is_left = false
@onready var sprite_2d = $Sprite2D


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	var vertical_direction = Input.get_axis("ui_up", "ui_down")
	
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		is_left = velocity.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	sprite_2d.flip_h = is_left
		
	if vertical_direction:
		velocity.y = vertical_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	
	move_and_slide()
