extends CanvasLayer

onready var frames = $HBoxContainer2/frames
onready var puntos = $HBoxContainer/VBoxContainer/puntos
onready var tiempo = $HBoxContainer/VBoxContainer2/tiempo

func _process(delta):
	puntos.text = str(GameHandler.puntos)
	tiempo.text = str(GameHandler.tiempo)
	
	frames.text = str(Engine.get_frames_per_second())
