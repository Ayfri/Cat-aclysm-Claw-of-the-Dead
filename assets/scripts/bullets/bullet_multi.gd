class_name BulletMulti;
extends IBullet;


@export var poison_duration := 2.0;

@onready var particles_emitter := $GPUParticles2D as GPUParticles2D;
@onready var hitbox := $Area2D/CollisionShape2D as CollisionShape2D;


## Changes the animation to take colored sprites when bullet is poisonous.
func _ready() -> void:
	if tower.upgraded:
		var particle_material := particles_emitter.process_material as ParticleProcessMaterial;
		particle_material.anim_offset_min = 0.5;
		particle_material.anim_offset_max = 1;


func physics() -> void:
	velocity = global_position.direction_to(target.global_position) * speed;
	rotation_degrees += 12;


func on_destroy(enemy: IEnemy) -> void:
	if tower.upgraded:
		enemy.poison(tower, poison_duration, tower.stats.upgrade_damages);

	if !sprite.visible: return;
	sprite.hide();
	position = enemy.global_position;

	if !hitbox.disabled:
		var hitbox_shape := hitbox.shape as CircleShape2D;
		hitbox_shape = hitbox_shape.duplicate();
		hitbox_shape.radius *= 3;
		hitbox.set_deferred("shape", hitbox_shape);

	particles_emitter.emitting = true;
	particles_emitter.z_index = 1000;

	await get_tree().create_timer(0.3).timeout;
	hitbox.disabled = true;

	await get_tree().create_timer(1.0).timeout;
	queue_free();
