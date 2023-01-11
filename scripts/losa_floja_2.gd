extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_RigidBody2D_body_entered(body):
	if body.is_in_group("player"):
		print("Ingreso")
		#$RigidBody2D.mode = RigidBody2D.MODE_RIGID
