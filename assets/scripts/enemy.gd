class_name Enemy;
extends Area2D

@onready var health := 10.0;


func _process(delta: float) -> void:
	var parent := get_parent() as PathFollow2D;
	parent.progress = parent.progress + Globals.enemy_speed * delta;
	if parent.progress_ratio == 1 || health <= 0:
		queue_free();
