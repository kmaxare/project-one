extends KinematicBody2D

#vector para que se reconozca como suelo la parte de abajo
#del escenario usando move_and_slide
const VectorUP = Vector2(0,-1);
# velocidad inicial y de paro del personaje
export var Vinitial = 30
export var Vstop = 150 # 320
#se llama al nodo camará del nodo player y  su nodo Tween
onready var camera : Camera2D = $Camera2D
onready var tween : Tween = $Camera2D/Tween
onready var timer_coyote : Timer = $timer_coyote
#Variablle para generar numeros randoms 
onready var rng = RandomNumberGenerator.new()

# bandera que indica si el personaje esta mirando hacia la derecha
var look_R = true
var velocity = Vector2.ZERO
# variables de la fuerza de salto y la gravedad del personaje
var GRAVITY = 20
var JUMPFORCE = -420 #-550
# Mantiene los valores del estado actual y el estado anterior
# del personaje
var state : String = "fall"
var prev_state : String = "idle"
var Vknockback : float = 100
var disabled : bool = false
var invulnerable : bool = false
#bandera que indica si el personaje fue dañado
var damaged : bool = false
# bandera que indica si el personaje fue dañado por la derecha
var damaged_R : bool = false 
# bandera que indica que esta activo el coyote time 
var coyote_time : bool = false
# bandera que indica que esta activo el primer salto 
var first_jump : bool = false
# bandera que indica que esta activo el segundo salto 
var second_jump : bool = false

func _ready():
	Gamehundler.puntos += 7 # para propositos de prueba
	set_borders()
	pass

func _physics_process(_delta):
	match state:
		"idle", "run":
			_on_the_floor()
		"jump", "fall":
			_on_the_air()
		"hurt":
			func_hurt() 
	velocity.y += GRAVITY 
	animation()
	velocity = move_and_slide(velocity, VectorUP)
	if !is_on_floor() and !disabled:
		if velocity.y < -1:
			state = "jump"
		if velocity.y > 1:
			state = "fall"
	smash() #verifica si golpeo enemigo 

func _on_the_floor():
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + Vinitial, Vstop)
		#establece que mira ala derecha
		look_R = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - Vinitial, -Vstop)
		#establece que mira ala izquierda
		look_R = false
	else:
		velocity.x = 0
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		_jump()
		first_jump = true

func _jump() -> void:
	velocity.y = JUMPFORCE
	state = "jump"

func _on_the_air() -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + Vinitial, Vstop)
		#establece que mira ala derecha
		look_R = true
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - Vinitial, -Vstop)
		#establece que mira ala izquierda
		look_R = false
	else:
		velocity.x = 0
	# Spregunta si se ha presionado el boton de salto
	if Input.is_action_just_pressed("ui_jump"):
		# pregunta si solo se ha tomado el primer salto
		if first_jump and !second_jump:
			_jump()
			second_jump = true
		# pregunta si esta activo el coyote time
		if coyote_time:
			_jump()
			first_jump = true
	if is_on_floor():
		state = "idle"
#	else:
#		if velocity.y < -1:
#			state = "jump"
#		if velocity.y > 1:
#			state = "fall"
	
func func_hurt():
	if !disabled:
		state = "idle"

# actualiza las variables relacionadas al salto, de 
# acuerdo a los valores de estado del jugador
func _jump_check() -> void:
	match state:
		"idle", "run":
# reestablece las variables a su estado por default
			first_jump = false
			second_jump = false
			coyote_time = false
		"fall":
# si first jump es falso, significa que todavía no ha saltado
			if !first_jump:
		#entonces se activa el coyote time
				timer_coyote.start(0.3)
				coyote_time = true

func animation():
	if damaged:
		state = "hurt"
		damaged = false
		disabled = true
		invulnerable = true
		$timer_invunerable.start(0.74)
		if damaged_R:
			velocity.x += -Vknockback
			look_R = true
		else:
			velocity.x += Vknockback
			look_R = false
	# SE VERIFICA QUE SE HAYA CAMBIADO DE ESTADO
	if state != prev_state:
		_jump_check()
		$AnimationPlayer.play(state)
		prev_state = state
	if look_R:
		$CollisionShape2D.position = Vector2(2.5, 1.5)
	else:
		$CollisionShape2D.position = Vector2(-2.5, 1.5)
	$Sprite.flip_h = !look_R 

#Esta funciona ocurre cuando un enemigo cruza al jugador
func damageReceived(damage, positionEnemy : Vector2):
	#verifica que no este en modo invulnerable
	if !invulnerable:
	# activa la bandera de que ya recibio daño, para que no reciba 
	# más daño hasta que la bandera cambie a false de nuevo
		damaged = true
#es el tiempo en segundos, potecia y prioridad (importancia de
# ejecución) del shake (sacudida) de camara
		screen_shake(0.3, 0.1, 2)
	# EStablece desde que lado se recibe el daño 
		if global_position.x < positionEnemy.x:
			damaged_R = true #derecha
		else:
			damaged_R = false #izquierda
		#se restan los puntos al jugador
		if Gamehundler.puntos >= damage:
			Gamehundler.puntos -= damage
		else:
			Gamehundler.gameOver()

# se llama por medio del animation player cuando se termina la 
# animacion de hurt, para marcar que el jugador vuelve a estar 
# habilitado para controlarse
func postHurt() -> void:
	disabled = false

func smash() -> void:
	if($RaycastBott.is_colliding()):
		var object_coll = $RaycastBott.get_collider()
		if (object_coll.is_in_group("enemy")):
			object_coll.death('crushed')
			velocity.y = JUMPFORCE / 2 # Pequeño salto

#indica que el temporizador de invunerabilidad termino
func _on_timer_invunerable_timeout():
	invulnerable = false
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
	
#se debe de aplicar tiempo de ejecución, intensidad de movimiento
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
# Position2D corner TL (Top Left) y cornerBR (Bottom Right)
func set_borders() -> void:
	#El if checa si existen estos nodos en la escena actual
	if has_node("../settings/cornerTL") and has_node("../settings/cornerBR"):
	#SI existen los nodos entonces se ajustan los limites
	#de la camara 
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

# pasado el tiempo desactiva bandera del coyote time
func _on_timer_coyote_timeout():
	coyote_time = false
	pass # Replace with function body.
