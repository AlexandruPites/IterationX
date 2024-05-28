extends Node2D

@export var noise_height_text : NoiseTexture2D
@onready var tile_map : TileMap = $TileMap
@onready var player: Player = $"../Player"

var noise : Noise
var size : int = 10
var width : int = size
var height : int = size
var tile_size : int = 64
var produs : int = size * tile_size

var source_id : int
var dune_tile : Vector2i = Vector2i(0, 0)
var standard_tile : Vector2i = Vector2i(4, 0)
var crater_tile : Vector2i = Vector2i(8, 0)

var last_center : Vector2
var offsets : Array[Vector2] = [Vector2(-produs, -produs), Vector2(0, -produs), Vector2(produs, -produs), Vector2(-produs, 0),
									 Vector2(0, 0), Vector2(produs, 0), Vector2(-produs, produs), Vector2(0, produs), Vector2(produs, produs)]
var centers : Array[Vector2]

func generate_part(pos : Vector2) -> void:
	for x in range(-width / 2, width / 2):
		for y in range(-height / 2, height / 2):
			var noise_val : float = noise.get_noise_2d(x, y)
			if noise_val >= -0.01 and noise_val <= 0.0:
				tile_map.set_cell(0, Vector2i(x, y) + Vector2i(pos.x, pos.y) / tile_size, 0, dune_tile)
			elif abs(noise_val) >= 0.22 and abs(noise_val) <= 0.23:
				tile_map.set_cell(0, Vector2i(x, y) + Vector2i(pos.x, pos.y) / tile_size, 0, crater_tile)
			else:
				tile_map.set_cell(0, Vector2i(x, y) + Vector2i(pos.x, pos.y) / tile_size, 0, standard_tile)
			
func generate_world(origin : Vector2) -> void:
	tile_map.clear()
	centers.clear()
	last_center = origin
	for off in offsets:
		var x : Vector2 = origin + off
		generate_part(x)
		centers.append(x)

func _ready() -> void:
	noise_height_text.noise.seed = randi()
	noise = noise_height_text.noise
	generate_world(player.position)
	
func _process(_delta: float) -> void:
	var min_dist : float = INF
	var closest_center : Vector2
	for pos in centers:
		var dist : float = player.position.distance_squared_to(pos)
		if dist < min_dist:
			min_dist = dist
			closest_center = pos
	if closest_center != last_center:
		generate_world(closest_center)
