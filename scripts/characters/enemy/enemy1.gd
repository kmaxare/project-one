extends KinematicBody2D

var ataque = 2
var live = true

var positionNpc = Vector2()
export (float) var displSpeed

func _physics_process(delta):
	if (live):
		positionNpc.y += Gamehundler.GRAVITY
		if ($Sprite.flip_h == true):
			positionNpc.x = -displSpeed
		else:
			positionNpc.x = displSpeed
		move_and_slide(positionNpc, Vector2(0,-1))

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)
