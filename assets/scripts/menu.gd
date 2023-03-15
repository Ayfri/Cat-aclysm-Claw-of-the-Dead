extends Control

const option = preload("res://scenes/option.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	pass # Replace with function body.


func _on_options_button_pressed():
	var option_menu = option.instantiate();
	add_child(option_menu);


func _on_quit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
