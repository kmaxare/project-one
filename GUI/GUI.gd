extends CanvasLayer

onready var frames = $HBoxContainer2/Frames
onready var points = $HBoxContainer/VBoxContainer/Points
onready var tiempo = $HBoxContainer/VBoxContainer2/Tiempo

func _process(delta):
	points.text = str(GameHandler.points)
	tiempo.text = str(GameHandler.time)
	
	frames.text = str(Engine.get_frames_per_second())
