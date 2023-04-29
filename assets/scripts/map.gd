class_name Map;
extends Node2D;

signal map_editing_toggle(enabled: bool);

const PreviewTowerScene := preload("res://scenes/towers/preview_tower.tscn");

var current_tower_index := 0;


@onready var editing := false:
	set(value):
		$Zones.visible = value;
		editing = value;
		map_editing_toggle.emit(value);

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
	editing_sprite.stats = Globals.tower_stats[current_tower_index];
	editing_sprite.position = get_global_mouse_position();
	editing_sprite.snap_position_to_grid();

	$Grid.position = editing_sprite.position;
	add_child(editing_sprite);
	editing_sprite.set_texture();


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
		if !sprite.is_valid_placement: return;

		var tower_stats := Globals.tower_stats[current_tower_index];
		Globals.level.money -= tower_stats.base_price;

		var last_visible_gui := GuiTowerManager.last_visible_gui
		if last_visible_gui != null:
			last_visible_gui.hide();
			last_visible_gui.get_parent().find_child("Sprite").find_child("GlowingEffect").enabled = false;
			GuiTowerManager.last_visible_gui = null;

		var tower_sprite := tower_stats.tower_scene.instantiate() as ITower;
		tower_sprite.stats = tower_stats;
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


func update_selected_tower(index: int) -> void:
	current_tower_index = index;
	editing_sprite.stats = Globals.tower_stats[index];
	editing_sprite.set_texture();
