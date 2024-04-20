extends CharacterBody2D
class_name Enemy

const SPEED : float = 50
var health : float = 100
var is_alive : bool = true

@onready var player : CharacterBody2D = $"../../Player"
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
	var has_collided: bool = move_and_slide()
	if has_collided:
		for i in range(get_slide_collision_count()):
			if get_slide_collision(i).get_collider_id() == player.get_instance_id():
				is_alive = false


func take_damage(damage : float ) -> void:
	health -= damage
	print("Enemy" + str(health))
