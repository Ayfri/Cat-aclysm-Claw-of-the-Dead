class_name Level;
extends Node2D;

const starting_money := 30;

@export var money := starting_money;
@onready var map := $Map as Map;


func _ready() -> void:
	Globals.level = self;
