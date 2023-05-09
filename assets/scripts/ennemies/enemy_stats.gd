class_name EnemyStats;
extends Resource


@export var base_health: int;
@export var base_speed : float;
@export var base_reward: int;
@export var enemy_scene: PackedScene;


@warning_ignore('shadowed_variable')
func _init(
	base_health: int,
	base_speed: int,
	base_reward: int,
	enemy_scene: PackedScene,
):
	self.base_health = base_health;
	self.base_speed = base_speed;
	self.base_reward = base_reward;
	self.enemy_scene = enemy_scene;
