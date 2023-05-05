class_name IBullet;
extends CharacterBody2D;


var damages: float;
var hitbox: CollisionShape2D = null;
var hit_sound_player: AudioStreamPlayer2D = null;
var target: IEnemy;
var tower: ITower;
var speed: int;


@onready var direction := Vector2();
@onready var sprite := $Sprite2D as Sprite2D;


func _ready() -> void:
	hitbox = $Area2D/CollisionShape2D as CollisionShape2D;
	hit_sound_player = $HitSoundPlayer as AudioStreamPlayer2D;


func _physics_process(_delta: float) -> void:
	if !sprite.visible: return;
	if target != null && target.is_dead: target = null;

	if target == null:
		var distance_from_origin_vec := tower.global_position - global_position;
		var distance_from_origin := distance_from_origin_vec.abs().length()

		if distance_from_origin > 1500:
			queue_free();

	physics();
	move_and_slide();


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is IEnemy:
		var enemy := area as IEnemy;
		if enemy.is_dead: return;

		enemy.on_hit.emit(tower, damages);
		on_destroy(enemy as IEnemy);


func bullet_destroy_effects() -> void:
	queue_free();


func on_destroy(_enemy: IEnemy) -> void:
	play_hit_sound();
	hitbox.set_deferred("disabled", true);
	sprite.hide();
	await get_tree().create_timer(1.5).timeout;

	queue_free();


func play_hit_sound() -> void:
	hit_sound_player.play();


func physics() -> void:
	if target != null:
		direction = global_position.direction_to(target.global_position);
		look_at(target.global_position);

	if direction == Vector2(0, 0):
		direction = Vector2.from_angle(randi_range(0, 360));

	velocity = direction * speed;


func set_sprite_texture(texture: Texture2D) -> void:
	sprite.texture = texture;
