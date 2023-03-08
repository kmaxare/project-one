extends Control

var number_sfx: int = 0

func _ready():
	number_sfx = get_tree().get_nodes_in_group('sfx').size()

func playing_sfx(theme: String) -> void:
	var audio_node = get_tree().get_nodes_in_group('sfx')
	for i in range(number_sfx):
		if audio_node[i].name == theme:
			audio_node[i].playing = true
			return
