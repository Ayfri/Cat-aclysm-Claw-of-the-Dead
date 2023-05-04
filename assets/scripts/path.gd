extends Node2D;

var mobs_to_spawn := 0;
var zombie_type := 0;
var random := RandomNumberGenerator.new();

@onready var pre_wave_timer := $PreWaveTimer as Timer;
@onready var enemy_spawn_timer := $EnemySpawnTimer as Timer;
@onready var wave_announcer_display := $WaveAnnouncerDisplay as Timer;
@onready var wave_announcer_hide := $WaveAnnouncerHide as Timer;
@onready var paths: Array[Path2D] = []:
	get:
		var array: Array[Path2D];
		array.assign(get_tree().get_nodes_in_group("paths"));
		return array;


func _ready():
	random.randomize();


func _process(_delta: float):
	if mobs_to_spawn == 0 && paths.all(func(path: Path2D): return path.get_child_count() < 1):
		if pre_wave_timer.is_stopped():
			if Globals.level.wave < len(Globals.waves):
				wave_announcer_display.start();
				pre_wave_timer.start();


func _on_pre_wave_timer_timeout():
	for path in Globals.waves[Globals.level.wave].possible_path:
		Globals.level.map.get_node("%sLabel" % path).visible = false;
	wave_announcer_display.stop();
	wave_announcer_hide.stop();
	mobs_to_spawn += Globals.waves[Globals.level.wave].zombie_count;
	enemy_spawn_timer.start();
	Globals.level.wave += 1;


func _on_enemy_spawn_timer_timeout():
	var path_used := paths.pick_random() as Path2D;
	if path_used.name not in Globals.waves[Globals.level.wave-1].possible_path:
		_on_enemy_spawn_timer_timeout();
		return;

	if random.randf() <= Globals.waves[Globals.level.wave-1].big_probability:
		zombie_type = 1;
	else:
		zombie_type = 0;

	var enemy := Globals.enemy_stats[zombie_type].enemy_scene.instantiate() as PathFollow2D;
	enemy.get_node('Enemy').stats = Globals.enemy_stats[zombie_type];
	path_used.add_child(enemy);

	mobs_to_spawn -= 1;
	if mobs_to_spawn > 0:
		enemy_spawn_timer.start();


func _on_wave_announcer_display_timeout():
	for path in Globals.waves[Globals.level.wave].possible_path:
		Globals.level.map.get_node("%sLabel" % path).visible = true;
	wave_announcer_hide.start();


func _on_wave_announcer_hide_timeout():
	for path in Globals.waves[Globals.level.wave].possible_path:
		Globals.level.map.get_node("%sLabel" % path).visible = false;
	wave_announcer_display.start();
