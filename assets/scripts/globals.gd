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
@export var waves: Array[Wave] = [
	Wave.new(2, 0.1, -1, ["FirstPath", "SecondPath"]),
	Wave.new(10, 0.2, -1, ["FirstPath", "SecondPath"]),
	Wave.new(20, 0.2, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(30, 0.3, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(40, 0.3, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(50, 0.4, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(60, 0.4, -1, ["FirstPath", "SecondPath","ThirdPath"]),
]
@export var enemy_speed_multiplier := 1.0;
