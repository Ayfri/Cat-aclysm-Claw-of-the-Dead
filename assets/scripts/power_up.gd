class_name PowerUp;
extends Area2D;

const sprite_buff := preload("res://icon.svg");
const sprite_debuff := preload("res://icon_debuff.svg")
@export var speed := 300;
@export var effect_duration := 5;
@export var random_spawn := 1;

func _ready():
	position.x = randf_range(400, 1200);

func _process(delta: float) -> void:
	position.y += speed * delta;
	if position.y > 900:
		position.y = -200;
		position.x = randf_range(400, 1200);
		visible = true;

func _on_timer_sprite_timeout():
	random_spawn = randi() % 3 + 1;

	if random_spawn == 3:
		$Sprite2D.texture = sprite_debuff;
	else:
		$Sprite2D.texture = sprite_buff;


func apply_powerup_effect() -> void:
	if $Sprite2D.texture == sprite_debuff:
		Globals.enemy_speed_multiplier = 2;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;

	else:
		Globals.enemy_speed_multiplier = 0.5;
		await get_tree().create_timer(2.0).timeout;
		Globals.enemy_speed_multiplier = 1;

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		visible = false;
		apply_powerup_effect();

