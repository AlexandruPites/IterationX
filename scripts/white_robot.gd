extends Enemy
class_name WhiteRobot

var robot_speed : float = 25
var robot_health : float = 500
var robot_knockback_resist : float = 0.1
var projectile : Resource
var projectile_speed : float = 200
@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	projectile = load("res://scenes/projectiles/white_robot_projectile.tscn")
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	

func _process(delta: float) -> void:
	super._process(delta)
	if alive:
		if shoot_timer.is_stopped():
			shoot_timer.start()
			var diff : Vector2 = player.position - position
			var proj : Node = projectile.instantiate()
			proj.position = position
			proj.velocity = diff.normalized() * projectile_speed
			get_parent().add_child(proj)
		
