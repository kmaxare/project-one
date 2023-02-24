extends ParallaxBackground

# Variables para controlar la velocidad de los parallax
export(float) var cloud__speed = -15

func _ready():
	pass
	
func _process(delta):
	$Clouds.motion_offset.x += cloud__speed * delta
