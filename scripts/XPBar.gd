extends TextureProgressBar

# Called when the node enters the scene tree for the first time.
var player : CharacterBody2D
@onready var label: Label = $"../Label"

func _ready() -> void:
	player = get_node("/root/Game/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	value = player.xp
	max_value = player.xp_to_level
	label.text = "Level " + str(player.level)
