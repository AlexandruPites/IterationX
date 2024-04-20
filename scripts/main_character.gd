extends CharacterBody2D
class_name Player


#player attributes
var health : float = 100.0
var speed : float = 300.0
var direction : Vector2

@onready var weapon_handler: WeaponHandler = $"Weapon Handler"
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(_delta : float) -> void:
	
	direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * speed
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	elif direction.x > 0:
		sprite_2d.flip_h = false
	
	var collision_info : bool = move_and_slide()
	if collision_info:
		if timer.is_stopped():
			timer.start() # timer is set to 0.3
			health -= 1
			animation_player.play("take_damage")
			print(health)

func is_left() -> bool:
	return sprite_2d.flip_h
