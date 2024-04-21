extends Control

var pause : Resource = preload("res://scenes/pause_screen.tscn")
var pause_instance: Node = null
@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and pause_instance == null:
		var pause_instance: Node = pause.instantiate()
		pause_instance.position = player.position
		add_child.call_deferred(pause_instance)
		get_tree().paused = not get_tree().paused
		
		
func delete_instance(param: Node) -> void:
	pause_instance = null
	param.queue_free()
