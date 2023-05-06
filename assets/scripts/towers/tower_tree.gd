class_name TowerTree;
extends ITower;


func _init() -> void:
	stats = Globals.tower_stats[0];


func _on_upgrade(tower) -> void:
	var hit_circle_area := hit_area.shape as CircleShape2D;
	hit_circle_area = hit_circle_area.duplicate() as CircleShape2D;
	hit_circle_area.radius *= 1.1;
	hit_area.shape = hit_circle_area;
