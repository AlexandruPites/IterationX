extends CharacterBody2D
class_name Enemy

const SPEED : float = 50
var health : float = 100

@onready var player : CharacterBody2D = $"../../Player"
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var timer : Timer = $Timer
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var player_pos : Vector2 = Vector2.ZERO

signal death(dead_enemy : CharacterBody2D)

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
				take_damage(50)


func take_damage(damage : float ) -> void:
	if timer.is_stopped():
		timer.start()
		if not animation_player.is_playing():
			animation_player.play("take_damage")
		health -= damage
		print("Enemy" + str(health))
		if health <= 0:
			death.emit(self)
