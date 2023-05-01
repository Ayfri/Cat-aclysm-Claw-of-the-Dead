class_name PreviewTower;
extends Area2D;

var stats: TowerStats;

@onready var hitbox := $CollisionPolygon2D as CollisionPolygon2D;
@onready var sprite := $Sprite2D as Sprite2D;

@export var is_valid_placement := true:
	set(value):
		if stats == null || Globals.level.money < stats.base_price: value = false;

		modulate =  Color(1, 1, 1, modulate.a) if value else Color(.8, .2, .2, modulate.a);
		is_valid_placement = value;

@export var overlapping_zone: CollisionPolygon2D = null;
@export var overlapping_towers: Array[Area2D] = [];


func _init() -> void:
	self.is_valid_placement = false;


func _input(_event: InputEvent) -> void:
	test_current_overlapping_area();


func _on_area_entered(area: Area2D) -> void:
	# Check for overlapping towers
	if area.name == "PlacementHitbox":
		overlapping_towers.append(area);
		is_valid_placement = false;
		return;

	# Check for zones
	if !area.name.begins_with("Zone"): return;

	var polygon := area.get_node_or_null("CollisionPolygon2D") as CollisionPolygon2D;
	if polygon != null:
		overlapping_zone = polygon;
		test_current_overlapping_area();


func _on_area_exited(area: Area2D) -> void:
	if area.name == "PlacementHitbox":
		overlapping_towers.remove_at(overlapping_towers.find(area));
		return;


	if !area.name.begins_with("Zone"): return;

	if area.get_node_or_null("CollisionPolygon2D") == overlapping_zone:
		overlapping_zone = null;
		is_valid_placement = false;


func set_texture() -> void:
	if stats == null: return;
	sprite.texture = stats.texture;


func snap_position_to_grid() -> void:
	position = position.snapped(Vector2.ONE * Globals.tile_size);


func test_current_overlapping_area() -> void:
	if overlapping_zone == null || !overlapping_towers.is_empty():
		return;

	var area_polygon_transformed: PackedVector2Array = [];
	var current_polygon_transformed: PackedVector2Array = [];

	for point in overlapping_zone.polygon:
		area_polygon_transformed.append(point * overlapping_zone.transform.affine_inverse());

	for point in hitbox.polygon:
		current_polygon_transformed.append(point * transform.affine_inverse());

	var result := Geometry2D.clip_polygons(current_polygon_transformed, area_polygon_transformed);
	is_valid_placement = result.is_empty();
