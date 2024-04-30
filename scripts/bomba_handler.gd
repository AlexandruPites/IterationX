extends Node

var weapon_name : String = "bomba"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

var level : int = 1
var base_fire_rate : float = 30

var damage : float
var speed : float
var player: Player
var fire_rate : float
var spawner : EnemySpawner
@onready var timer: Timer = $Timer

var modifiers : StatIncrease = StatIncrease.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	timer.one_shot = true
	spawner = get_node("/root/Game/EnemySpawner")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.is_stopped():
		timer.start()
		print("spawn bomba")
		var instance : Projectile = resource.instantiate()
		instance.scale = Vector2(5, 5)
		instance.player = player
		add_child(instance)

func calc_stats() -> void:
	fire_rate = base_fire_rate / float(level)
	timer.wait_time = fire_rate
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
