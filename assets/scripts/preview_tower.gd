class_name PreviewTower;
extends Area2D;

@export var isPreview := false:
	set = _set_preview;

@export var isValidPlacement := true:
	set = _set_isValidPlacement;

var overlappingZone: CollisionPolygon2D = null;
var isOverlappingTowers: Array[Area2D] = [];

func _set_preview(value: bool) -> void:
	modulate.a = .6 if value else 1.0;
	isPreview = value;
	if !value:
		z_index = get_viewport().get_visible_rect().size.y + position.y;
		print(z_index);

func _set_isValidPlacement(value: bool) -> void:
	if !isPreview:
		return;
	modulate =  Color(1, 1, 1, modulate.a) if value else Color(.8, .2, .2, modulate.a);
	isValidPlacement = value;

func snap_position_to_grid() -> void:
	position = position.snapped(Vector2.ONE * Globals.tile_size);

func _ready() -> void:
	isValidPlacement = false;
	pass;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion || event is InputEventMouseButton:
		test_current_overlapping_area();

func test_current_overlapping_area() -> void:
	if overlappingZone == null || !isOverlappingTowers.is_empty():
		return;

	var areaPolygonTransformed: PackedVector2Array = [];
	var currentPolygonTransformed: PackedVector2Array = [];
	for point in overlappingZone.polygon:
		areaPolygonTransformed.append(point * overlappingZone.transform.affine_inverse() * overlappingZone.transform);
	for point in $CollisionPolygon2D.polygon:
		currentPolygonTransformed.append(point * transform.affine_inverse());

	var result := Geometry2D.clip_polygons(currentPolygonTransformed, areaPolygonTransformed);
	isValidPlacement = result.is_empty();

func _on_area_entered(area: Area2D) -> void:
	if area is PreviewTower:
		isOverlappingTowers.append(area);
		isValidPlacement = false;
		return;
	var polygon := area.get_node_or_null("CollisionPolygon2D") as CollisionPolygon2D;
	if polygon != null:
		overlappingZone = polygon;
		test_current_overlapping_area();

func _on_area_exited(area: Area2D) -> void:
	if area is PreviewTower:
		isOverlappingTowers.remove_at(isOverlappingTowers.find(area));
		return;
	if area.get_node_or_null("CollisionPolygon2D") == overlappingZone:
		overlappingZone = null;
		isValidPlacement = false;
