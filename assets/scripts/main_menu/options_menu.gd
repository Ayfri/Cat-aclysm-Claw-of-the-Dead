extends Control;


var effect_bus := AudioServer.get_bus_index("SFX");
var master_bus := AudioServer.get_bus_index("Master");
var music_bus := AudioServer.get_bus_index("Music");



func _on_close_pressed() -> void:
	queue_free();


func _on_effect_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effect_bus, true);

	if value == 0:
		AudioServer.set_bus_mute(effect_bus, true);
	else:
		AudioServer.set_bus_mute(effect_bus, false);


func _on_master_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, true);

	if value == 0:
		AudioServer.set_bus_mute(master_bus, true);
	else:
		AudioServer.set_bus_mute(master_bus, false);


func _on_music_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, true);

	if value == 0:
		AudioServer.set_bus_mute(music_bus, true);
	else:
		AudioServer.set_bus_mute(music_bus, false);
