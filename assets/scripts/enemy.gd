class_name Enemy;
extends Area2D

var health := 10.0;
var money_reward := 5.0;


func _process(delta: float) -> void:
	var parent := get_parent() as PathFollow2D;
	parent.progress = parent.progress + Globals.enemy_speed * delta;

	if health <= 0:
		Globals.level.money += money_reward;
		queue_free();

	if parent.progress_ratio == 1:
		Globals.level.health -= 1;
		queue_free();
