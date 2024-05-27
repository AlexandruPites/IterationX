extends Node
class_name StatIncrease

#in percentage 50% = 0.5
var health_increase : float = 0
var speed_increase : float = 0
var projectile_speed_increase : float = 0
var damage_increase : float = 0
var area_increase : float = 0
var knockback_increase : float = 0
var regen_increase : float = 0
var magnet_increase : float = 0

#additive
var revive_amount : int = 0

func calculate_increases(augments : Array) -> void:
	for aug : Augment in augments:
		set(aug.property_name, aug.increase)
		
func update_property(augment : Augment) -> void:
	set(augment.property_name, augment.increase)
