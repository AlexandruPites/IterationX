extends Projectile
class_name AK47

var base_projectile_speed : float = 500
var velocity : Vector2 = Vector2(base_projectile_speed, base_projectile_speed)
var base_damage : float = 10
var hit_counter : int = 1
var damage : float
var target : Enemy
var spawner : EnemySpawner
var base_fire_rate : float = 0.3

func _ready() -> void:
	calc_stats()
	spawner = get_node("/root/Game/EnemySpawner")
	target = spawner.get_closest_enemy_to_point(position)

func _process(delta: float) -> void:
	if target == null:
		target = spawner.get_closest_enemy_to_point(position)
	if velocity != Vector2.ZERO and target != null:
		target_nonbeliever()
	position += velocity * delta

func target_nonbeliever() -> void:
	var diff: Vector2 = target.position - position
	velocity = diff.normalized() * base_projectile_speed
	rotation = position.angle_to_point(target.position)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()

func calc_stats() -> void:
	damage = base_damage * level

func despawn() -> void:
	queue_free()

