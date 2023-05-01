class_name BulletMulti;
extends IBullet;

@onready var particles_emitter := $GPUParticles2D as GPUParticles2D;


func physics() -> void:
	velocity = global_position.direction_to(target.global_position) * speed;
	rotation_degrees += 12;


func on_destroy(enemy: IEnemy) -> void:
	sprite.hide();
	particles_emitter.emitting = true;
	particles_emitter.z_index = enemy.z_index + 10;
	await get_tree().create_timer(1.5).timeout;
	queue_free();
