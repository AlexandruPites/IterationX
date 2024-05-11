extends BoxContainer

var powerups_dict: Dictionary = {
								"Max HP": [[0, 2], "Increases maximum HP of character by a fixed amount"],
								"HP regen": [[0, 2], "Character now regains x HP back per second"],
								"Movement Speed": [[0, 3], "Increase movement speed by x% percentage"],
								"Revival": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP"],
								"Revival2": [[0, 1], "Character administers an injection\n which revitalizes him from the brink with X HP"] 
								}

var offset_x: float = 190
var offset_y: float = 29
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for powerup: String in powerups_dict:
		var panel: Panel = Panel.new()
		panel.set_custom_minimum_size(Vector2(150, 100))
		add_child(panel)
		var powerup_name: Label = Label.new()
		powerup_name.text = powerup
		panel.add_child(powerup_name)
		
		var rank: Label = Label.new()
		rank.text = "Rank %d / %d" % powerups_dict[powerup][0]
		panel.add_child(rank)
		
		var description: Label = Label.new()
		description.text = powerups_dict[powerup][1]
		description.set_size(Vector2(500, 60))
		description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		panel.add_child(description)
		
		var buy_btn: Button = Button.new()
		buy_btn.text = "Buy"
		panel.add_child(buy_btn)
	
		powerup_name.set_position(Vector2(16, 9))
		rank.set_position(Vector2(12, 66))
		description.set_position(Vector2(242, 18))
		buy_btn.set_position(Vector2(104, 64))
		
		panel.set_position(Vector2(offset_x, offset_y))

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
