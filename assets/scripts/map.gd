class_name Map;
extends Node2D;

const PreviewTowerScene := preload("res://scenes/preview_tower.tscn");
const TowerScene := preload("res://scenes/tower.tscn");

@onready var editing := false:
	set(value):
		$Zones.visible = value;
		editing = value;

@onready var editing_sprite: PreviewTower;


func _process(_delta: float) -> void:
	map_editing();


func _input(event: InputEvent) -> void:
	if !editing:
		return;

	if event is InputEventMouseMotion:
		var sprite := get_positioning_sprite();
		sprite.position = get_global_mouse_position();
		sprite.snap_position_to_grid();
		$Grid.position = sprite.position;


func activate_editing() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	editing = true;
	$Grid.visible = editing;
	editing_sprite = PreviewTowerScene.instantiate() as PreviewTower;
	editing_sprite.position = get_global_mouse_position();
	editing_sprite.snap_position_to_grid();
	$Grid.position = editing_sprite.position;
	add_child(editing_sprite);


func cancel_editing() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	editing = false;
	$Grid.visible = editing;
	editing_sprite = null;


func get_positioning_sprite() -> PreviewTower:
	var children := get_children();
	var sprite := children[children.find(editing_sprite)];
	return sprite if sprite is PreviewTower else null;


func map_editing() -> void:
	if editing && Input.is_action_just_pressed('Place Tower'):
		var sprite := get_positioning_sprite();
		if !sprite.is_valid_placement:
			return;

		var tower_sprite := TowerScene.instantiate() as Tower;
		tower_sprite.position = sprite.position;

		remove_child(sprite);
		add_child(tower_sprite);

		cancel_editing();
		if Input.is_action_pressed('Bulk Place Towers'):
			activate_editing();
		return;

	if Input.is_action_just_pressed('Change Map Editing Mode'):
		if !editing:
			activate_editing();
			return;

		remove_child(editing_sprite);
		cancel_editing();
