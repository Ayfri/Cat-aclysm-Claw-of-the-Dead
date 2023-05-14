class_name PowerUp;
extends Area2D;


const sprite_buff := preload("res://assets/sprites/powers/buff.png");
const sprite_debuff := preload("res://assets/sprites/powers/debuff.png")

@onready var audio_stream_player := $AudioStreamPlayer as AudioStreamPlayer;
@onready var sprite := $Sprite2D as Sprite2D;

@export var effect_duration := 5;
@export var speed := 250;


func _ready() -> void:
	place_randomly();


func _process(delta: float) -> void:
	position.y += speed * delta;
	if position.y > 1000:
		place_randomly();


func _on_timer_sprite_timeout() -> void:
	var random_spawn := randi() % 3 + 1;

	if random_spawn == 3:
		sprite.texture = sprite_debuff;
	else:
		sprite.texture = sprite_buff;


func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if !event is InputEventMouseButton: return;

	var mouse_button_event := event as InputEventMouseButton;
	if mouse_button_event.button_index == MOUSE_BUTTON_LEFT and mouse_button_event.is_pressed():
		get_tree().get_root().set_input_as_handled();
		audio_stream_player.play();
		visible = false;
		apply_powerup_effect();


func apply_powerup_effect() -> void:
	if sprite.texture == sprite_debuff:
		Globals.enemy_speed_multiplier = 2;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;

	else:
		Globals.enemy_speed_multiplier = 0.5;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;


func place_randomly() -> void:
	position.y = randf_range(-500, -2500);
	position.x = randf_range(200, 1400);
	visible = true;
