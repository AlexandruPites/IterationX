extends Node

var weapon_name : String = "4-way"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var base_projectile_speed : float = 1000
var base_fire_rate : float = 0.3
var base_damage : float = 10
var base_knockback : float = 250

var level : int = 1
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var hit_counter : int = 5
var damage : float
var knockback : float

var player: Player
var modifiers : StatIncrease = StatIncrease.new()
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	timer.wait_time = base_fire_rate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		var instances : Array[Projectile]
		var mult : Array[Vector2] = [Vector2(1, 0), Vector2(-1, 0), Vector2(0, -1), Vector2(0, 1),
									 Vector2(0.707, -0.707), Vector2(0.707, 0.707), Vector2(-0.707, 0.707), Vector2(-0.707, -0.707)]
		
		for j in range(min(level, 8)):
			var instance : Projectile = resource.instantiate()
			instance.velocity = mult[j] * velocity 
			instance.position = player.position
			instance.damage = damage
			instance.knockback = knockback
			instance.hit_counter = hit_counter
			add_child(instance)

func calc_stats() -> void:
	damage = base_damage * level * (1 + modifiers.damage_increase)
	knockback = base_knockback * (1 + modifiers.knockback_increase)
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
