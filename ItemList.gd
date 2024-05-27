extends ItemList

var format_string_weapon : String = "res://images/weapons/%s.png"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_columns = 6


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.clear()
	self.item_count = 0
	for weapon: String in UpgradeHandler.inventory:
		self.add_icon_item(load(format_string_weapon % weapon))
		self.item_count += 1
