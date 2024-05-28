extends CharacterBody2D
class_name Enemy

var speed : float
var health : float
var alive : bool = true

@onready var player : CharacterBody2D = $"../../Player"
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var timer : Timer = $Timer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var enemy_hurt : AudioStreamPlayer = $Enemy_hurt
@onready var death_player: AnimationPlayer = $DeathPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var player_pos : Vector2 = Vector2.ZERO
var knockback : Vector2 = Vector2.ZERO
var knockback_resist : float

signal death(dead_enemy : CharacterBody2D)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	
	if alive:
		var diff : Vector2 = player.position - position
	
		if diff.x < 0:
			sprite_2d.flip_h = true
		elif diff.x > 0:
			sprite_2d.flip_h = false

		velocity = diff.normalized() * speed + knockback
		knockback = lerp(knockback, Vector2.ZERO, 0.07)
		move_and_slide()

func take_damage(damage : float, knockback_strength : float) -> void:
	if timer.is_stopped():
		timer.start()
		if not animation_player.is_playing():
			animation_player.play("take_damage")
		health -= damage
		var direction : Vector2 = player.global_position.direction_to(self.global_position).normalized()
		knockback += direction * knockback_strength * knockback_resist
		enemy_hurt.play()
		if health <= 0:
			despawn()

func despawn() -> void:
	death.emit(self)
