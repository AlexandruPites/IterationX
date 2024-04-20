extends Projectile

var projectile_speed : float = 1000
var velocity : Vector2 = Vector2(projectile_speed, projectile_speed)
var damage : float = 10.0
var hit_counter : int = 5

func _process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()
