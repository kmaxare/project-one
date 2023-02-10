extends CanvasLayer

onready var frames = $HBoxContainer2/frames
onready var puntos = $HBoxContainer/VBoxContainer/puntos
onready var tiempo = $HBoxContainer/VBoxContainer2/tiempo

func _process(delta):
	puntos.text = str(Gamehundler.puntos)
	tiempo.text = str(Gamehundler.tiempo)
	
	frames.text = str(Engine.get_frames_per_second())
