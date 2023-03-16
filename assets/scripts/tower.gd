class_name Tower;
extends Node2D;

const BulletScene := preload("res://scenes/bullet.tscn")
enum Target {First = 0, Last = 1, Strongest = 2, Weakest = 3, Random = 4};

@onready var bulletSpeed := 300;
@onready var damage := 5;
@onready var price: int;
@onready var sellPrice: int;
@onready var sprite = $Sprite2D
@onready var typeTarget: Target;
@onready var target: Enemy;
@onready var targetableEnemy: Array[Area2D] = [];
@onready var targetMenu = get_child(7);
@onready var RandomNumber = RandomNumberGenerator.new();


func _ready():
	RandomNumber.randomize();


func _process(delta: float):
	if targetableEnemy.is_empty():
		return;


	if target != null:
		select_target();
		fire_target();
	else:
		select_target();


func select_target():
	match typeTarget:
		0:
			target = targetableEnemy.front();
		1:
			target = targetableEnemy.back();
		2:
			target = get_strongest_enemy(targetableEnemy);
		3:
			target = get_weakest_enemy(targetableEnemy);
		4:
			randomize_target();


func randomize_target():
	match RandomNumber.randi_range(0,3):
		0:
			target = targetableEnemy.front();
			print(0);
		1:
			target = targetableEnemy.back();
			print(1);
		2:
			target = get_strongest_enemy(targetableEnemy);
			print(2);
		3:
			target = get_weakest_enemy(targetableEnemy);
			print(3);


func get_weakest_enemy(enemies: Array[Area2D]) -> Area2D:
	var lowest_health_enemy: Area2D = null;
	var lowest_health: float = -1;


	for enemy in enemies:
		if lowest_health == -1 or enemy.enemyLife < lowest_health:
			lowest_health_enemy = enemy;
			lowest_health = enemy.enemyLife;
	
	return lowest_health_enemy;


func get_strongest_enemy(enemies: Array[Area2D]) -> Area2D:
	var strongest_health_enemy: Area2D = null;
	var strongest_health: float = -1;
	
	for enemy in enemies:
		if enemy.enemyLife > strongest_health:
			strongest_health_enemy = enemy;
			strongest_health = enemy.enemyLife;
	
	return strongest_health_enemy;


func fire_target():
	if $ReloadTimer.is_stopped():
		$ReloadTimer.start();
		var bullet = BulletScene.instantiate();
		bullet.damage = damage;
		bullet.speed = bulletSpeed;
		bullet.target = target;
		$BulletContainer.add_child(bullet);
		bullet.global_position = $Aim.global_position;


func _on_area_entered(area: Area2D):
	if area is Enemy:
		targetableEnemy.append(area);


func _on_area_exited(area: Area2D):
	if targetableEnemy.find(area) != -1:
		targetableEnemy.erase(area);
		if target == area:
			target = null;


func _on_select_weakest_enemy_pressed():
	typeTarget = Target.Weakest;
	targetMenu.visible = false;


func _on_select_strongest_enemy_pressed():
	typeTarget = Target.Strongest;
	targetMenu.visible = false;


func _on_select_last_enemy_pressed():
	typeTarget = Target.Last;
	targetMenu.visible = false;


func _on_select_first_enemy_pressed():
	typeTarget = Target.First;
	targetMenu.visible = false;


func _on_select_random_enemy_pressed():
	typeTarget = Target.Random;
	targetMenu.visible = false;


func _on_clickable_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if targetMenu.visible == true:
			targetMenu.visible = false;
		else:
			targetMenu.visible = true;
