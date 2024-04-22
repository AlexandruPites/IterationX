extends CharacterBody2D
class_name Player

#player attributes
var health : float = 30.0
var speed : float = 300.0
var direction : Vector2
var xp : float = 0
var xp_to_level : float = 100
var level : int = 0

signal level_up

@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d : Area2D = $Area2D
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var xp_pickup_sound : AudioStreamPlayer = $XP_pickup_sound
@onready var hurt_sound : AudioStreamPlayer = $Hurt_sound
var player_viewport : Vector2

var enemies_collided_list : Array[Node2D] = []

func _ready() -> void:
	player_viewport = get_viewport_rect().size / 2

func _process(_delta : float) -> void:
	
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("accept"):
		var pos : Vector2 = get_viewport().get_mouse_position()
		direction = (pos - player_viewport).normalized()

	velocity = direction * speed
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	elif direction.x > 0:
		sprite_2d.flip_h = false
	
	var collision_info : bool = move_and_slide()
	if collision_info:
		take_damage(1)
	camera_2d.position = position
	

func is_left() -> bool:
	return sprite_2d.flip_h

func take_damage(damage : int) -> void:
	if timer.is_stopped():
		timer.start() # timer is set to 0.3
		health -= damage
		if health <= 0:
			get_tree().change_scene_to_file.call_deferred("res://game_over_screen.tscn")
		animation_player.play("take_damage")
		print(health)
		hurt_sound.play()

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

func _on_pickup_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickupable"):
		area.fly_to_player()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("pickupable"):
		xp_pickup_sound.play()
		xp += area.value
		if xp >= xp_to_level:
			var diff : float = xp - xp_to_level
			xp_to_level += 100
			xp = diff
			level += 1
			level_up.emit()
		area.queue_free()
