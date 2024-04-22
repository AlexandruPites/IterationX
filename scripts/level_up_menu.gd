extends Control

var choice1 : RandomItem = null
var choice2 : RandomItem = null
var choice3 : RandomItem = null

@onready var texture_1: TextureRect = $Panel/Panel1/Choice1/Texture1
@onready var text_1: TextEdit = $Panel/Panel1/Choice1/Text1

@onready var texture_2: TextureRect = $Panel/Panel2/Choice2/Texture2
@onready var text_2: TextEdit = $Panel/Panel2/Choice2/Text2

@onready var texture_3: TextureRect = $Panel/Panel3/Choice3/Texture3
@onready var text_3: TextEdit = $Panel/Panel3/Choice3/Text3

func _ready() -> void:
	if choice1:
		texture_1.texture = load(choice1.path_to_texture)
		text_1.text = choice1.level_up_text
	if choice2:
		texture_2.texture = load(choice2.path_to_texture)
		text_2.text = choice2.level_up_text
	if choice3:
		texture_3.texture = load(choice3.path_to_texture)
		text_3.text = choice3.level_up_text

func resume() -> void:
	get_tree().paused = not get_tree().paused
	get_parent().delete_instance(self)

func _on_choice_1_pressed() -> void:
	print("choice1")
	resume()

func _on_choice_2_pressed() -> void:
	print("choice2")
	resume()

func _on_choice_3_pressed() -> void:
	print("choice3")
	resume()
