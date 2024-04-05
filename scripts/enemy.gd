extends CharacterBody2D

const SPEED : float = 50
var health : float = 100

@onready var player = $"../Player"
@onready var sprite_2d: Sprite2D = $Sprite2D

var player_pos : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var diff : Vector2 = player.position - position
	
	if diff.x < 0:
		sprite_2d.flip_h = true
	elif diff.x > 0:
		sprite_2d.flip_h = false
	
	velocity = diff.normalized() * SPEED
	var collision_info = move_and_slide()
