class_name BulletMulti;
extends IBullet;


@export var poison_duration := 2.0;

@onready var explosion_particles := $ExplosionParticles as GPUParticles2D;
@onready var ground_particles := $GroundParticles as GPUParticles2D;


## Changes the animation to take colored sprites when bullet is poisonous.
func _ready() -> void:
	super._ready();
	if tower.upgraded:
		var particle_material := explosion_particles.process_material as ParticleProcessMaterial;
		particle_material = particle_material.duplicate();
		particle_material.anim_offset_min = 0.5;
		particle_material.anim_offset_max = 1;
		explosion_particles.process_material = particle_material;

		particle_material = ground_particles.process_material as ParticleProcessMaterial;
		particle_material = particle_material.duplicate();
		particle_material.anim_offset_min = 0.5;
		particle_material.anim_offset_max = 1;
		ground_particles.process_material = particle_material;


func bullet_destroy_effects() -> void:
	if !sprite.visible: return;
	sprite.hide();

	rotation = 0;

	if !hitbox.disabled:
		var hitbox_shape := hitbox.shape as CircleShape2D;
		hitbox_shape = hitbox_shape.duplicate();
		hitbox_shape.radius *= 3.0;
		hitbox.set_deferred("shape", hitbox_shape);

	explosion_particles.emitting = true;
	explosion_particles.z_index = 1000;

	ground_particles.emitting = true;
	ground_particles.z_index = 1000;

	await get_tree().create_timer(0.3).timeout;
	hitbox.disabled = true;

	await get_tree().create_timer(1.0).timeout;
	queue_free();


func physics() -> void:
	if target != null:
		direction = global_position.direction_to(target.global_position);

	if direction == Vector2(0, 0):
		direction = Vector2.from_angle(randi_range(0, 360));

	velocity = direction * speed;
	rotation_degrees += 12.0;


func on_destroy(enemy: IEnemy) -> void:
	if tower.upgraded:
		enemy.poison(tower, poison_duration, tower.stats.upgrade_damages);

	if sprite.visible: position = enemy.global_position;

	play_hit_sound();
	bullet_destroy_effects();
