extends Node2D

const brick_size : int = 64
var brick_resource : Resource = preload("res://scenes/prison.tscn")

func spawn_prison(pos : Vector2, size : int) -> void:
	var curr_pos : Vector2 = pos - brick_size * Vector2(size / 2, size / 2)
	
	for i in range(size):
		var brick : StaticBody2D = brick_resource.instantiate()
		curr_pos += brick_size * Vector2(1, 0)
		brick.position = curr_pos
		add_child(brick)
	
	for i in range(size):
		var brick : StaticBody2D = brick_resource.instantiate()
		curr_pos += brick_size * Vector2(0, 1)
		brick.position = curr_pos
		add_child(brick)
		
	for i in range(size):
		var brick : StaticBody2D = brick_resource.instantiate()
		curr_pos += brick_size * Vector2(-1, 0)
		brick.position = curr_pos
		add_child(brick)
		
	for i in range(size):
		var brick : StaticBody2D = brick_resource.instantiate()
		curr_pos += brick_size * Vector2(0, -1)
		brick.position = curr_pos
		add_child(brick)
		
func jailbreak() -> void:
	var chld : Array = get_children()
	for c : StaticBody2D in chld:
		c.queue_free()
