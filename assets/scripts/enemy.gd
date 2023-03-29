class_name Enemy;
extends Area2D


var health := 10.0;
var money_reward := 5.0;

@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D;
@onready var parent := get_parent() as PathFollow2D;
@onready var previous_point := Vector2(parent.position);

func _process(delta: float) -> void:
	parent.progress = parent.progress + Globals.enemy_speed * delta;

	var x_pos_difference := parent.position.x - previous_point.x;
	var y_pos_difference := parent.position.y - previous_point.y;

	previous_point = Vector2(parent.position);

	if absf(x_pos_difference) > absf(y_pos_difference):
		animated_sprite.play("walk_right" if x_pos_difference > 0 else "walk_left");
	else:
		animated_sprite.play("walk_down" if y_pos_difference > 0 else "walk_up");

	if health <= 0:
		Globals.level.money += money_reward;
		parent.queue_free();

	if parent.progress_ratio == 1:
		Globals.level.health -= 1;
		parent.queue_free();
