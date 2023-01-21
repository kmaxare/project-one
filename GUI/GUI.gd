extends CanvasLayer

onready var puntos = $HBoxContainer/VBoxContainer/puntos
onready var tiempo = $HBoxContainer/VBoxContainer2/tiempo
onready var GuiGameOver = $GameOverGUIbasica

func _ready():
	pantallaGameOver()
	pass

func _process(delta):
	if !Gamehundler.estadoGameOver:
		puntos.text = str(Gamehundler.puntos)
		tiempo.text = str(Gamehundler.tiempo)
	else:
		if Input.is_action_pressed("m"):
			Gamehundler.estadoGameOver = false
			get_tree().paused = false
			get_tree().reload_current_scene()
	pantallaGameOver()
	
func pantallaGameOver() -> void:
	GuiGameOver.visible = Gamehundler.estadoGameOver
	pass
	
