class_name Bullet
extends CharacterBody2D

var damage: int
var target: Enemy
var speed: int;


func _physics_process(delta: float):
	if target == null:
		return
	print(target)
	velocity = global_position.direction_to(target.global_position) * speed
	look_at(target.global_position)
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if "enemy" in area.name:
		queue_free()
