extends KinematicBody2D

#indica que el vector UP solo reconoce como suelo a lo de abajo
const VectorUP = Vector2(0,-1);
export var Vinicial = 30
export var Vparo = 320


var lookD = true
var velocity

# variables de la fuerza de salto y la gravedad del personaje
var GRAVITY = 20
var JUMPFORCE = -550
var estado = "fall"
var estadoant = "idle"

func _ready():
	velocity = Vector2.ZERO
	 

func _physics_process(_delta):
	match estado:
		"idle":
			move()
			saltar()
		"run":
			move()
			saltar()
		"jump":
			moversaltamdo()
		"fall":
			moversaltamdo()
		"hurt":
			estado 
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, VectorUP)
	#velocity.x = lerp(velocity.x,0,0.2)
	if !is_on_floor():
		if velocity.y < -1:
			estado = "jump"
		if velocity.y > 1:
			estado = "fall"
	animacion()
#	print(estado)

func move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - Vinicial, -Vparo)
		#establece que mira ala izquierda
		lookD = false
	else:
		velocity.x = 0
	if velocity.x == 0:
		estado = "idle"
	elif velocity.x > 0 or velocity.x < 0:
		estado = "run"

func moversaltamdo():
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - Vinicial, -Vparo)
		#establece que mira ala izquierda
		lookD = false
	else:
		velocity.x = 0
	if is_on_floor():
		estado = "idle"
	else:
		if velocity.y < -1:
			estado = "jump"
		if velocity.y > 1:
			estado = "fall"

func saltar():
	# metodo para el salto del personaje con la tecla "M", sobre una loza o base.
	if Input.is_action_just_pressed("m") and is_on_floor():
		velocity.y = JUMPFORCE
		estado = "jump"

func animacion():
	if estado != estadoant:
		$AnimationPlayer.play(estado)
		estadoant = estado
	if lookD:
		$Sprite.offset = Vector2(6, 0)
	else:
		$Sprite.offset = Vector2(-6, 6)
	$Sprite.flip_h = !lookD 

#Establece lo que hara el jugador al morir
func gameOver():
	pass
