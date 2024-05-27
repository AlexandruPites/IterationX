extends ItemList

var format_string_augment : String = "res://images/augments/%s.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_columns = 0
	self.get_v_scroll_bar().visible = false
	self.get_v_scroll_bar().modulate.a = 0
	

func add_augment_to_list(augment_name: String) -> void:
	self.add_icon_item(load(format_string_augment % augment_name), false)
	self.item_count += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.

