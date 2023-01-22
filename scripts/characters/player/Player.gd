extends KinematicBody2D

#indica que el vector UP solo reconoce como suelo a lo de abajo
const VectorUP = Vector2(0,-1);
export var Vinicial = 30
export var Vparo = 320

var lookD = true
var velocity = Vector2.ZERO
# variables de la fuerza de salto y la gravedad del personaje
var GRAVITY = 20
var JUMPFORCE = -550
var estado = "fall"
var estadoant = "idle"
var Vretroceso = 100
var inhabilitado : bool = false
var invunerable : bool = false
var danado : bool = false
var danadoD : bool = false #si es true el atacante esta a la derecha 

func _ready():
	pass

func _physics_process(_delta):
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
	if Input.is_action_just_pressed("m") and is_on_floor():
		velocity.y = JUMPFORCE
		estado = "jump"
func funcHurt():
	if !inhabilitado:
		estado = "idle"
		$AudioStreamPlayer.playing = false
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
		danado = true
		if global_position.x < positionEnemy.x:
			danadoD = true
		else:
			danadoD = false
		if Gamehundler.puntos >= damage:
			Gamehundler.puntos -= damage
			get_tree().get_nodes_in_group("camera")[0].screen_shake(0.15, 0.5, 10)
			$AudioStreamPlayer.playing = true
			#$AudioStreamPlayer.playing = false
		else:
			Gamehundler.gameOver()
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
