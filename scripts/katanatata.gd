extends Projectile
class_name Sword

var player: Player
var angle: float = 0
var speed: float
var damage : float

func _init() -> void:
	single_instance = true

func _ready() -> void:
	player = get_node("/root/Game/Player")
	position.x = player.position.x + 100 * cos(0)
	position.y = player.position.y + 100 * sin(0)

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

func _on_timer_timeout() -> void:
	pass

func despawn() -> void:
	queue_free()
