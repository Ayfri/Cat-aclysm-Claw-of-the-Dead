class_name BulletMulti;
extends IBullet;

func physics() -> void:
	velocity = global_position.direction_to(target.global_position) * speed;
	rotation_degrees += 12;
