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

	physics();
	move_and_slide();


func physics() -> void:
	velocity = global_position.direction_to(target.global_position) * speed;
	look_at(target.global_position);


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is IEnemy:
		area.on_hit.emit(tower, damages);
		queue_free();


func set_sprite_texture(texture: Texture2D) -> void:
	sprite.texture = texture;
