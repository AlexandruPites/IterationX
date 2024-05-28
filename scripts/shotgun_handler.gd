extends Node

var weapon_name : String = "shotgun"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var shotgun_resource : Resource = preload("res://scenes/weapons/shotgun/shotgun_image.tscn")
var shotgun_image : Sprite2D

var level : int = 1
var base_projectile_speed : float = 1000
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var base_damage : float = 10
var hit_counter : int = 1
var base_fire_rate : float = 2
var base_knockback : float = 500
var base_pellet_count : int = 5
var base_cone_degrees_half : float = 22.5

var damage : float
var speed : float
var player: Player
var fire_rate : float
var spawner : EnemySpawner
var knockback : float
var pellet_count : int

@onready var timer: Timer = $Timer
@onready var ssg_sound: AudioStreamPlayer = $AudioStreamPlayer

var modifiers : StatIncrease = StatIncrease.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	spawner = get_node("/root/Game/EnemySpawner")
	shotgun_image = shotgun_resource.instantiate()
	add_child(shotgun_image)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	shotgun_image.position = player.position
	shotgun_image.flip_h = player.sprite_2d.flip_h
	if timer.is_stopped():
		timer.start()
		ssg_sound.play()
		
		var degrees : Array = []
		for i in range(pellet_count):
			degrees.append(randf_range(-base_cone_degrees_half, base_cone_degrees_half))
		
		var directions : Array = []
		var Ox : Vector2 = Vector2(-1, 0) if player.sprite_2d.flip_h else Vector2(1, 0)
		for deg : float in degrees:
			directions.append(Ox.rotated(deg_to_rad(deg)))
			
		for dir : Vector2 in directions:
			var instance : Projectile = resource.instantiate()
			instance.velocity = speed * dir 
			instance.position = player.position
			instance.damage = damage
			instance.hit_counter = hit_counter
			instance.knockback = knockback
			add_child(instance)

func calc_stats() -> void:
	damage = base_damage * level * (1 + modifiers.damage_increase)
	damage = base_damage * 5 * (1 + modifiers.damage_increase)
	speed = base_projectile_speed * (1 + modifiers.projectile_speed_increase)
	knockback = base_knockback * (1 + modifiers.knockback_increase)
	pellet_count = base_pellet_count + int(ceil(level / 2))
	fire_rate = base_fire_rate
	timer.wait_time = fire_rate
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
