class_name Tower;
extends Node2D;

const BulletScene := preload("res://scenes/bullet.tscn");
enum Target {First = 0, Last = 1, Strongest = 2, Weakest = 3, Random = 4};


var bullet_speed := 300;
var random_generator := RandomNumberGenerator.new();
var stats: TowerStats
var type_target: Target;
var target: Enemy;
var targetable_enemy: Array[Enemy] = [];


@onready var sprite := %Sprite as Sprite2D;
@onready var target_menu := $MarginContainer as MarginContainer;


func _ready() -> void:
	random_generator.randomize();


func _process(_delta: float) -> void:
	if targetable_enemy.is_empty(): return;

	select_target();
	if target != null: fire_target();


func select_target() -> void:
	match type_target:
		Target.First:
			target = targetable_enemy.front();
		Target.Last:
			target = targetable_enemy.back();
		Target.Strongest:
			target = get_strongest_enemy(targetable_enemy);
		Target.Weakest:
			target = get_weakest_enemy(targetable_enemy);
		Target.Random:
			randomize_target();


func randomize_target() -> void:
	target = targetable_enemy.pick_random();


func get_weakest_enemy(enemies: Array[Enemy]) -> Enemy:
	var lowest_health_enemy: Area2D = null;
	var lowest_health: float = -1;


	for enemy in enemies:
		if lowest_health == -1 or enemy.health < lowest_health:
			lowest_health_enemy = enemy;
			lowest_health = enemy.health;

	return lowest_health_enemy;


func get_strongest_enemy(enemies: Array[Enemy]) -> Enemy:
	var strongest_health_enemy: Enemy = null;
	var strongest_health: float = -1;

	for enemy in enemies:
		if enemy.health > strongest_health:
			strongest_health_enemy = enemy;
			strongest_health = enemy.health;

	return strongest_health_enemy;


func fire_target() -> void:
	if $ReloadTimer.is_stopped():
		$ReloadTimer.start();
		var bullet := BulletScene.instantiate() as Bullet;
		bullet.damages = stats.base_damage;
		bullet.speed = bullet_speed;
		bullet.target = target;
		bullet.tower = self;
		$BulletContainer.add_child(bullet);
		bullet.global_position = $Aim.global_position;


func _on_area_entered(area: Area2D) -> void:
	if !(area is Enemy): return;
	targetable_enemy.append(area);


func _on_area_exited(area: Area2D) -> void:
	if !(area is Enemy) || targetable_enemy.find(area) == -1: return;

	targetable_enemy.erase(area);
	if target == area: target = null;


func _on_select_weakest_enemy_pressed() -> void:
	type_target = Target.Weakest;
	target_menu.visible = false;


func _on_select_strongest_enemy_pressed() -> void:
	type_target = Target.Strongest;
	target_menu.visible = false;


func _on_select_last_enemy_pressed() -> void:
	type_target = Target.Last;
	target_menu.visible = false;


func _on_select_first_enemy_pressed() -> void:
	type_target = Target.First;
	target_menu.visible = false;


func _on_select_random_enemy_pressed() -> void:
	type_target = Target.Random;
	target_menu.visible = false;


func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if GuiTowerManager.last_visible_gui != null:
			GuiTowerManager.last_visible_gui.visible = false;
			GuiTowerManager.last_visible_gui = null;


func _on_clickable_area_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		target_menu.visible = !target_menu.visible;
		if target_menu.visible:
			GuiTowerManager.last_visible_gui = target_menu;


func _on_close_gui_pressed():
	target_menu.visible = false;
