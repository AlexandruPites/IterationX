extends Projectile
class_name Shotgun

func _process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		body.take_damage(damage, knockback)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()
