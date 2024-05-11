extends Projectile
class_name LightningField

var player: Player
var angle: float = 0
var area: float
var damage : float

func _init() -> void:
	single_instance = true

func _ready() -> void:
	player = get_node("/root/Game/Player")

func _process(_delta: float) -> void:
	position = player.position
	var bodies : Array = get_overlapping_bodies()
	for body : Node2D in bodies:
		if body.is_in_group("damageable"):
			body.take_damage(damage)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		body.take_damage(damage)

func _on_timer_timeout() -> void:
	pass

func despawn() -> void:
	queue_free()
