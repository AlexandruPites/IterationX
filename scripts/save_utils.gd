extends Node
class_name save_utils

static var save_path: String = 'user://save'
static var currency : float
# Called when the node enters the scene tree for the first time.

static func save_powerups(powerup_dict: Dictionary, currency_func: int) -> void:
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.WRITE)
	savefile.store_var(powerup_dict)
	savefile.store_var(currency_func)

	
static func load_powerups() -> Dictionary:
	var powerups_dict : Dictionary
	var savefile: FileAccess = FileAccess.open(save_path, FileAccess.READ)
	
	if not FileAccess.file_exists(save_path):
		powerups_dict = {
								"Max HP": [[0, 2], "Increases maximum HP of character by a fixed amount", 100],
								"HP regen": [[0, 2], "Character now regains x HP back per second", 250],
								"Movement Speed": [[0, 3], "Increase movement speed by x% percentage", 200],
								"Revival": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP", 1000],
								"Revival2": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP", 1000] 
								}
		currency = 500
	else:
		powerups_dict = savefile.get_var()
		currency = savefile.get_var()
	return {
		"currency": currency,
		"powerups": powerups_dict
	}

static func save_currency(elapsed_time : float) -> void:
	var save_dict: Dictionary = save_utils.load_powerups()
	save_dict["currency"] += elapsed_time * 0.2
	print("Added %s currency to save" % (elapsed_time * 0.2)) 
	save_utils.save_powerups(save_dict["powerups"], save_dict["currency"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
