extends Control;


const OptionsScene = preload("res://scenes/option.tscn");
const github_link = "https://github.com/Ayfri/Cat-aclysm-Claw-of-the-Dead"

@onready var buttons_sound_player := $ButtonsPlayer as AudioStreamPlayer;


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn");


func _on_options_button_pressed() -> void:
	buttons_sound_player.play();
	var option_menu := OptionsScene.instantiate();
	add_child(option_menu);


func _on_quit_button_pressed() -> void:
	get_tree().quit();


func _on_github_button_pressed() -> void:
	OS.shell_open(github_link);
