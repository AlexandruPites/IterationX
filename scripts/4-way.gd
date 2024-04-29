extends Projectile

var base_projectile_speed : float = 1000
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var base_damage : float = 10
var hit_counter : int = 5
var damage : float
var base_fire_rate : float = 0.3

func _ready() -> void:
	calc_stats()

func _process(delta: float) -> void:
	position += velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()

func calc_stats() -> void:
	damage = base_damage * level

func _on_timer_timeout() -> void:
	queue_free()

func despawn() -> void:
	queue_free()
