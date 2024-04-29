extends Node

var weapon_name : String = "ak-47"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var level : int = 1
var base_projectile_speed : float = 1000
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var base_damage : float = 10
var hit_counter : int = 1
var base_fire_rate : float = 0.9

var damage : float
var speed : float
var player: Player
var fire_rate : float
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		var instance : Projectile = resource.instantiate()
		instance.velocity = velocity 
		instance.position = player.position
		instance.damage = damage
		instance.hit_counter = hit_counter
		instance.speed = speed
		add_child(instance)

func calc_stats() -> void:
	damage = base_damage * level
	if level < 5:
		damage = base_damage * 5
	speed = base_projectile_speed
	fire_rate = base_fire_rate / float(level)
	timer.wait_time = fire_rate
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
