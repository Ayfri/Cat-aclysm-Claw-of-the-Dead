class_name ITower;
extends Node2D;

const BulletScene := preload("res://scenes/bullet.tscn");
var bullet_texture := preload("res://assets/sprites/projectiles/arrow.png");
enum Target {First = 0, Last = 1, Strongest = 2, Weakest = 3, Random = 4};


var bullet_speed := 300;
var stats: TowerStats;
var type_target: Target;
var target: Enemy;
var targetable_enemy: Array[Enemy] = [];
var upgraded := false;


@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D;
@onready var target_menu := $MarginContainer as MarginContainer;
@onready var glowing_effect := $AnimatedSprite2D/GlowingEffect as PointLight2D;
@onready var timer := get_tree().create_timer(0.2);
@onready var upgrade_button := $MarginContainer/ContainerButtonUpgrade as VBoxContainer;
@onready var z_index_save: int = sprite.z_index;


func _ready() -> void:
	timer.timeout.connect(_enable_menu);
	z_index = get_viewport().get_visible_rect().size.y + position.y;


func _process(_delta: float) -> void:
	if targetable_enemy.is_empty(): return;

	select_target();
	if target != null: fire_target();


func _enable_menu():
	timer = null;


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
		bullet.damages = stats.base_damage + stats.upgrade_damages if upgraded else stats.base_damage;
		bullet.speed = bullet_speed;
		bullet.target = target;
		bullet.tower = self;
		bullet.sprite_texture = bullet_texture;

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
	glowing_effect.enabled = false;


func _on_select_strongest_enemy_pressed() -> void:
	type_target = Target.Strongest;
	target_menu.visible = false;
	glowing_effect.enabled = false;


func _on_select_last_enemy_pressed() -> void:
	type_target = Target.Last;
	target_menu.visible = false;
	glowing_effect.enabled = false;


func _on_select_first_enemy_pressed() -> void:
	type_target = Target.First;
	target_menu.visible = false;
	glowing_effect.enabled = false;


func _on_select_random_enemy_pressed() -> void:
	type_target = Target.Random;
	target_menu.visible = false;
	glowing_effect.enabled = false;


func _on_close_gui_pressed():
	target_menu.visible = false;
	glowing_effect.enabled = false;


func _on_upgrade_tower_pressed():
	if Globals.level.money < stats.upgrade_price: return;
	Globals.level.money -= stats.upgrade_price;
	target_menu.visible = false;
	glowing_effect.enabled = false;
	bullet_texture = load("res://assets/sprites/projectiles/bullet.png");
	upgraded = true;
	sprite.play("idle_2")
	upgrade_button.queue_free();


func _on_destroy_tower_pressed():
	target_menu.visible = false;
	glowing_effect.enabled = false;
	self.queue_free();


func _unhandled_input(event: InputEvent) -> void:
	var right_or_left_click: bool = event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT or event.button_index == MOUSE_BUTTON_RIGHT);
	if event.is_pressed() and right_or_left_click:
		if GuiTowerManager.last_visible_gui != null:
			GuiTowerManager.last_visible_gui.visible = false;
			GuiTowerManager.last_visible_gui.get_parent().get_node("AnimatedSprite2D").z_index = z_index_save;
			GuiTowerManager.last_visible_gui.get_parent().get_node("AnimatedSprite2D/GlowingEffect").enabled = false;
			GuiTowerManager.last_visible_gui = null;


func _on_clickable_area_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if timer != null: return;

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		target_menu.visible = !target_menu.visible;
		if target_menu.visible:
			glowing_effect.enabled = true;
			sprite.z_index = target_menu.z_index+2;
			GuiTowerManager.last_visible_gui = target_menu;
