extends PanelContainer
class_name InventorySlot

@onready var texture_rect: TextureRect = $TextureRect

func display(itemPath : String) -> void:
	texture_rect.texture = load(itemPath)
