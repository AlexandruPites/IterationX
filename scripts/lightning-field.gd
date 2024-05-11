extends Projectile
class_name LightningField

var player: Player
var angle: float = 0
var area: float
@onready var timer: Timer = $Timer

func _init() -> void:
	single_instance = true

func _ready() -> void:
	player = get_node("/root/Game/Player")
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 0.5
	timer.start()

func _process(_delta: float) -> void:
	position = player.position

func _on_timer_timeout() -> void:
	var bodies : Array = get_overlapping_bodies()
	for body : Node2D in bodies:
		if body.is_in_group("damageable"):
			body.take_damage(damage, knockback)

func despawn() -> void:
	queue_free()
