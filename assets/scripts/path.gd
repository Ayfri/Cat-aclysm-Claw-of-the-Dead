extends Node2D;

var current_wave = 0;
var mobs_to_spawn = 0;

#Always put even numbers
var wave_mobs = [2,10,20,30,40,50,60];

const enemy = preload("res://scenes/enemy.tscn");
@onready var pre_wave_timer := $PreWaveTimer as Timer;
@onready var enemy_spawn_timer := $EnemySpawnTimer as Timer;
@onready var paths: Array[Path2D] = []:
	get:
		return get_tree().get_nodes_in_group("paths") as Array[Path2D];


func _process(delta):
	if mobs_to_spawn == 0 && paths.all(func(path: Path2D): path.get_child_count() < 1) :
		if pre_wave_timer.is_stopped():
			pre_wave_timer.start();


func _on_pre_wave_timer_timeout():
	if current_wave <= len(wave_mobs):
		current_wave += 1;
		mobs_to_spawn += wave_mobs[current_wave-1];
		enemy_spawn_timer.start();


func _on_enemy_spawn_timer_timeout():
	paths.pick_random().add_child(enemy.instantiate());
	mobs_to_spawn -= 1;
	if mobs_to_spawn > 0:
		enemy_spawn_timer.start();
