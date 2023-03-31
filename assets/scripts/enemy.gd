class_name Enemy;
extends Area2D


signal on_hit(tower: Tower, damages: float);


var health := 10.0;
var money_reward := 5.0;

@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D;
@onready var parent := get_parent() as PathFollow2D;
@onready var previous_point := Vector2(parent.position);

@export var is_dead := false;

func _init() -> void:
	on_hit.connect(_on_hit);


func _process(delta: float) -> void:
	if is_dead: return;

	parent.progress = parent.progress + Globals.enemy_speed * delta;

	var x_pos_difference := parent.position.x - previous_point.x;
	var y_pos_difference := parent.position.y - previous_point.y;

	previous_point = Vector2(parent.position);

	if absf(x_pos_difference) > absf(y_pos_difference):
		animated_sprite.play("walk_right" if x_pos_difference > 0 else "walk_left");
	else:
		animated_sprite.play("walk_down" if y_pos_difference > 0 else "walk_up");

	if parent.progress_ratio == 1:
		Globals.level.health -= 1;
		parent.queue_free();

func _on_hit(tower: Tower, damages: float) -> void:
	if is_dead: return;

	health -= damages;

	var animation_player := animated_sprite.get_node("AnimationPlayer") as AnimationPlayer;
	animation_player.stop();
	animation_player.play("hit");

	if health <= 0:
		is_dead = true;
		animation_player.stop();
		animation_player.play("death");
		animated_sprite.pause();

		await get_tree().create_timer(0.3).timeout;
		_on_death();


func _on_death() -> void:
	Globals.level.money += money_reward;
	parent.queue_free();
