extends Node;


## TODO : Remove debug tools.
func _unhandled_key_input(event: InputEvent) -> void:
	if !event is InputEventKey: return;
	var key_event := event as InputEventKey;

	if key_event.as_text_physical_keycode() == "Z" && !Globals.level.finished:
		Globals.level.win();
