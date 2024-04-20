extends Node2D

var enemy_array : Array[CharacterBody2D] = []
var enemy_scene : PackedScene = preload("res://scenes/enemy.tscn")
const max_enemies : int = 50
const spawn_distance : float = 700
@onready var player : CharacterBody2D = $"../Player"

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


func get_spawn_coord(player_pos : Vector2) -> Vector2:
	var result_position : Vector2 = Vector2.ZERO
	var theta : float = randf() * 6.28
	result_position.x = player_pos.x + spawn_distance * cos(theta)
	result_position.y = player_pos.y + spawn_distance * sin(theta)
	return result_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	var new_enemy_number : int = max_enemies - enemy_array.size()
	
	for i in enemy_array:
		if not i.is_alive:
			enemy_array.erase(i)
			i.queue_free()
	
	
	for i in range(new_enemy_number):
		var new_enemy : CharacterBody2D = enemy_scene.instantiate()
		new_enemy.position = get_spawn_coord(player.position)
		enemy_array.append(new_enemy)
		add_child(new_enemy)
		
		
	pass
