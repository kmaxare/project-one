extends KinematicBody2D


var velocity = Vector2()
var GRAVITY = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = 0
	
	
	velocity = move_and_slide(velocity,Vector2(0,-1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("Ingreso player")
		$Timer.start(6)
		if $Timer.time_left > 5:
			print("paso 2 segundos")
		
			#velocity.y += GRAVITY
		
