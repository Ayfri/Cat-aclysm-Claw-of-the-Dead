extends Node;


var IS_DEBUG := OS.has_feature("debug");

## TODO : Remove debug tools.
func _unhandled_key_input(event: InputEvent) -> void:
	if !IS_DEBUG || Globals.level == null: return;

	if Globals.level.finished || !event is InputEventKey: return;
	var key_event := event as InputEventKey;

	if key_event.as_text_physical_keycode() == "Z": Globals.level.win();
	if key_event.as_text_physical_keycode() == "X": Globals.level.lose();
	if key_event.as_text_physical_keycode() == "Q": Globals.level.money += 5;
