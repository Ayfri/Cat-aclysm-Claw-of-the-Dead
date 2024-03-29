class_name OptionsMenu;
extends Control;


var effect_bus := AudioServer.get_bus_index("SFX");
var master_bus := AudioServer.get_bus_index("Master");
var music_bus := AudioServer.get_bus_index("Music");


@onready var fullscreen_check_box := %FullscreenCheckBox as CheckBox;
@onready var effect_sound_slider := %EffectSlider as HSlider;
@onready var master_sound_slider := %MasterSlider as HSlider;
@onready var music_sound_slider := %MusicSlider as HSlider;
@onready var secret_sounds_check_box := %SecretSoundsCheckBox as CheckBox;
@onready var test_audio_player := $TestAudioPlayer as AudioStreamPlayer;


func _ready() -> void:
	effect_sound_slider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(effect_bus)));
	master_sound_slider.set_value_no_signal( db_to_linear(AudioServer.get_bus_volume_db(master_bus)));
	music_sound_slider.set_value_no_signal( db_to_linear(AudioServer.get_bus_volume_db(music_bus)));

	fullscreen_check_box.set_pressed(get_window().get_mode() == Window.MODE_FULLSCREEN);
	secret_sounds_check_box.set_pressed(SecretSounds.active);


func _on_close_pressed() -> void:
	Globals.play_button_audio();
	queue_free();


func _on_effect_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effect_bus, linear_to_db(value));
	test_audio_player.play();


func _on_master_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value));


func _on_music_sound_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))


func _on_fullscreen_check_box_toggled(button_pressed: bool) -> void:
	get_window().set_mode(Window.MODE_FULLSCREEN if button_pressed else Window.MODE_WINDOWED);
	Globals.play_button_audio();


func _on_secret_sounds_check_box_toggled(button_pressed: bool) -> void:
	if button_pressed: SecretSounds.activate();
	else: SecretSounds.deactivate();
	Globals.play_button_audio();
