extends Node2D;

var wave = 0
var mobs_left = 0
var wave_mobs = [5,5,5,5,5,5,0] 
var wave_speed = [1.0,1.0,0.5,0.5,0.3,0.2,100.0]

var instance
const enemy = preload("res://scenes/enemy.tscn")
@onready var WaveTimer := $WaveTimer as Timer;
@onready var EnemyTimer := $EnemyTimer as Timer;
@onready var Chemin := $Path2D as Path2D;



	
func _on_timer_timeout():
	if wave <= len(wave_mobs) && wave <= len(wave_speed):
		mobs_left = wave_mobs[wave]
		WaveTimer.wait_time = wave_speed[wave]
		EnemyTimer.start();
	#else:
		#if Chemin.get_children().back() == :
			#print("GAGNE");
			#get_tree().change_scene("res://scenes/Win.tscn");
		#else:
			#WaveTimer.wait_time = 1;
			#WaveTimer.start()


func _on_enemy_timer_timeout():
	Chemin.add_child(enemy.instantiate());
	mobs_left -= 1;
	if mobs_left > 0:
		EnemyTimer.start();
	else:
		WaveTimer.start()
		wave += 1;
