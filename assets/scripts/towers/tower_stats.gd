class_name TowerStats;
extends Resource;


@export var base_damage: int;
@export var base_price: int;
@export var sell_percent: float;
@export var texture: Texture2D;
@export var tower_scene: PackedScene;
@export var upgrade_damages: int;
@export var upgrade_price: int;

@warning_ignore('shadowed_variable')
func _init(
	base_damage: int,
	base_price: int,
	sell_percent: float,
	texture_name: String,
	tower_scene: PackedScene,
	upgrade_damages: int,
	upgrade_price: int
) -> void:
	self.base_damage = base_damage;
	self.base_price = base_price;
	self.sell_percent = sell_percent;
	self.texture = load("res://assets/sprites/towers/%s.png" % texture_name);
	self.tower_scene = tower_scene;
	self.upgrade_damages = upgrade_damages;
	self.upgrade_price = upgrade_price;
