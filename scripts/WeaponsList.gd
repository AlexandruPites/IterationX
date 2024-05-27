extends ItemList

class_name WeaponsList

var format_string_weapon : String = "res://images/weapons/%s.png"
var katana: Texture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.max_columns = 0
	self.get_v_scroll_bar().visible = false
	self.get_v_scroll_bar().modulate.a = 0

func add_weapon_to_list(weapon_name: String) -> void:
	self.add_icon_item(load(format_string_weapon % weapon_name), false)
	self.item_count += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
