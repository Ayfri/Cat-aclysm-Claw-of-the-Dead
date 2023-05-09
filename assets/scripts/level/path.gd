class_name WavesSpawner;
extends Node2D;


var mobs_to_spawn := 0;
var zombie_type := 0;
var random := RandomNumberGenerator.new();

@onready var all_mobs_dead: bool:
	get:
		return paths.all(func(path: Path2D): return path.get_child_count() < 1);

@onready var enemy_spawn_timer := $EnemySpawnTimer as Timer;
@onready var pre_wave_timer := $PreWaveTimer as Timer;
@onready var wave_announcer_display := $WaveAnnouncerDisplay as Timer;
@onready var wave_announcer_hide := $WaveAnnouncerHide as Timer;
@onready var paths: Array[Path2D] = []:
	get:
		var array: Array[Path2D] = [];
		array.assign(get_tree().get_nodes_in_group("paths"));
		return array;


func _ready():
	random.randomize();
	var a := 2.;


func _process(_delta: float):
	if mobs_to_spawn == 0 && all_mobs_dead:
		if pre_wave_timer.is_stopped():
			if Globals.level.wave <= len(Globals.waves):
				wave_announcer_display.start();
				pre_wave_timer.start();

		if Globals.level.wave > Globals.waves.size() && !Globals.level.finished:
			Globals.level.win();


func _on_pre_wave_timer_timeout():
	for path in Globals.waves[Globals.level.wave - 1].possible_path:
		Globals.level.map.get_wave_label(path).visible = false;

	wave_announcer_display.stop();
	wave_announcer_hide.stop();
	mobs_to_spawn += Globals.waves[Globals.level.wave - 1].zombie_count;
	enemy_spawn_timer.start();


func _on_enemy_spawn_timer_timeout():
	var current_wave := Globals.waves[Globals.level.wave - 1];
	var path_used := paths.pick_random() as Path2D;
	if !path_used.name in current_wave.possible_path:
		_on_enemy_spawn_timer_timeout();
		return;

	randf();
	if random.randf() <= current_wave.big_probability:
		zombie_type = 1;
	else:
		zombie_type = 0;

	var enemy := Globals.enemy_stats[zombie_type].enemy_scene.instantiate() as PathFollow2D;
	var enemy_node := enemy.get_node('Enemy') as IEnemy;
	enemy_node.stats = Globals.enemy_stats[zombie_type];
	path_used.add_child(enemy);

	mobs_to_spawn -= 1;
	if mobs_to_spawn > 0:
		enemy_spawn_timer.start();
	else:
		Globals.level.wave += 1;


func _on_wave_announcer_display_timeout():
	for path in Globals.waves[Globals.level.wave - 1].possible_path:
		Globals.level.map.get_wave_label(path).visible = true;
	wave_announcer_hide.start();


func _on_wave_announcer_hide_timeout():
	for path in Globals.waves[Globals.level.wave - 1].possible_path:
		Globals.level.map.get_wave_label(path).visible = false;
	wave_announcer_display.start();
