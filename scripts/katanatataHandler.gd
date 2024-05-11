extends Node

var weapon_name : String = "katanatata"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var level : int = 1
var base_damage : float = 10
var base_swing_speed : float = 5
var base_fire_rate : float = 0.3
var base_knockback : float = 750
var hit_counter : int = 1

var damage : float
var swing_speed : float
var player: Player
var sword : Projectile
var knockback : float
@onready var timer: Timer = $Timer

var modifiers : StatIncrease = StatIncrease.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	timer.wait_time = base_fire_rate
	
	sword = resource.instantiate()
	sword.position = player.position
	set_stats()
	add_child(sword)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sword.position = player.position

func set_stats() -> void:
	sword.level = level
	sword.speed = swing_speed
	sword.damage = damage
	sword.knockback = knockback

func calc_stats() -> void:
	damage = base_damage * level * (1 + modifiers.damage_increase)
	swing_speed = base_swing_speed * max(1, log(level)) * (1 + modifiers.projectile_speed_increase)
	knockback = base_knockback * (1 + modifiers.knockback_increase)
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
	set_stats()
