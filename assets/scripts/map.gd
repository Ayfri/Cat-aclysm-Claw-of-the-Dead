extends Node2D;
class_name Map;

const TowerScene := preload("res://scenes/preview_tower.tscn");

@export @onready var editing := false;
@onready var sprites: Array[PreviewTower] = [];
@onready var editingSprite: PreviewTower;

func _process(_delta: float) -> void:
	map_editing();

func _input(event: InputEvent) -> void:
	if !editing:
		return;

	if event is InputEventMouseMotion:
		var sprite := get_positioning_sprite();
		sprite.position = event.position;
		var collision := sprite.move_and_collide(Vector2(), true);
		sprite.isValidPlacement = !(collision && collision.get_collider().is_class(sprite.get_class()));

func map_editing() -> void:
	if editing:
		if Input.is_action_just_pressed('Place Tower'):
			var sprite = get_positioning_sprite();
			if !sprite.isValidPlacement:
				return;

			sprite.isPreview = false;
			editing = false;
			editingSprite = null;
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	else:
		if Input.is_action_just_pressed('Change Map Editing Mode'):
			editing = !editing;
			editingSprite = TowerScene.instantiate() as PreviewTower;
			editingSprite.isPreview = true;
			editingSprite.position = get_viewport().get_mouse_position();
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
			sprites.append(editingSprite);
			add_child(editingSprite);

func get_positioning_sprite() -> PreviewTower:
	var children = get_children();
	var sprite = children[children.find(editingSprite)];
	return sprite if sprite is PreviewTower else null;
