extends TileMap

func _ready():
	#remove_tile()
	pass
func remove_tile(pos):
	var player_pos : Vector2 = world_to_map(pos)
	set_cell(player_pos.x, player_pos.y, -1)
	$AnimationPlayer.play("destruction")
	TileSet.get_pause(true)
	TileSet.get_pause(true)
