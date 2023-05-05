class_name TowerTwo;
extends ITower;


func calculate_bullet_damages() -> int:
	return stats.base_damage;


func _ready() -> void:
	self._ready();
	bullet_speed = 250;
