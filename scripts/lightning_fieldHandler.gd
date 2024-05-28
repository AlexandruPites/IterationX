extends Node

var weapon_name : String = "lightning-field"
var format : String = "res://scenes/weapons/%s/%s.tscn"
var resource : Resource

const FIXED_SCALE : float = 2

var level : int = 1
var base_damage : float = 10
var base_area : float = 2
var base_knockback : float = 200

var damage : float
var swing_speed : float
var player: Player
var field : Projectile
var area : float
var knockback : float
@onready var timer: Timer = $Timer

var modifiers : StatIncrease = StatIncrease.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resource = load(format % [weapon_name, weapon_name])
	calc_stats()
	
	field = resource.instantiate()
	field.position = player.position
	set_stats()
	add_child(field)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	field.position = player.position

func set_stats() -> void:
	field.level = level
	field.damage = damage
	field.area = area
	field.scale = Vector2(area, area)
	field.knockback = knockback

func calc_stats() -> void:
	damage = base_damage * level * (1 + modifiers.damage_increase)
	area = FIXED_SCALE * base_area * (1 + float(level) / 9) * (1 + modifiers.area_increase)
	knockback = base_knockback * (1 + modifiers.knockback_increase)
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_stats()
	set_stats()
