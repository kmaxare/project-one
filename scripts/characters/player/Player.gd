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

func _ready():
	velocity = Vector2.ZERO
	 
	

func _physics_process(_delta):
	move()
	#velocity = move_and_slide(velocity, VectorUP)
	
	# metodo para el salto del personaje con la tecla "M", sobre una loza o base.
	if Input.is_action_just_pressed("m") and is_on_floor():
		velocity.y = JUMPFORCE
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.2)
	

func move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
#		$AnimationPlayer.play("Walk")
#		$Sprite.flip_h = true 
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - Vinicial, -Vparo)
		#establece que mira ala izquierda
		lookD = false
#		$AnimationPlayer.play("Walk")
#		$Sprite.flip_h = true 
	else:
		velocity.x = 0
	
	if velocity.x == 0:
		#establece que esta en estado idle
		velocity.x = 0
#		$AnimationPlayer.play("Idle")
	
	
#Establece lo que hara el jugador al morir
func gameOver():
	pass
