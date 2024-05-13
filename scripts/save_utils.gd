extends Node


var save_path: String = 'user://save'
# Called when the node enters the scene tree for the first time.

func save_powerups(powerup_dict: Dictionary) -> void:
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	savefile.store_var(powerup_dict)

	
func load_powerups(powerup_dict: Dictionary) -> void:
	if not FileAccess.file_exists(save_path):
		return
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.READ)
	powerup_dict = savefile.get_var(true)
	get_node('root/Game/PowerUpGrid').currency = savefile.get_var()
	
func _ready() -> void:
	get_parent().connect("save_requested", save_powerups)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
