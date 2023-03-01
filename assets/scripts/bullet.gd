class_name Bullet;
extends CharacterBody2D;

var damage: int;
var target: Enemy;
var speed: int;

func _physics_process(delta: float):
	if target == null:
		return;
	velocity = global_position.direction_to(target.global_position) * speed;
	look_at(target.global_position);
	move_and_slide();

func _on_area_2d_area_entered(area: Area2D):
	if area is Enemy:
		queue_free();
