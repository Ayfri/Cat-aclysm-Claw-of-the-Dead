class_name OptionsMenu;
extends Control;


var effect_bus := AudioServer.get_bus_index("SFX");
var master_bus := AudioServer.get_bus_index("Master");
var music_bus := AudioServer.get_bus_index("Music");


@onready var fullscreen_check_box := %FullscreenCheckBox as CheckBox;
@onready var effect_sound_slider := %EffectSlider as HSlider;
@onready var master_sound_slider := %MasterSlider as HSlider;
@onready var music_sound_slider := %MusicSlider as HSlider;


func _ready() -> void:
	effect_sound_slider.set_value_no_signal(AudioServer.get_bus_volume_db(effect_bus));
	master_sound_slider.set_value_no_signal(AudioServer.get_bus_volume_db(master_bus));
	music_sound_slider.set_value_no_signal(AudioServer.get_bus_volume_db(music_bus));

	fullscreen_check_box.set_pressed(get_window().get_mode() == Window.MODE_FULLSCREEN);


func _on_close_pressed() -> void:
	queue_free();


func _on_effect_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effect_bus, value);


func _on_master_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, value);


func _on_music_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, value)


func _on_fullscreen_check_box_toggled(button_pressed: bool) -> void:
	get_window().set_mode(Window.MODE_FULLSCREEN if button_pressed else Window.MODE_WINDOWED);
