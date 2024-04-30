extends Projectile
class_name AK47

var speed : float
var velocity : Vector2
var hit_counter : int
var damage : float
var target : Enemy

func _process(delta: float) -> void:
	if velocity != Vector2.ZERO and target.alive:
		target_nonbeliever()
		position += velocity * delta
	else:
		queue_free()

func target_nonbeliever() -> void:
	if target.alive:
		var diff: Vector2 = target.position - position
		velocity = diff.normalized() * speed
		rotation = position.angle_to_point(target.position)
	else:
		rotation = 0
		velocity = Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)
		queue_free()

func despawn() -> void:
	queue_free()

