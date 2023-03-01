class_name Enemy;
extends Area2D;

@onready var health = 10;
@export var runSpeed = 200;

func _process(delta):
	var parent := get_parent();
	parent.progress = parent.progress + runSpeed * delta;
