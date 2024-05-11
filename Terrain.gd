extends Node2D

@export var noise_height_text : NoiseTexture2D
@onready var tile_map : TileMap = $TileMap

var noise : Noise
var width : int = 100
var height : int = 100

var source_id : int
var dune_tile : Vector2i = Vector2i(0, 0)
var standard_tile : Vector2i = Vector2i(4, 0)
var crater_tile : Vector2i = Vector2i(8, 0)

func generate_world() -> void:
	for x in range(-width / 2, width / 2):
		for y in range(-height / 2, height / 2):
			var noise_val : float = noise.get_noise_2d(x, y)
			if noise_val >= -0.01 and noise_val <= 0.0:
				tile_map.set_cell(0, Vector2i(x, y), 0, dune_tile)
			elif abs(noise_val) >= 0.22 and abs(noise_val) <= 0.23:
				tile_map.set_cell(0, Vector2i(x, y), 0, crater_tile)
			else:
				tile_map.set_cell(0, Vector2i(x, y), 0, standard_tile)

func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()
