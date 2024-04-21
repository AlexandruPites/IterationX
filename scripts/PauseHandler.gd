extends Control

var pause : Resource = preload("res://scenes/pause_screen.tscn")
var pause_instance: Node = null
@onready var player: Player = $"../Player"
@onready var pause_button : Button = $"../Camera2D/Button"

func _on_button_pressed() -> void:
	pause_instance = pause.instantiate()
	pause_instance.position = player.position
	pause_instance.z_index = 2
	add_child.call_deferred(pause_instance)
	get_tree().paused = not get_tree().paused

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_button.pressed.connect(_on_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and pause_instance == null:
		_on_button_pressed()

func delete_instance(param: Node) -> void:
	pause_instance = null
	param.queue_free()
