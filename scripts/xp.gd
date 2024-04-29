extends Area2D

const PICKUPABLE_SPEED: float = 500.0
var velocity: Vector2 = Vector2.ZERO
var value: float = 100.0
@onready var player: Player = get_node("/root/Game/Player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("float_in_place")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity != Vector2.ZERO:
		fly_to_player()
	position += velocity * delta

func fly_to_player() -> void:
	var diff: Vector2 = player.position - position
	velocity = diff.normalized() * PICKUPABLE_SPEED
