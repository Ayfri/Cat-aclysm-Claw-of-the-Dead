class_name Level;
extends Node2D;

const starting_money := 30;
const starting_health := 10;

@export var health := starting_health;
@export var money := starting_money;

@onready var map := $Map as Map;


func _ready() -> void:
	Globals.level = self;
