extends Projectile
class_name Sword

var projectile_speed : float = 1000
var velocity : Vector2 = Vector2(projectile_speed, projectile_speed)
var damage : float = 50.0
var hit_counter : int = 5
var player: CharacterBody2D
var angle: float = 0
var speed: float = 5
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	player = get_node("/root/Game/Player")

func _process(delta: float) -> void:
	if player.sprite_2d.flip_h:
		angle -= delta * speed
		texture_rect.flip_v = true
	else:
		angle += delta * speed
		texture_rect.flip_v = false
	position.x = player.position.x + 100 * cos(angle)
	position.y = player.position.y + 100 * sin(angle)
	rotation = angle

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("damageable"):
		var direction : Vector2 = global_position.direction_to(body.global_position).normalized()
		body.take_damage(damage)


func _on_timer_timeout() -> void:
	pass

func despawn() -> void:
	queue_free()
