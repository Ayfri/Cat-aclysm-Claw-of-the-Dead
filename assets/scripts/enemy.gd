class_name Enemy;
extends Area2D;

@onready var health = 10;


func _process(delta):
	var parent := get_parent();
	parent.progress = parent.progress + Globals.enemy_speed * delta;
