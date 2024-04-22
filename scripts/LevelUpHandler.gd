extends Control

var pause : Resource = preload("res://scenes/level_up_menu.tscn")
var level_up_instance: Node = null
@onready var player: Player = $"../Player"
var dummy : TextureProgressBar



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dummy = get_node("/root/Game/Camera2D/DummyBar")
	dummy.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_level") and level_up_instance == null:
		create_instance()
		
func create_instance() -> void:
	dummy.visible = true
	level_up_instance = pause.instantiate()
	level_up_instance.position = player.position
	level_up_instance.z_index = 2
	add_child.call_deferred(level_up_instance)
	get_tree().paused = not get_tree().paused

func delete_instance(param: Node) -> void:
	level_up_instance = null
	dummy.visible = false
	param.queue_free()

func _on_player_level_up() -> void:
	create_instance()
