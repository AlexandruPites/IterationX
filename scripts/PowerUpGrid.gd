extends BoxContainer

var buy_btns_and_labels: Dictionary = {
								"Max HP": [],
								"HP regen": [],
								"Movement Speed": [],
								"Revival": [],
								"Revival2":  []
						}

var powerups_dict: Dictionary
var currency: int = 500

signal save_requested(powerups_dict: Dictionary, currency: int)
signal load_requested()

var offset_x: float = 190
var offset_y: float = 29
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_requested.emit()
	for powerup: String in powerups_dict:
		var panel: Panel = Panel.new()
		panel.set_custom_minimum_size(Vector2(150, 100))
		add_child(panel)
		var powerup_name: Label = Label.new()
		powerup_name.text = powerup
		panel.add_child(powerup_name)
		
		var rank: Label = Label.new()
		buy_btns_and_labels[powerup].append(rank)
		rank.text = "Rank %d / %d" % powerups_dict[powerup][0]
		panel.add_child(rank)
		
		var description: Label = Label.new()
		description.text = powerups_dict[powerup][1]
		description.set_size(Vector2(500, 60))
		description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		panel.add_child(description)
		
		var buy_btn: Button = Button.new()
		buy_btns_and_labels[powerup].append(buy_btn)
		buy_btn.pressed.connect(_on_buy_pressed.bind(powerup))	
		buy_btn.text = "Buy"
		buy_btn.name = powerup
		panel.add_child(buy_btn)
		
		var price: Label = Label.new()
		price.text = "Price: %d" % powerups_dict[powerup][2]
		buy_btns_and_labels[powerup].append(price)
		panel.add_child(price)
		
		powerup_name.set_position(Vector2(16, 9))
		rank.set_position(Vector2(12, 66))
		description.set_position(Vector2(242, 18))
		price.set_position(Vector2(642, 35))
		buy_btn.set_position(Vector2(104, 64))
		
		panel.set_position(Vector2(offset_x, offset_y))

func _on_buy_pressed(powerup: String) -> void:
	var price: int = powerups_dict[powerup][2]
	if powerups_dict[powerup][0][0] < powerups_dict[powerup][0][1] and currency < price:
		print("not enough currency")
	
	if powerups_dict[powerup][0][0] < powerups_dict[powerup][0][1] and currency >= price:
		powerups_dict[powerup][0][0] += 1
		currency -= price
		price *= 2
		powerups_dict[powerup][2] = price
	
	# maxed out rank, should not display any price
	if powerups_dict[powerup][0][0] == powerups_dict[powerup][0][1]:
		if buy_btns_and_labels[powerup][2] != null:
			buy_btns_and_labels[powerup][2].queue_free()
		else:
			return
	
	
		
	buy_btns_and_labels[powerup][0].text = "Rank %d / %d" % powerups_dict[powerup][0]
	buy_btns_and_labels[powerup][2].text =  "Price: %d" % price
	
	
	save_requested.emit(powerups_dict, currency)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
