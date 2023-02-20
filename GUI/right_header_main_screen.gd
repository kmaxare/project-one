extends Control

export (Texture) var music_on
export (Texture) var music_off

var is_playing = false

onready var sound_node : Control = get_tree().get_nodes_in_group('sound')[0]

func _ready():
	is_playing = true
	music_switch()


func music_switch():
	if is_playing:
		$Buttons/MusicButton.texture_normal = music_on
		sound_node.get_node('Bgm').playing_music('PrincipalTheme')
	else:
		$Buttons/MusicButton.texture_normal = music_off
		sound_node.get_node('Bgm').stop_playing()


func _on_MusicButton_pressed():
	is_playing = !is_playing
	music_switch()
