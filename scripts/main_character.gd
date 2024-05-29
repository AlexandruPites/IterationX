extends CharacterBody2D
class_name Player

#player base attributes
var base_max_health : float = 100.0
var base_speed : float = 300.0
var base_regen : float = 0.0
var base_regen_speed : float = 5.0
var base_revives : int = 0
var base_magnet : Vector2 = Vector2(3, 3)

#player attributes - do not change these
var max_health : float
var health : float
var speed : float
var direction : Vector2
var regen : float
var revives : int
var magnet : Vector2

#player xp attributes
var xp : float = 0
var xp_to_level : float = 100
var level : int = 0

signal level_up

@onready var tm_currency: Timer = get_node("/root/Game/Camera2D/Timer")
@onready var sprite_2d : Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_2d : Area2D = $Area2D
@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var xp_pickup_sound : AudioStreamPlayer = $XP_pickup_sound
@onready var hurt_sound : AudioStreamPlayer = $Hurt_sound
@onready var levelup_sound : AudioStreamPlayer = $Levelup_sound
@onready var regen_timer: Timer = $RegenTimer
@onready var pickup_radius: Area2D = $PickupRadius
@onready var prison_handler: Node2D = $"../PrisonHandler"
@onready var walk_player: AnimationPlayer = $WalkPlayer
@onready var base_texture : Resource = load("res://images/astronaut.png")


var player_viewport : Vector2
var modifiers : StatIncrease = StatIncrease.new()
var enemies_collided_list : Array[Node2D] = []

var ghosts : Array[Sprite2D]

func _ready() -> void:
	player_viewport = get_viewport_rect().size / 2
	
	for i in range(3):
		var ghost : Sprite2D = Sprite2D.new()
		ghost.z_index = -1
		ghost.modulate = Color(1, 1, 1, 1 - 0.2 * (i + 1))
		ghosts.append(ghost)
		add_child(ghost)
	
	var save_dict: Dictionary
	save_dict = save_utils.load_powerups()

	var powerups_dict: Dictionary = save_dict['powerups']
	for key: String in powerups_dict:
		match key:
			"Max HP":
				base_max_health += 10 * powerups_dict[key][0][0]
			"HP regen":
				base_regen += 1 * powerups_dict[key][0][0]
			"Movement Speed":
				base_speed += 15 * powerups_dict[key][0][0]
			"Revival":
				base_revives = powerups_dict[key][0][0]
	calc_stats()
	
	regen_timer.wait_time = base_regen_speed;
	regen_timer.start()
	
	health = max_health
	revives = base_revives
	magnet = base_magnet
	pickup_radius.scale = magnet

func _process(_delta : float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	if Input.is_action_pressed("accept"):
		var pos : Vector2 = get_viewport().get_mouse_position()
		direction = (pos - player_viewport).normalized()

	velocity = direction * speed
	if direction != Vector2.ZERO:
		walk_player.play("walk")
		for i in ghosts.size():
			var g : Sprite2D = ghosts[i]
			g.visible = true
			g.texture = sprite_2d.texture
			g.position = sprite_2d.position - Vector2(5 * (i + 1), 5 * ( i + 1)) * Vector2(direction.x, direction.y)
			g.flip_h = sprite_2d.flip_h
			g.hframes = sprite_2d.hframes
			g.vframes = sprite_2d.vframes
			g.frame = sprite_2d.frame
	else:
		walk_player.stop()
		sprite_2d.texture = base_texture
		for g in ghosts:
			g.visible = false
	
	if direction.x < 0:
		sprite_2d.flip_h = true
	elif direction.x > 0:
		sprite_2d.flip_h = false
	
	move_and_slide()
	camera_2d.position = position
	
	if xp >= xp_to_level:
		var diff : float = xp - xp_to_level
		xp_to_level += 100
		xp = diff
		level += 1
		levelup_sound.play()
		level_up.emit()
	

func is_left() -> bool:
	return sprite_2d.flip_h

func take_damage(damage : float, _knockback : float = 0) -> void:
	if timer.is_stopped():
		animation_player.play("take_damage")
		timer.start() # timer is set to 0.3
		health -= damage
		if health <= 0 and revives > 0:
			health = max_health
			revives -= 1
		elif health <= 0:
			save_utils.save_currency(tm_currency.wait_time - tm_currency.time_left)
			get_tree().change_scene_to_file.call_deferred("res://game_over_screen.tscn")
		print(health)
		hurt_sound.play()
		
func calc_stats() -> void:
	var damage_taken : float = max_health - health
	max_health = base_max_health * (1 + modifiers.health_increase)
	health = max_health - damage_taken
	regen = base_regen * (1 + modifiers.regen_increase)
	speed = base_speed * (1 + modifiers.speed_increase)
	revives = base_revives + modifiers.revive_amount
	
	magnet = base_magnet * (1 + modifiers.magnet_increase)
	pickup_radius.scale = magnet

func collide_enemy(body : Node2D) -> void:
	body.take_damage(20, 500)
	take_damage(3)

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
		area.queue_free()


func _on_regen_timer_timeout() -> void:
	health += regen
	if health > max_health:
		health = max_health
	
