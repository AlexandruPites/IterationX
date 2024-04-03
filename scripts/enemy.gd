extends CharacterBody2D

const SPEED : float = 50
var health : float = 100

@onready var player = $"../Player"
var player_pos : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_pos = player.position
	
	position.x = move_toward(position.x, player_pos.x, SPEED * delta)
	position.y = move_toward(position.y, player_pos.y, SPEED * delta)
	
