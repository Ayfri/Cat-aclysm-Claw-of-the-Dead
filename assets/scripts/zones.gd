class_name Zones;
extends Node2D;

var zones: Array[Area2D];


func _ready() -> void:
	var children: Array = get_children(true)
	var zonesChildren = children.filter(func(s: Node): return s.is_in_group("Zones"));
	zones.append_array(zonesChildren as Array[Area2D]);


func _draw() -> void:
	for zone in zones:
		var polygon := (zone.get_node("CollisionPolygon2D") as CollisionPolygon2D);
		var transformed_polygon: PackedVector2Array = [];
		for point in polygon.polygon:
			transformed_polygon.append(point * polygon.transform.affine_inverse());

		draw_colored_polygon(transformed_polygon, Color("#bbbb55", .5))
