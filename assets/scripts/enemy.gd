class_name Enemy;
extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var parent := get_parent();
	parent.progress = parent.progress + Globals.enemy_speed * delta;
	if parent.progress_ratio == 1:
		queue_free()
