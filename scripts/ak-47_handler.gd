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
var base_knockback : float = 250

var damage : float
var speed : float
var player: Player
var fire_rate : float
var target : Enemy
var spawner : EnemySpawner
var knockback : float
@onready var timer: Timer = $Timer

var modifiers : StatIncrease = StatIncrease.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	spawner = get_node("/root/Game/EnemySpawner")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		target = spawner.get_closest_enemy_to_point(player.position)
		if target != null:
			var instance : Projectile = resource.instantiate()
			instance.velocity = velocity 
			instance.position = player.position
			instance.damage = damage
			instance.hit_counter = hit_counter
			instance.speed = speed
			instance.knockback = knockback
			instance.target = target
			add_child(instance)

func calc_stats() -> void:
	damage = base_damage * level * (1 + modifiers.damage_increase)
	speed = base_projectile_speed * (1 + modifiers.projectile_speed_increase)
	knockback = base_knockback * (1 + modifiers.knockback_increase)
	fire_rate = base_fire_rate / float(level)
	timer.wait_time = fire_rate
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
