extends TextureProgressBar

@onready var player: Player = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = player.max_health
	value = player.max_health
	z_index = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	max_value = player.max_health
	if value == max_value:
		visible = false
	else:
		visible = true
	value = player.health
