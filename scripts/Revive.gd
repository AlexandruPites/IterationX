extends Augment
class_name Revive

func _ready() -> void:
	max_level = 2
	property_name = "revive_amount"
	base_increase = 1
	calc_increase()
	
func calc_increase() -> void:
	increase = base_increase * level
	
func update_stats(new_level : int) -> void:
	level = new_level
	calc_increase()
