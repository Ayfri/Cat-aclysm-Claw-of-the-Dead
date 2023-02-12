extends Node2D;
class_name Map;

const TowerScene := preload("res://scenes/preview_tower.tscn");

@onready var editing := false:
	set = _set_editing;
@onready var editingSprite: PreviewTower;

func _set_editing(value: bool) -> void:
	$Zones.visible = value;
	editing = value;

func _process(_delta: float) -> void:
	map_editing();

func _input(event: InputEvent) -> void:
	if !editing:
		return;

	if event is InputEventMouseMotion:
		var sprite := get_positioning_sprite();
		sprite.position = event.position;
		sprite.snap_position_to_grid();
		$Grid.position = sprite.position;

func map_editing() -> void:
	if editing && Input.is_action_just_pressed('Place Tower'):
		var sprite = get_positioning_sprite();
		if !sprite.isValidPlacement:
			return;

		sprite.isPreview = false;
		
		cancel_editing();
		if Input.is_action_pressed('Bulk Place Towers'):
			activate_editing();
		return;

	if Input.is_action_just_pressed('Change Map Editing Mode'):
		if !editing:
			activate_editing();
			return;

		remove_child(editingSprite);
		cancel_editing();
		
func activate_editing() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	editing = true;
	$Grid.visible = editing;
	editingSprite = TowerScene.instantiate() as PreviewTower;
	editingSprite.isPreview = true;
	editingSprite.position = get_viewport().get_mouse_position();
	editingSprite.snap_position_to_grid();
	$Grid.position = editingSprite.position;
	add_child(editingSprite);

func cancel_editing() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	editing = false;
	$Grid.visible = editing;
	editingSprite = null;

func get_positioning_sprite() -> PreviewTower:
	var children = get_children();
	var sprite = children[children.find(editingSprite)];
	return sprite if sprite is PreviewTower else null;
