extends Node;

@export var tile_size := 16;
@export var level: Level = null;
@export var tower_stats: Array[TowerStats] = [
	TowerStats.new(5, 20, 0.8, "tree", load("res://scenes/towers/tower_tree.tscn"), 5, 30),
	TowerStats.new(4, 25, 0.75, "big", load("res://scenes/towers/tower_big.tscn"), 4, 35)
];
@export var enemy_stats: Array[EnemyStats] = [
	EnemyStats.new(10, 200, 5, load("res://scenes/ennemies/enemy_small.tscn")),
	EnemyStats.new(25, 80, 15, load("res://scenes/ennemies/enemy_big.tscn")),
];
@export var enemy_speed_multiplier := 1.0;
