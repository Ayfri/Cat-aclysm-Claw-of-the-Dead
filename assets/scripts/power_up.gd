class_name PowerUp;
extends Area2D;


const sprite_buff := preload("res://assets/sprites/powers/buff.png");
const sprite_debuff := preload("res://assets/sprites/powers/debuff.png")

@onready var audio_stream_player := $AudioStreamPlayer as AudioStreamPlayer;
@onready var sprite := $Sprite2D as Sprite2D;

@export var effect_duration := 5;
@export var speed := 250;


func _ready():
	position.x = randf_range(400, 1200);


func _process(delta: float) -> void:
	position.y += speed * delta;
	if position.y > 900:
		position.y = randf_range(-300, -1500);
		position.x = randf_range(400, 1200);
		visible = true;


func _on_timer_sprite_timeout():
	var random_spawn := randi() % 3 + 1;

	if random_spawn == 3:
		sprite.texture = sprite_debuff;
	else:
		sprite.texture = sprite_buff;


func apply_powerup_effect() -> void:
	if sprite.texture == sprite_debuff:
		Globals.enemy_speed_multiplier = 2;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;

	else:
		Globals.enemy_speed_multiplier = 0.5;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if !event is InputEventMouseButton: return;

	var mouse_button_event := event as InputEventMouseButton;
	if mouse_button_event.button_index == MOUSE_BUTTON_LEFT and mouse_button_event.is_pressed():
		audio_stream_player.play();
		visible = false;
		apply_powerup_effect();
