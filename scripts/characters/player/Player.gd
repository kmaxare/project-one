extends KinematicBody2D

#indica que el vector UP solo reconoce como suelo a lo de abajo
const VectorUP = Vector2(0,-1);
export var Vinicial = 30
export var Vparo = 320

var lookD = true
var velocity

func _ready():
	velocity = Vector2.ZERO

func _physics_process(_delta):
	move()
	velocity = move_and_slide(velocity, VectorUP)

func move():
	if Input.is_action_pressed("ui_d"):
		velocity.x = min(velocity.x + Vinicial, Vparo)
		#establece que mira ala derecha
		lookD = true
#		$AnimationPlayer.play("Walk")
#		$Sprite.flip_h = true 
	elif Input.is_action_pressed("ui_a"):
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
	
	
	
	
