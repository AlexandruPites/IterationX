extends Control

var choice1 : RandomItem = null
var choice2 : RandomItem = null
var choice3 : RandomItem = null

@onready var texture_1: TextureRect = $Panel/Panel1/Choice1/Texture1
@onready var text_1: TextEdit = $Panel/Panel1/Choice1/Text1
@onready var button_1: Button = $Panel/Panel1/Choice1

@onready var texture_2: TextureRect = $Panel/Panel2/Choice2/Texture2
@onready var text_2: TextEdit = $Panel/Panel2/Choice2/Text2
@onready var button_2: Button = $Panel/Panel2/Choice2

@onready var texture_3: TextureRect = $Panel/Panel3/Choice3/Texture3
@onready var text_3: TextEdit = $Panel/Panel3/Choice3/Text3
@onready var button_3: Button = $Panel/Panel3/Choice3

var format_string_weapon : String = "res://images/weapons/%s.png"
var format_string_augment : String = "res://images/augments/%s.png"
var format_string : String

func _ready() -> void:
	if !choice1 and !choice2 and !choice3:
		resume(null)
	
	if choice1:
		format_string = format_string_weapon if choice1.is_weapon else format_string_augment
		texture_1.texture = load(format_string % choice1.item_name)
		text_1.text = choice1.level_up_text
	else:
		button_1.disabled = true
		button_1.visible = false
		
	if choice2:
		format_string = format_string_weapon if choice2.is_weapon else format_string_augment
		texture_2.texture = load(format_string % choice2.item_name)
		text_2.text = choice2.level_up_text
	else:
		button_2.disabled = true
		button_2.visible = false
		
	if choice3:
		format_string = format_string_weapon if choice3.is_weapon else format_string_augment
		texture_3.texture = load(format_string % choice3.item_name)
		text_3.text = choice3.level_up_text
	else:
		button_3.disabled = true
		button_3.visible = false

func resume(chosen : RandomItem) -> void:
	get_tree().paused = not get_tree().paused
	get_parent().delete_instance(self, chosen)

func _on_choice_1_pressed() -> void:
	resume(choice1)

func _on_choice_2_pressed() -> void:
	resume(choice2)

func _on_choice_3_pressed() -> void:
	resume(choice3)
