extends Projectile
class_name AK47

var speed : float
var velocity : Vector2
var hit_counter : int
var damage : float
var target : Enemy
var spawner : EnemySpawner

func _ready() -> void:
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
	velocity = diff.normalized() * speed
	rotation = position.angle_to_point(target.position)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)
		hit_counter -= 1
		if hit_counter <= 0:
			queue_free()

func despawn() -> void:
	queue_free()

