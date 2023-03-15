extends Node2D

const enemy = preload("res://assets/scripts/enemy.gd");

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_interval_timeout():
	var enemy = Enemy
