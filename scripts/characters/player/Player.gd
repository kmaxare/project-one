extends KinematicBody2D

#indica que el vector UP solo reconoce como suelo a lo de abajo
const VectorUP = Vector2(0,-1);
export var Vinicial = 30
export var Vparo = 150 # 320
#se llama al nodo camará del nodo player y  su nodo Tween
onready var camera : Camera2D = $Camera2D
onready var tween : Tween = $Camera2D/Tween
#Variablle para generar numeros randoms 
onready var rng = RandomNumberGenerator.new()

# bandera que indica si el personaje esta mirando hacia la derecha
var lookD = true
var velocity = Vector2.ZERO
# variables de la fuerza de salto y la gravedad del personaje
var GRAVITY = 20
var JUMPFORCE = -420 #-550
var estado : String = "fall"
var estadoant : String = "idle"
var Vretroceso : float = 100
var inhabilitado : bool = false
var invunerable : bool = false
var danado : bool = false
var danadoD : bool = false #si es true el atacante esta a la derecha 

func _ready():
	Gamehundler.puntos += 7 # para propositos de prueba
	set_borders()



func _physics_process(_delta) -> void:
	match estado:
		"idle", "run":
			move()
			saltar()
		"jump", "fall":
			moversaltamdo()
		"hurt":
			funcHurt() 
	velocity.y += GRAVITY 
	animacion()
	velocity = move_and_slide(velocity, VectorUP)
	#velocity.x = lerp(velocity.x,0,0.2)
	if !is_on_floor() and !inhabilitado:
		if velocity.y < -1:
			estado = "jump"
		if velocity.y > 1:
			estado = "fall"
	smash() #verifica si golpeo enemigo 

func move():
	if Input.is_action_pressed("ui_d"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
	elif Input.is_action_pressed("ui_a"):
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
	if Input.is_action_pressed("ui_d"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
	elif Input.is_action_pressed("ui_a"):
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
	if Input.is_action_just_pressed("ui_w") and is_on_floor():
		velocity.y = JUMPFORCE
		estado = "jump"
func funcHurt():
	if !inhabilitado:
		estado = "idle"
func animacion():
	if danado:
		estado = "hurt"
		danado = false
		inhabilitado = true
		invunerable = true
		$Timer.start(0.74)
		if danadoD:
			velocity.x += -Vretroceso
			lookD = true
		else:
			velocity.x += Vretroceso
			lookD = false
	#se actualiza el estado anterior 
	if estado != estadoant:
		$AnimationPlayer.play(estado)
		estadoant = estado
	if lookD:
		$CollisionShape2D.position = Vector2(2.5, 1.5)
	else:
		$CollisionShape2D.position = Vector2(-2.5, 1.5)
	$Sprite.flip_h = !lookD 

func damageReceived(damage, positionEnemy : Vector2):
	if !invunerable:
		#es el tiempo, potecia y prioridad del shake de camara
		screen_shake(0.5, 0.3, 2)
		danado = true
		if global_position.x < positionEnemy.x:
			danadoD = true
		else:
			danadoD = false
		if Gamehundler.puntos >= damage:
			Gamehundler.puntos -= damage
		else:
			Gamehundler.gameOver()
			
#se llama por medio del animation player cuando se termina la animacion
#de hurt, pra marcar que el jugador vuelve a estar habilitado de usarse
func postHurt():
	inhabilitado = false

func smash() -> void:
	if($RaycastBottLeft.is_colliding() or $RaycastBottRight.is_colliding()):
		var object_coll
		if ($RaycastBottLeft.is_colliding()):
			object_coll = $RaycastBottLeft.get_collider()
		elif ($RaycastBottRight.is_colliding()):
			object_coll = $RaycastBottRight.get_collider()
		
		if (object_coll.is_in_group("enemy")):
			object_coll.death('crushed')
			velocity.y = JUMPFORCE / 2 # Pequeño salto

func _on_Timer_timeout():
	invunerable = false
	pass # Replace with function body.

#Funcion para generar numeros randoms
func random(minimo, maximo):
	rng.randomize()
	var random = rng.randf_range(minimo, maximo)
	return random

#se cambia el offset de la camara para sacudir la patalla
func shake_camera(shake_pomer) -> void:
	camera.offset_h = random(-shake_pomer, shake_pomer)
	camera.offset_v = random(-shake_pomer, shake_pomer)
	
#se debe de aplicar tiemp de ejecución, intensidad de movimiento
#y la prioridad de la sacudida de camará
func screen_shake(shake_length : float, shake_power : float, shake_priority : int) -> void:
	var current_shake_priority : int = 0
	if shake_priority > current_shake_priority:
		tween.interpolate_method(
			self, #es el objeto a afectar
			"shake_camera", #metodo o funcion afectada
			shake_power, #valor inicial
			0, #valor final, es 0 porque se regresa el offset al inicio
			shake_length, #tiempo que transcurre entre uno y otro
			Tween.TRANS_SINE, #transcision inicial
			Tween.EASE_OUT #Transcision final 
		)
		tween.start()

#Ajusta las esquinas de la camara con respectos a los nodos 
#Position2D corner TL (Top Left) y cornerBR (Bottom Right)
func set_borders() -> void:
	#El if checa si existen estos nodos en la escena actual
	if has_node("../settings/cornerTL") and has_node("../settings/cornerBR"):
	#si existeen se ajustan las posiciones
		var cornerTL : Position2D = get_node("../settings/cornerTL")
		var cornerBR : Position2D = get_node("../settings/cornerBR")
		camera.limit_bottom = cornerBR.global_position.y
		camera.limit_right = cornerBR.global_position.x
		camera.limit_top = cornerTL.global_position.y
		camera.limit_left = cornerTL.global_position.x
	else:
		camera.limit_bottom = 10000
		camera.limit_right = 10000
		camera.limit_top = -1000
		camera.limit_left = -1000
		print("NO HAY NODO SETTINGS")
