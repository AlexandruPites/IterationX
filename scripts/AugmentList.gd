extends ItemList

var format_string_weapon : String = "res://images/augments/%s.png"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_columns = 6
	self.get_v_scroll_bar().visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.get_v_scroll_bar().visible = false
	self.clear()
	self.item_count = 0
	for augment: String in UpgradeHandler.augments:
		self.add_icon_item(load(format_string_weapon % augment))
		self.item_count += 1
