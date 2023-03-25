extends Node;

@export var tile_size := 16;
@export var enemy_speed := 200;
@export var level: Level = null;
@export var tower_stats: Array[TowerStats] = [
	TowerStats.new(5, 20, 0.8, "tree"),
];
