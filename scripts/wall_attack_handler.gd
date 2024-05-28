extends Node2D
class_name WallSpikeHandler

const wall_size: float = 2000
const wall_distance: float = 720
const hole_window = 500
const hole_size = 0
const projectile_size: float = 32
const max_wall_count: int = 25

var initial_y: float
var initial_x: float

var player : CharacterBody2D
var spike_scene : Resource = preload("res://scenes/enemies/wall_spike.tscn")

var spawned_walls : int = 0
signal end_signal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func spawn_wall_vertical(player_pos: Vector2) -> void:
	var roll: float = randf()
	print(roll)
	var hole_position : float = player_pos.x + hole_window * (roll - 0.5)
	var _spike_count: int = wall_size / projectile_size
	var x_base : float = player_pos.x - wall_size / 2
	for offset in range(0, wall_size, projectile_size):
		if x_base + offset > hole_position - hole_size - projectile_size and x_base + offset < hole_position + hole_size + projectile_size:
			continue
		var new_spike : WallSpike = spike_scene.instantiate()
		new_spike.velocity = Vector2(0, 1)
		new_spike.position = Vector2(x_base + offset, player_pos.y - wall_distance)
		new_spike.rotation = PI / 2
		add_child(new_spike)

func spawn_wall_horizontal(player_pos: Vector2) -> void:
	var roll: float = randf()
	print(roll)
	var hole_position : float = player_pos.y + hole_window * (roll - 0.5)
	var _spike_count: int = wall_size / projectile_size
	var y_base : float = player_pos.y - wall_size / 2
	for offset in range(0, wall_size, projectile_size):
		if y_base + offset > hole_position - hole_size - projectile_size and y_base + offset < hole_position + hole_size + projectile_size:
			continue
		var new_spike : WallSpike = spike_scene.instantiate()
		new_spike.velocity = Vector2(1, 0)
		new_spike.position = Vector2(player_pos.x - wall_distance, y_base + offset)
		add_child(new_spike)


func _on_timer_timeout() -> void:
	var roll : int = randi() % 2
	if roll == 0:
		spawn_wall_vertical(Vector2(initial_x, initial_y))
	else:
		spawn_wall_horizontal(Vector2(initial_x, initial_y))
	spawned_walls += 1
	
	if spawned_walls >= max_wall_count:
		end_signal.emit(self)
		queue_free()
	print("Wall spawned")
