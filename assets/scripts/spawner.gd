class_name Spawner;
extends Node2D;

const EnemyScene = preload("res://scenes/enemy.tscn");

func _on_spawn_interval_timeout() -> void:
	var enemy_instance = EnemyScene.instantiate();
	$Path2D.add_child(enemy_instance);
