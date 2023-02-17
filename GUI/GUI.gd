extends CanvasLayer

onready var frames = $HBoxContainer2/Frames
onready var puntos = $HBoxContainer/VBoxContainer/Points
onready var tiempo = $HBoxContainer/VBoxContainer2/Tiempo

func _process(delta):
	puntos.text = str(GameHandler.puntos)
	tiempo.text = str(GameHandler.tiempo)
	
	frames.text = str(Engine.get_frames_per_second())
