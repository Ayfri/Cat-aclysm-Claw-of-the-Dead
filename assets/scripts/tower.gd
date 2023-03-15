class_name Tower;
extends Area2D;

const BulletScene := preload("res://scenes/bullet.tscn")
enum Target {Closest = 0, Furthest = 1, Strongest = 2, Weakest = 3, Random = 4};

@onready var bulletSpeed := 300;
@onready var damage := 5;
@onready var price: int;
@onready var sellPrice: int;
@onready var sprite = $Sprite2D
@onready var typeTarget: Target;
@onready var target: Enemy;
@onready var targetableEnemy: Array[Enemy] = [];

func _process(delta: float):
	if targetableEnemy.is_empty():
		return;

	if target != null:
		fire_target();
	else:
		select_target();

func select_target():
	target = targetableEnemy.back()

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
	if area is Enemy && targetableEnemy.find(area) != -1:
		targetableEnemy.erase(area);
