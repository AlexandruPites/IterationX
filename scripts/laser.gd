extends Area2D

var player_in : bool = false
var damage : float = 10
@onready var player : Player = get_node("/root/Game/Player")

func _process(delta: float) -> void:
	if player_in:
		player.take_damage(damage, 0)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in = true
		body.take_damage(damage, 0)
		

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in = false
