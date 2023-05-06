class_name TowerTwo;
extends ITower;


func _init() -> void:
	stats = Globals.tower_stats[1];


func _ready() -> void:
	super._ready();
	bullet_speed = 250;


func calculate_bullet_damages() -> int:
	return stats.base_damage;

