extends Control;


const OptionsScene = preload("res://scenes/option.tscn");

@onready var buttons_sound_player := $ButtonsPlayer as AudioStreamPlayer;


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn");


func _on_options_button_pressed():
	buttons_sound_player.play();
	var option_menu := OptionsScene.instantiate();
	add_child(option_menu);


func _on_quit_button_pressed():
	get_tree().quit();
