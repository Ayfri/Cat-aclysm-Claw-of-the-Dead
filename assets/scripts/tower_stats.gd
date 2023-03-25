class_name TowerStats;
extends Resource;


@export var base_damage: int;
@export var base_price: int;
@export var sell_percent: float;
@export var texture: Texture2D;


func _init(base_damage: int, base_price: int, sell_percent: float, texture_name: String) -> void:
	self.base_damage = base_damage;
	self.base_price = base_price;
	self.sell_percent = sell_percent;
	self.texture = load("res://assets/sprites/towers/%s.png" % texture_name);
