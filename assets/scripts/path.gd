extends Node2D;

var current_wave = 0;
var mobs_to_spawn = 0;

#Always put even numbers
var wave_mobs = [2,10,20,30,40,50,60];

const enemy = preload("res://scenes/enemy.tscn");
@onready var pre_wave_timer := $PreWaveTimer as Timer;
@onready var enemy_spawn_timer := $EnemySpawnTimer as Timer;
@onready var first_path := $FirstPath as Path2D;
@onready var second_path := $SecondPath as Path2D;
@onready var third_path := $ThirdPath as Path2D;
@onready var all_paths : Array[Path2D] = [first_path, second_path, third_path];


func _process(delta):
	if first_path.get_child_count() < 1 && second_path.get_child_count() < 1 && third_path.get_child_count() < 1 && mobs_to_spawn == 0:
		if pre_wave_timer.is_stopped():
			pre_wave_timer.start();


func _on_pre_wave_timer_timeout():
	if current_wave <= len(wave_mobs):
		current_wave += 1;
		mobs_to_spawn += wave_mobs[current_wave-1];
		enemy_spawn_timer.start();


func _on_enemy_spawn_timer_timeout():
	all_paths.pick_random().add_child(enemy.instantiate());
	mobs_to_spawn -= 1;
	if mobs_to_spawn > 0:
		enemy_spawn_timer.start();
