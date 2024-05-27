extends Enemy
class_name Crocantel

#all attacks MUST be between IDLE and DEAD
enum {IDLE, WAVE_ATTACK, LASER_ATTACK, SPIRAL_ATTACK, DEAD}

var robot_speed : float = 250
var robot_health : float = 25000
var robot_knockback_resist : float = 0
var state : int

@onready var state_timer: Timer = $StateTimer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var laser_pos: Node2D = $Node2D
@onready var left_cannon: Node2D = $LeftCannon
@onready var right_cannon: Node2D = $RightCannon
@onready var cannon_timer: Timer = $CannonTimer

var wave_res : Resource
var wave : Area2D
var wave_max_size : Vector2 = Vector2(4, 4)
var wave_speed : float = 1

var laser_res : Resource
var laser : Area2D
var laser_rot_max : float = 2 * PI
var laser_speed : float = 1.25
var elapsed_rot : float = 0
var laser_speeds : Array = [laser_speed, -laser_speed]

var projectile_res : Resource
var projectile_speed : float = 100

var played_wave : bool = false
var played_laser : bool = false
var played_spiral : bool = false
var left_dir : Vector2 = Vector2(0, -1)
var right_dir : Vector2 = Vector2(-1, 0)
var left_dir2 : Vector2 = Vector2(1, 0)
var right_dir2 : Vector2 = Vector2(0, 1)
var rot_speed : float = PI / 10
var speeds : Array = [rot_speed, -rot_speed]

var animation_finished : bool = false


func _ready() -> void:
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	scale = Vector2(4, 4)
	state = IDLE
	wave_res = preload("res://scenes/projectiles/wave.tscn")
	laser_res = preload("res://scenes/projectiles/laser.tscn")
	projectile_res = preload("res://scenes/projectiles/crocantel_projectile.tscn")

func _process(delta: float) -> void:
	match state:
		IDLE:
			animated_sprite_2d.play("idle")
			if state_timer.is_stopped():
				state_timer.wait_time = randf_range(2, 4)
				state_timer.start()
		
		WAVE_ATTACK:
			if not played_wave:
				animated_sprite_2d.play("wave")
				played_wave = true
				animation_finished = false
			
			if animation_finished:
				if not is_instance_valid(wave):
					wave = wave_res.instantiate()
					wave.scale = Vector2.ZERO
					add_child(wave)
					
				wave.scale = lerp(wave.scale, wave_max_size, wave_speed * delta)
				if wave.scale.distance_to(wave_max_size) < 0.1:
					wave.scale = Vector2.ZERO
					state = IDLE
					played_wave = false
					wave.queue_free()
				
		LASER_ATTACK:
			if not played_laser:
				animated_sprite_2d.play("laser")
				played_laser = true
				animation_finished = false
				
			if animation_finished:
				if not is_instance_valid(laser):
					laser = laser_res.instantiate()
					laser.rotation = randf_range(0, 2 * PI)
					while abs(laser.rotation - position.angle_to_point(player.position)) < deg_to_rad(45):
						laser.rotation = randf_range(0, 2 * PI)
					laser.position = laser_pos.position
					laser.scale = Vector2(5, 0.75)
					elapsed_rot = 0
					add_child(laser)
			
				if abs(elapsed_rot) < 2 * PI:
					laser.rotate(laser_speed * delta)
					elapsed_rot += laser_speed * delta
				else:
					state = IDLE
					laser.scale = Vector2.ZERO
					played_laser = false
					laser.queue_free()
					laser_speed = laser_speeds.pick_random()
		
		SPIRAL_ATTACK:
			if not played_spiral:
				animated_sprite_2d.play("spiral")
				played_spiral = true
				animation_finished = false
				
			if animation_finished:
				if cannon_timer.is_stopped():
					cannon_timer.start()
					var proj : Area2D = projectile_res.instantiate()
					proj.velocity = projectile_speed * left_dir
					proj.position = left_cannon.position
					add_child(proj)
					left_dir = left_dir.rotated(rot_speed)
					
					proj = projectile_res.instantiate()
					proj.velocity = projectile_speed * left_dir2
					proj.position = left_cannon.position
					add_child(proj)
					left_dir2 = left_dir2.rotated(rot_speed)
					
					proj = projectile_res.instantiate()
					proj.velocity = projectile_speed * right_dir
					proj.position = right_cannon.position
					add_child(proj)
					right_dir = right_dir.rotated(rot_speed)
					
					proj = projectile_res.instantiate()
					proj.velocity = projectile_speed * right_dir2
					proj.position = right_cannon.position
					add_child(proj)
					right_dir2 = right_dir2.rotated(rot_speed)
				
				if left_dir.distance_to(Vector2(0, 1)) < 0.001:
					state = IDLE
					left_dir = Vector2(0, -1)
					left_dir2 = Vector2(-1, 0)
					right_dir = Vector2(1, 0)
					right_dir2 = Vector2(0, 1)
					played_spiral = false
					rot_speed = speeds.pick_random()
			
		


func _on_animated_sprite_2d_animation_finished() -> void:
	animation_finished = true

func _on_state_timer_timeout() -> void:
	state = randi_range(IDLE + 1, DEAD - 1)
