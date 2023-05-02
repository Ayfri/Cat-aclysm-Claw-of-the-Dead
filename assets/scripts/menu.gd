extends Control

const option = preload("res://scenes/option.tscn");

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_options_button_pressed():
	$AudioStreamPlayer2.play()
	var option_menu = option.instantiate();
	add_child(option_menu);



func _on_quit_button_pressed():
	get_tree().quit()
