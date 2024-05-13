extends Node


var save_path: String = 'user://save'
# Called when the node enters the scene tree for the first time.

func save_powerups(powerup_dict: Dictionary, currency: int) -> void:
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	savefile.store_var(powerup_dict)
	savefile.store_var(currency)

	
func load_powerups() -> void:
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.READ)
	if not FileAccess.file_exists(save_path):
		get_parent().powerups_dict = {
								"Max HP": [[0, 2], "Increases maximum HP of character by a fixed amount", 100],
								"HP regen": [[0, 2], "Character now regains x HP back per second", 250],
								"Movement Speed": [[0, 3], "Increase movement speed by x% percentage", 200],
								"Revival": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP", 1000],
								"Revival2": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP", 1000] 
								}
		get_parent().currency = 500
	else:
		get_parent().powerups_dict = savefile.get_var()
		get_parent().currency = savefile.get_var()
	
func _ready() -> void:
	get_parent().connect("save_requested", save_powerups)
	get_parent().connect("load_requested", load_powerups)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
