extends Enemy
class_name WhiteRobot

var robot_speed : float = 25
var robot_health : float = 2000
var robot_knockback_resist : float = 0.1
var projectile : Resource
var projectile_speed : float = 100
@onready var shoot_timer: Timer = $ShootTimer

func _ready() -> void:
	projectile = load("res://scenes/projectiles/white_robot_projectile.tscn")
	speed = robot_speed
	health = robot_health
	knockback_resist = robot_knockback_resist
	

func _process(delta: float) -> void:
	if alive:
		var diff : Vector2 = player.position - position
		
		if shoot_timer.is_stopped():
			shoot_timer.start()
			var proj : Node = projectile.instantiate()
			proj.position = position
			proj.velocity = diff.normalized() * projectile_speed
			get_parent().add_child(proj)
	
		if diff.x < 0:
			sprite_2d.flip_h = true
		elif diff.x > 0:
			sprite_2d.flip_h = false

		velocity = diff.normalized() * speed + knockback
		knockback = lerp(knockback, Vector2.ZERO, 0.07)
		var has_collided: bool = move_and_slide()
		
