extends Projectile

var velocity : Vector2
var damage : float = 10.0

func _process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		body.take_damage(damage)
		queue_free()
