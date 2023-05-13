class_name PauseInterface;
extends CanvasLayer;


const OptionsScene := preload("res://scenes/main_menu/options_menu.tscn");


func _on_return_button_pressed() -> void:
	Globals.play_button_audio();
	Globals.level.toggle_pause();


func _on_restart_button_pressed() -> void:
	Globals.play_button_audio();
	get_tree().change_scene_to_file("res://scenes/level/level.tscn");
	Globals.level.toggle_pause();


func _on_quit_to_menu_button_pressed() -> void:
	Globals.play_button_audio();
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn");
	Globals.level.toggle_pause();


func _on_exit_to_desktop_button_pressed() -> void:
	Globals.play_button_audio();
	get_tree().quit();


func _on_settings_pressed() -> void:
	Globals.play_button_audio();

	var option_menu := OptionsScene.instantiate() as OptionsMenu;
	add_child(option_menu);
	option_menu.z_index = 4000;
