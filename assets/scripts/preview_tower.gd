extends Area2D;
class_name PreviewTower;

@export var isPreview := false:
	set = _set_preview;

@export var isValidPlacement := true:
	set = _set_isValidPlacement;
	
var overlappingArea: CollisionPolygon2D = null;
var isOverlappingTowers: Array[Area2D] = [];

func _set_preview(value: bool) -> void:
	modulate.a = .6 if value else 1.0
	isPreview = value;

func _set_isValidPlacement(value: bool) -> void:
	if !isPreview:
		return;
	modulate =  Color(1, 1, 1, modulate.a) if value else Color(.8, .2, .2, modulate.a);
	isValidPlacement = value;

func snap_position_to_grid() -> void:
	position = position.snapped(Vector2.ONE * Globals.tileSize);
	
func _ready() -> void:
	isValidPlacement = false;
	pass;

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion || event is InputEventMouseButton:
		test_current_overlapping_area();

func test_current_overlapping_area() -> void:
	if overlappingArea == null || !isOverlappingTowers.is_empty():
		return;

	var areaPolygonTransformed: PackedVector2Array = [];
	var currentPolygonTransformed: PackedVector2Array = [];
	for point in overlappingArea.polygon:
		@warning_ignore('return_value_discarded')
		areaPolygonTransformed.append(point * overlappingArea.transform.affine_inverse());
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
		overlappingArea = polygon;
		test_current_overlapping_area();

func _on_area_exited(area: Area2D) -> void:
	if area is PreviewTower:
		isOverlappingTowers.remove_at(isOverlappingTowers.find(area));
		return;
	if area.get_node_or_null("CollisionPolygon2D") == overlappingArea:
		overlappingArea = null;
		isValidPlacement = false;

