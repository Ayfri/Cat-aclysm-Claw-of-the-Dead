extends Node;

@export var tile_size := 16;
@export var level: Level = null;
@export var tower_stats: Array[TowerStats] = [
	TowerStats.new(5, 20, 0.8, "tree"),
];
@export var enemy_stats: Array[EnemyStats] = [
	EnemyStats.new(10, 200, 5),
];
@export var enemy_speed_multiplier := 1.0;
