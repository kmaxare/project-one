extends Camera2D

onready var player = get_tree().get_nodes_in_group("player")[0]
var rng = RandomNumberGenerator.new()

func _physics_process(delta):
	position.y = player.position.y
	
	if player.position.x + 200 > position.x:
		position.x = player.position.x + 200

func random(minimo, maximo):
	rng.randomize()
	var random = rng.randf_range(minimo, maximo)
	return random
	pass
	
func shake_camera(shake_power) -> void:
	offset_h = random(-shake_power, shake_power)
	offset_v = random(-shake_power, shake_power)

func screen_shake(shake_length : float, shake_power : float, shake_priority : int) -> void:
	var current_shake_priority : int = 0
	if shake_priority > current_shake_priority:
		$Tween.interpolate_method(
			self, #objeto afectado
			"shake_camera", #Método o función afectado
			shake_power, #valor inicial
			0, #valor final, es 0 porque queremos que regrese a su valor original
			shake_length, #Tiempo que transcurre entre uno y otro
			Tween.TRANS_SINE, #transcisión inicial
			Tween.EASE_OUT #Transcisión final
		)
		$Tween.start()

