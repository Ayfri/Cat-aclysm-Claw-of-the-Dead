extends Node2D;

var current_wave := 0;
var mobs_to_spawn := 0;

# Waves should only contains an even number of monsters.
var wave_mobs = [2, 10, 20, 30, 40, 50, 60];

const EnemyScene := preload("res://scenes/ennemies/enemy_big.tscn");
@onready var pre_wave_timer := $PreWaveTimer as Timer;
@onready var enemy_spawn_timer := $EnemySpawnTimer as Timer;
@onready var paths: Array[Path2D] = []:
	get:
		var array: Array[Path2D];
		array.assign(get_tree().get_nodes_in_group("paths"));
		return array;


func _process(_delta: float):
	if mobs_to_spawn == 0 && paths.all(func(path: Path2D): return path.get_child_count() < 1):
		if pre_wave_timer.is_stopped():
			pre_wave_timer.start();


func _on_pre_wave_timer_timeout():
	if current_wave < len(wave_mobs):
		mobs_to_spawn += wave_mobs[current_wave];
		enemy_spawn_timer.start();
		current_wave += 1;


func _on_enemy_spawn_timer_timeout():
	var path_follow := EnemyScene.instantiate() as PathFollow2D;
	path_follow.get_node('Enemy').stats = Globals.enemy_stats[1];
	paths.pick_random().add_child(path_follow);

	mobs_to_spawn -= 1;
	if mobs_to_spawn > 0:
		enemy_spawn_timer.start();
