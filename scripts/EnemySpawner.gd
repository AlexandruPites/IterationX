extends Node2D
class_name EnemySpawner

var enemy_array : Array[Enemy] = []
var enemy_scenes : Array[PackedScene]
var xp_scene : Resource = preload("res://scenes/xp.tscn")
var ranged_enemy : PackedScene
const max_melee: int = 0
const max_ranged: int = 1
var melee_count : int = 0
var ranged_count : int = 0
const spawn_distance : float = 900
@onready var player : CharacterBody2D = $"../Player"
@onready var timer : Timer = $Timer

var enemy_index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ranged_enemy = preload("res://scenes/enemies/crocantel.tscn")
	enemy_scenes.append(preload("res://scenes/enemies/robot.tscn"))
	#enemy_scenes.append(preload("res://scenes/enemies/green_robot.tscn"))
	#enemy_scenes.append(preload("res://scenes/enemies/don_juan.tscn"))
	#enemy_scenes.append(preload("res://scenes/enemies/zumzarel.tscn"))
	#enemy_scenes.append(preload("res://scenes/enemies/torpalod.tscn"))
	#ranged_enemy = preload("res://scenes/enemies/white_robot.tscn")
	
func _on_timer_timeout() -> void:
	if enemy_index + 1 < enemy_scenes.size():
		enemy_index += 1
		print("Improved enemies to index " + str(enemy_index))

func _on_death(source : CharacterBody2D) -> void:
	source.alive = false
	source.collision_shape_2d.set_deferred("disabled", true)
	if source.health <= 0:
		var xp : Area2D = xp_scene.instantiate()
		xp.position = source.position
		add_child.call_deferred(xp)
	if source.is_in_group("melee") and source in enemy_array:
		melee_count -= 1
	elif source.is_in_group("ranged") and source in enemy_array:
		ranged_count -= 1
	enemy_array.erase(source)
	source.death_player.play("death")
	#queue_free() call happens inside animation player

func get_spawn_coord(player_pos : Vector2) -> Vector2:
	var result_position : Vector2 = Vector2.ZERO
	var theta : float = randf() * 6.28
	result_position.x = player_pos.x + spawn_distance * cos(theta)
	result_position.y = player_pos.y + spawn_distance * sin(theta)
	return result_position
	
func get_closest_enemy_to_point(source_pos : Vector2) -> Enemy:
	var min_dist : float = INF
	var closest_enemy : Enemy = null
	for enemy in enemy_array:
		var dist : float = source_pos.distance_squared_to(enemy.position)
		if dist < min_dist:
			min_dist = dist
			closest_enemy = enemy
	return closest_enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta : float) -> void:
	var new_melee : int = max_melee - melee_count
	var new_ranged : int = max_ranged - ranged_count
	var elapsed_time : float = timer.wait_time - timer.time_left
	var upgraded_enemy_spawn_chance : float = elapsed_time / timer.wait_time
	
	for i in range(new_melee):
		var roll : float = randf()
		var crt_index : int = enemy_index + 1 if roll < upgraded_enemy_spawn_chance and enemy_index + 1 < enemy_scenes.size() else enemy_index
		var new_enemy : Enemy = enemy_scenes[crt_index].instantiate()
		new_enemy.death.connect(_on_death)
		new_enemy.position = get_spawn_coord(player.position)
		enemy_array.append(new_enemy)
		add_child(new_enemy)
		melee_count += 1
	
	for i in range(new_ranged):
		var new_enemy : Enemy = ranged_enemy.instantiate()
		new_enemy.death.connect(_on_death)
		new_enemy.position = get_spawn_coord(player.position)
		enemy_array.append(new_enemy)
		add_child(new_enemy)
		ranged_count += 1
