extends CharacterBody2D

#constants
const SPEED : float = 300.0

#player attributes
var health : float = 100.0
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta):
	
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")

	velocity = direction * SPEED
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	elif direction.x > 0:
		sprite_2d.flip_h = false
	
	var collision_info = move_and_slide()
	if collision_info:
		if timer.is_stopped():
			timer.start() # timer is set to 0.3
			health -= 1
			animation_player.play("take_damage")
			collision_shape_2d.disabled = true
			print(health)
	if timer.is_stopped() and collision_shape_2d.disabled:
		collision_shape_2d.disabled = false
		animation_player.stop()
