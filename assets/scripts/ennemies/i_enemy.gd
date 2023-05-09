class_name IEnemy;
extends Area2D


signal on_hit(tower: ITower, damages: float);

var health: float;
var stats: EnemyStats = null:
	set(value):
		stats = value;
		health = value.base_health;

@onready var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D;
@onready var first_collision_shape := $FirstCollisionShape as CollisionShape2D;
@onready var parent := get_parent() as PathFollow2D;
@onready var poison_timer := $PoisonTimer as Timer;
@onready var previous_point := Vector2(parent.position);
@onready var second_collision_shape := $SecondCollisionShape as CollisionShape2D;

@export var is_dead := false;
@export var poison_damages: int;
@export var poison_tower_source: ITower;
@export var poisened := false:
	set(value):
		poisened = value;

		if value: poison_timer.start();
		else: poison_timer.stop();
		modulate = Color(0.3, 1, 0.3) if value else Color(1, 1, 1);


func _init() -> void:
	on_hit.connect(_on_hit);


func _process(delta: float) -> void:
	if is_dead || !stats: return;
	animated_sprite.z_index = roundi(global_position.y);

	var x_pos_difference := parent.position.x - previous_point.x;
	var y_pos_difference := parent.position.y - previous_point.y;

	previous_point = Vector2(parent.position);

	if absf(x_pos_difference) > absf(y_pos_difference):
		first_collision_shape.set_disabled(false);
		second_collision_shape.set_disabled(true);
		animated_sprite.play("walk_right" if x_pos_difference > 0 else "walk_left");
	else:
		first_collision_shape.set_disabled(false);
		second_collision_shape.set_disabled(false);
		animated_sprite.play("walk_down" if y_pos_difference > 0 else "walk_up");

	parent.progress += (stats.base_speed * Globals.enemy_speed_multiplier * delta);
	if parent.progress_ratio == 1:
		Globals.level.health -= 1;
		parent.queue_free();


func _on_hit(tower: ITower, damages: float) -> void:
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
		tower.targetable_enemy.erase(self);

		await get_tree().create_timer(0.3).timeout;
		_on_death();


func _on_death() -> void:
	Globals.level.money += stats.base_reward;

	var is_boss := Globals.enemy_stats.find(stats) == 1;
	var index := 1 if is_boss else 0;
	Globals.level.killed_zombies[index] += 1;

	parent.hide();
	await get_tree().create_timer(1.5).timeout;
	parent.queue_free();


func poison(tower: ITower, duration: float, poison_damages: int) -> void:
	self.poison_damages = poison_damages;
	poisened = true;
	poison_tower_source = tower;
	await get_tree().create_timer(duration).timeout;

	if is_dead: return;
	poisened = false;


func _on_poison_timer_timeout() -> void:
	if poison_tower_source == null: return;

	_on_hit(poison_tower_source, poison_damages);
