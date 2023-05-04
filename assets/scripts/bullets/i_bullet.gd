class_name IBullet;
extends CharacterBody2D;


var damages: float;
var speed: int;
var target: IEnemy;
var tower: ITower;

@onready var sprite := $Sprite2D as Sprite2D;


func _physics_process(_delta: float) -> void:
	if target == null:
		queue_free();
		return;

	if !sprite.visible: return;
	physics();
	move_and_slide();


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is IEnemy:
		var enemy := area as IEnemy;
		if enemy.is_dead:
			queue_free();
			return;

		enemy.on_hit.emit(tower, damages);
		on_destroy(enemy as IEnemy);


func on_destroy(enemy: IEnemy) -> void:
	queue_free();


func physics() -> void:
	velocity = global_position.direction_to(target.global_position) * speed;
	look_at(target.global_position);


func set_sprite_texture(texture: Texture2D) -> void:
	sprite.texture = texture;
