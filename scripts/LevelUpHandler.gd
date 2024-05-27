extends Control

var pause : Resource = preload("res://scenes/level_up_menu.tscn")
var level_up_instance: Node = null
var dummy : TextureProgressBar

@onready var player: Player = $"../Player"
@onready var weapon_handler: UpgradeHandler = $"../UpgradeHandler"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dummy = get_node("/root/Game/Camera2D/DummyBar")
	dummy.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug_level") and level_up_instance == null:
		create_instance()
				
func create_instance() -> void:
	var chosen : Array[RandomItem] = weapon_handler.choose_level_ups()
	dummy.visible = true
	level_up_instance = pause.instantiate()
	
	level_up_instance.choice1 = chosen[0]
	level_up_instance.choice2 = chosen[1]
	level_up_instance.choice3 = chosen[2]
	
	level_up_instance.position = player.position
	level_up_instance.z_index = 2
	add_child.call_deferred(level_up_instance)
	get_tree().paused = not get_tree().paused

func delete_instance(param: Node, upgrade : RandomItem) -> void:
	if upgrade:
		if upgrade.is_weapon:
			weapon_handler.update_weapon_level(upgrade)
		else:
			weapon_handler.update_augment_level(upgrade)
	level_up_instance = null
	dummy.visible = false
	param.queue_free()

func _on_player_level_up() -> void:
	create_instance()
