class_name Bullet;
extends CharacterBody2D;

var damages: float;
var speed: int;
var target: Enemy;
var tower: Tower;


func _physics_process(_delta: float) -> void:
	if target == null:
		queue_free();
		return;
	velocity = global_position.direction_to(target.global_position) * speed;
	look_at(target.global_position);
	move_and_slide();


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Enemy:
		area.on_hit.emit(tower, damages);
		queue_free();
