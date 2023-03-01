class_name Enemy
extends Area2D

@onready var health = 10
@export var runSpeed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().progress = get_parent().progress + runSpeed * delta
