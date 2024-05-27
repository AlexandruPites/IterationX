extends Area2D
class_name WallSpike

var velocity: Vector2
const SPEED: int = 300
const DAMAGE: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += SPEED * velocity * delta
	
func despawn() -> void:
	queue_free()

func _on_body_entered(body : Node2D) -> void:
	if body.is_in_group("damageable"):
		body.take_damage(DAMAGE)
