class_name PauseMenu;
extends CanvasLayer;


func _on_return_button_pressed() -> void:
	Globals.level.toggle_pause();


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn");
	Globals.level.toggle_pause();


func _on_quit_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn");
	Globals.level.toggle_pause();


func _on_exit_to_desktop_button_pressed() -> void:
	get_tree().quit();

