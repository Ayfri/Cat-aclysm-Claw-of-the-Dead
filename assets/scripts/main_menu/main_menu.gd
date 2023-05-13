extends Control;


const OptionsScene := preload("res://scenes/main_menu/options_menu.tscn");
const github_link := "https://github.com/Ayfri/Cat-aclysm-Claw-of-the-Dead";


func _on_start_button_pressed() -> void:
	Globals.play_button_audio();
	get_tree().change_scene_to_file("res://scenes/level/level.tscn");


func _on_options_button_pressed() -> void:
	Globals.play_button_audio();
	var option_menu := OptionsScene.instantiate();
	add_child(option_menu);


func _on_quit_button_pressed() -> void:
	Globals.play_button_audio();
	get_tree().quit();


func _on_github_button_pressed() -> void:
	Globals.play_button_audio();
	OS.shell_open(github_link);
