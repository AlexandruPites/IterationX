extends Node

var weapon_name : String = "katanatata"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var level : int = 1
var base_projectile_speed : float = 1000
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var base_damage : float = 10
var base_speed : float = 5
var base_fire_rate : float = 0.3
var hit_counter : int = 1

var damage : float
var speed : float
var player: Player
var sword : Projectile
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	timer.wait_time = base_fire_rate
	
	sword = resource.instantiate()
	set_stats()
	add_child(sword)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sword.position = player.position

func set_stats() -> void:
	sword.level = level
	sword.speed = speed
	sword.damage = damage

func calc_stats() -> void:
	damage = base_damage * level
	speed = base_speed * max(1, log(level))
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
	set_stats()
