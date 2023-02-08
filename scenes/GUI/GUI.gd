extends CanvasLayer

onready var points = $HBoxContainer/VBoxContainer/points
onready var time = $HBoxContainer/VBoxContainer2/time

func _process(delta):
	points.text = str(game_handler.points)
	time.text = str(game_handler.time)
