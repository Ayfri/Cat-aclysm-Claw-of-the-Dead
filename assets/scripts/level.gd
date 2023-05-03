class_name Level;
extends Node2D;

const PauseScene := preload("res://scenes/pause_interface.tscn");
const starting_money := 30;
const starting_health := 10;
const starting_wave := 0;

@export var health := starting_health;
@export var money := starting_money;
@export var wave := starting_wave;

@onready var map := $Map as Map;

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
		pause_scene = PauseScene.instantiate() as PauseMenu;
		pause_scene.transform.origin = get_viewport_transform().get_scale() / 2;
		add_child(pause_scene);

	elif pause_scene != null:
		map.toggle_cursor();
		remove_child(pause_scene);


func _on_map_editing_toggle(enabled: bool) -> void:
	$Interface/TowerSelectorContainer.visible = enabled;
