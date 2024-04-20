extends LineEdit

@onready var timer: Timer = $"../Timer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var tm : int = timer.wait_time - timer.time_left
	var minutes : int = tm / 60
	var seconds : int = tm - minutes * 60
	
	var display_minutes : String
	var display_seconds : String
	
	if minutes < 10:
		display_minutes = "0" + str(minutes)
	else:
		display_minutes = str(minutes)
		
	if seconds < 10:
		display_seconds = "0" + str(seconds)
	else:
		display_seconds = str(seconds)
	
	text = display_minutes + ":" + display_seconds
