extends Node;

@export var tile_size := 16;
@export var level: Level = null;
@export var tower_stats: Array[TowerStats] = [
	TowerStats.new(3, 20, 0.8, "tree", load("res://scenes/towers/tower_tree.tscn"), 2, 30),
	TowerStats.new(4, 40, 0.75, "big", load("res://scenes/towers/tower_big.tscn"), 1, 60)
];
@export var enemy_stats: Array[EnemyStats] = [
	EnemyStats.new(12, 130, 4, load("res://scenes/ennemies/enemy_small.tscn")),
	EnemyStats.new(90, 90, 12, load("res://scenes/ennemies/enemy_big.tscn")),
];
@export var waves: Array[Wave] = [
	Wave.new(1, 0, 8, ["FirstPath"]),
	Wave.new(2, 0, -1, ["FirstPath"]),
	Wave.new(4, 0, -1, ["FirstPath", "SecondPath"]),
	Wave.new(7, 0, -1, ["FirstPath", "SecondPath"]),
	Wave.new(1, 1, 20, ["FirstPath", "SecondPath"]),
	Wave.new(8, 0.1, -1, ["FirstPath", "SecondPath"]),
	Wave.new(10, 0.1, -1, ["FirstPath", "SecondPath"]),
	Wave.new(5, 0.1, -1, ["ThirdPath"]),
	Wave.new(20, 0.2, 30, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(3, 0.8, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(30, 0.2, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(20, 0.3, 20, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(6, 0.8, 10, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(50, 0.4, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(60, 0.4, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(10, 1, 30, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(80, 0.5, -1, ["FirstPath", "SecondPath","ThirdPath"]),
	Wave.new(20, 0.9, -1, ["FirstPath", "SecondPath","ThirdPath"]),
]
@export var enemy_speed_multiplier := 1.0;
