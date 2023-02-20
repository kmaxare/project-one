extends Control

var theme_playing: String
var number_themes: int = 0

func _ready():
	number_themes = get_tree().get_nodes_in_group('theme').size()

func playing_music(theme: String) -> void:
	if theme_playing != null:
		stop_playing()
	theme_playing = theme
	
	var audio_node = get_tree().get_nodes_in_group('theme')
	for i in range(number_themes):
		if audio_node[i].name == theme:
			audio_node[i].playing = true
	
#	if $PrincipalTheme.name == theme:
#		$PrincipalTheme.playing = true
	
	
func stop_playing() -> void:
	var audio_current = get_tree().get_nodes_in_group('theme')
	for i in range(number_themes):
		if audio_current[i].name == theme_playing:
			audio_current[i].playing = false


