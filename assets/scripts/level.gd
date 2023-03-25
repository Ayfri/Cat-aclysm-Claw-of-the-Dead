class_name Level;
extends Node2D;

@export var money := 0;
@onready var map := $Map as Map;


func _ready() -> void:
	Globals.level = self;
