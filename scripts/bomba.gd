extends Projectile
class_name Bomba

var speed : float
var velocity : Vector2
var hit_counter : int
var damage : float
var angle : float = 0

const ROTATION_SPEED : float = 10
var spawner : EnemySpawner
var player : Player

func _ready() -> void:
	spawner = get_node("/root/Game/EnemySpawner")

func _process(delta: float) -> void:
	rotation = cos(angle)
	angle += ROTATION_SPEED * delta
	position = player.position + Vector2(0, -150)

func boom() -> void:
	var children : Array = spawner.get_children()
	for c : Node in children:
		if c.is_in_group("bombable"):
			if c.is_in_group("despawnable"):
				c.despawn()
			else:
				c.queue_free()
	queue_free()


func _on_timer_timeout() -> void:
	boom()
