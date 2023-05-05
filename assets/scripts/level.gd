class_name Level;
extends Node2D;


const PauseScene := preload("res://scenes/pause_interface.tscn");
const starting_money := 30;
const starting_health := 10;
const starting_wave := 0;

@export var health := starting_health;
@export var money := starting_money;
@export var muffled_sound_effect: AudioEffect = null;
@export var wave := starting_wave;

@onready var map := $Map as Map;
@onready var music_bus_index := AudioServer.get_bus_index(($MusicPlayer as AudioStreamPlayer).bus);
@onready var music_player := $MusicPlayer as AudioStreamPlayer;
@onready var tower_selector_container := $Interface/TowerSelectorContainer as Panel;

var pause_scene: PauseMenu = null;


func _ready() -> void:
	Globals.level = self;


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('Escape Menu'):
		toggle_pause();


func toggle_pause() -> void:
	map.get_tree().paused = !map.get_tree().paused;

	if map.get_tree().paused:
		if map.editing: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		AudioServer.add_bus_effect(music_bus_index, muffled_sound_effect, 0);

		pause_scene = PauseScene.instantiate() as PauseMenu;
		pause_scene.transform.origin = get_viewport_transform().get_scale() / 2;
		add_child(pause_scene);

	elif pause_scene != null:
		music_player.volume_db = 0;
		map.toggle_cursor();
		remove_child(pause_scene);
		AudioServer.remove_bus_effect(music_bus_index, 0);


func _on_map_editing_toggle(enabled: bool) -> void:
	tower_selector_container.visible = enabled;
