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
@onready var area_2d : Area2D = $Area2D

var enemies_collided_list : Array[Node2D] = []

func _process(_delta : float) -> void:
	
	direction = Input.get_vector("left", "right", "up", "down")

	velocity = direction * speed
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	elif direction.x > 0:
		sprite_2d.flip_h = false
	
	var collision_info : bool = move_and_slide()
	if collision_info:
		take_damage(1)

func is_left() -> bool:
	return sprite_2d.flip_h

func take_damage(damage : int) -> void:
	if timer.is_stopped():
		timer.start() # timer is set to 0.3
		health -= damage
		animation_player.play("take_damage")
		print(health)

func collide_enemy(body : Node2D) -> void:
	body.take_damage(20)
	take_damage(1)

func _on_area_2d_body_entered(body : Node2D) -> void:
	if body.is_in_group("damageable"):
		enemies_collided_list.append(body)
		collide_enemy(body)

func _on_area_2d_body_exited(body : Node2D) -> void:
	enemies_collided_list.erase(body)

func _on_timer_timeout() -> void:
	for body in enemies_collided_list:
		collide_enemy(body)

func _on_active_range_body_exited(body : Node2D) -> void:
	if body.is_in_group("despawnable"):
		body.despawn()

func _on_active_range_area_exited(area : Area2D) -> void:
	if area.is_in_group("despawnable"):
		area.despawn()
