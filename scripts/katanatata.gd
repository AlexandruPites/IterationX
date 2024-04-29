extends Projectile
class_name Sword

var projectile_speed : float = 1000
var velocity : Vector2 = Vector2(projectile_speed, projectile_speed)
var base_damage : float = 10.0
var base_speed : float = 5
var player: CharacterBody2D
var angle: float = 0
var speed: float
var damage : float
@onready var texture_rect: TextureRect = $TextureRect

func _init() -> void:
	single_instance = true

func _ready() -> void:
	player = get_node("/root/Game/Player")
	calc_stats()

func _process(delta: float) -> void:
	if angle >= 40 * PI:
		angle = 0
	angle += delta * speed
	position.x = player.position.x + 100 * cos(angle)
	position.y = player.position.y + 100 * sin(angle)
	rotation = angle

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)

func update_stats() -> void:
	calc_stats()

func calc_stats() -> void:
	damage = base_damage * level
	speed = base_speed * max(1, log(level))

func _on_timer_timeout() -> void:
	pass

func despawn() -> void:
	queue_free()
