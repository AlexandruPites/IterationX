extends GridContainer
class_name InventoryUI

var slot_resource : Resource = preload("res://scenes/item_slot.tscn")
var format_string_weapon : String = "res://images/weapons/%s.png"
var format_string_augment : String = "res://images/augments/%s.png"

var slots : Array[InventorySlot] = []
var last_slot_occupied : int = 0

func _ready() -> void:
	for i in range(columns):
		var slot : InventorySlot = slot_resource.instantiate()
		slots.append(slot)
		add_child(slot)

func add_item(item_name : String, is_weapon : bool) -> void:
	var format_string : String
	if is_weapon:
		format_string = format_string_weapon
	else:
		format_string = format_string_augment
	slots[last_slot_occupied].display(format_string % item_name)
	last_slot_occupied += 1
