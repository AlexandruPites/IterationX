extends Area2D

var velocity : Vector2
var damage : float = 10
var hit_counter : int = 1

func _process(delta: float) -> void:
	position += velocity * delta
	#rotate(delta)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		body.take_damage(damage, 0)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()

func despawn() -> void:
	queue_free()
