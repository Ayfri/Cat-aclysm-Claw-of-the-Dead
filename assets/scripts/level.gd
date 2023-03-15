class_name Level;
extends Node2D;

@export var money = 0;

func _ready() -> void:
	Globals.level = self;
