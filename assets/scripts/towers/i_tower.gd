class_name ITower;
extends Node2D;

enum Target {First = 0, Last = 1, Strongest = 2, Weakest = 3, Random = 4};

var bullet_speed := 300;
var stats: TowerStats;
var type_target: Target;
var target: IEnemy;
var targetable_enemy: Array[IEnemy] = [];
var upgraded := false;
var menu_open: bool:
	get:
		return target_menu.visible;

@export var projectile_scene: PackedScene;
@export var projectile_upgrade_texture: Texture2D;

@onready var aim_marker := $Aim as Marker2D;
@onready var hit_area := $Area2D/HitArea as CollisionShape2D;
@onready var reload_timer := $ReloadTimer as Timer;
@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D;
@onready var target_menu := $MarginContainer as MarginContainer;
@onready var timer := get_tree().create_timer(0.2);
@onready var upgrade_button := $MarginContainer/ContainerButtonUpgrade as VBoxContainer;
@onready var z_index_save: int = sprite.z_index;


func _ready() -> void:
	timer.timeout.connect(_enable_menu);
	sprite.z_index = roundi(global_position.y);


func _process(_delta: float) -> void:
	if targetable_enemy.is_empty(): return;

	select_target();
	if target != null: fire_target();


func _draw() -> void:
	if !menu_open: return;

	var hit_area_circle := hit_area.shape as CircleShape2D;
	draw_circle(hit_area.position, hit_area_circle.radius, Color("#30a0c0", 0.3));


func _on_area_entered(area: Area2D) -> void:
	if !(area is IEnemy): return;
	targetable_enemy.append(area);


func _on_area_exited(area: Area2D) -> void:
	if !(area is IEnemy) || targetable_enemy.find(area) == -1: return;

	targetable_enemy.erase(area);
	if target == area: target = null;


func _on_select_weakest_enemy_pressed() -> void:
	type_target = Target.Weakest;
	toggle_menu(false);


func _on_select_strongest_enemy_pressed() -> void:
	type_target = Target.Strongest;
	toggle_menu(false);


func _on_select_last_enemy_pressed() -> void:
	type_target = Target.Last;
	toggle_menu(false);


func _on_select_first_enemy_pressed() -> void:
	type_target = Target.First;
	toggle_menu(false);


func _on_select_random_enemy_pressed() -> void:
	type_target = Target.Random;
	toggle_menu(false);


func _on_close_gui_pressed() -> void:
	toggle_menu(false);


func _on_upgrade_tower_pressed() -> void:
	if Globals.level.money < stats.upgrade_price: return;
	Globals.level.money -= stats.upgrade_price;
	toggle_menu(false);
	upgraded = true;
	sprite.play("idle_2")
	upgrade_button.queue_free();


func _on_sell_tower_pressed() -> void:
	toggle_menu(false);
	var sell_money := (stats.base_price + stats.upgrade_price if upgraded else stats.base_price) * stats.sell_percent;
	Globals.level.money += roundi(sell_money);
	self.queue_free();


func _on_clickable_area_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if timer != null: return;
	if !event is InputEventMouseButton: return;

	var mouse_event := event as InputEventMouseButton;
	if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_pressed():
		toggle_menu(true);

		sprite.z_index = target_menu.z_index + 2;
		GuiTowerManager.last_visible_tower = self;


func _unhandled_input(event: InputEvent) -> void:
	if !event is InputEventMouseButton: return;

	var mouse_event := event as InputEventMouseButton;
	var right_or_left_click := (mouse_event.button_index == MOUSE_BUTTON_LEFT or mouse_event.button_index == MOUSE_BUTTON_RIGHT);

	if event.is_pressed() and right_or_left_click:
		if GuiTowerManager.last_visible_tower != null:
			GuiTowerManager.last_visible_tower.toggle_menu(false);

			var last_visible_tower_sprite := GuiTowerManager.last_visible_tower.get_node("AnimatedSprite2D") as AnimatedSprite2D;
			last_visible_tower_sprite.z_index = z_index_save;
			GuiTowerManager.last_visible_tower = null;


func _enable_menu() -> void:
	timer = null;


func calculate_bullet_damages() -> int:
	return stats.base_damage + stats.upgrade_damages if upgraded else stats.base_damage;


func fire_target() -> void:
	if reload_timer.is_stopped():
		reload_timer.start();

		var bullet := projectile_scene.instantiate() as IBullet;
		bullet.damages = calculate_bullet_damages();
		bullet.target = target;
		bullet.tower = self;
		bullet.speed = bullet_speed;

		$BulletContainer.add_child(bullet);
		bullet.global_position = aim_marker.global_position;

		if upgraded:
			bullet.set_sprite_texture(projectile_upgrade_texture);


func get_weakest_enemy(enemies: Array[IEnemy]) -> IEnemy:
	var lowest_health_enemy: IEnemy = null;
	var lowest_health: float = -1;

	for enemy in enemies:
		if lowest_health == -1 or enemy.health < lowest_health:
			lowest_health_enemy = enemy;
			lowest_health = enemy.health;

	return lowest_health_enemy;


func get_strongest_enemy(enemies: Array[IEnemy]) -> IEnemy:
	var strongest_health_enemy: IEnemy = null;
	var strongest_health: float = -1;

	for enemy in enemies:
		if enemy.health > strongest_health:
			strongest_health_enemy = enemy;
			strongest_health = enemy.health;

	return strongest_health_enemy;


func select_target() -> void:
	targetable_enemy = targetable_enemy.filter(func(enemy: IEnemy): return !enemy.is_dead);
	if targetable_enemy.is_empty(): return;

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
			target = targetable_enemy.pick_random();


func toggle_menu(display: bool) -> void:
	target_menu.visible = display;
	queue_redraw();
