extends Node2D;

const enemy = preload("res://scenes/enemy.tscn")

func _on_timer_timeout():
	var enemy_instance = enemy.instantiate();
	get_node("Path2D").add_child(enemy_instance);
