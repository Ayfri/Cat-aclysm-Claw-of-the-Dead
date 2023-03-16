extends Node2D

const enemy = preload("res://scenes/enemy.tscn");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_interval_timeout():
	var enemy_instance = enemy.instantiate();
	get_node("Path2D").add_child(enemy_instance);
