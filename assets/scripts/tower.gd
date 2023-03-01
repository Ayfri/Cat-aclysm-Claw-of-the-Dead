class_name Tower
extends Area2D 

const Bullet = preload("res://scenes/bullet.tscn")
enum Target {Closest = 0, Furthest = 1, Strongest = 2, Weakest = 3, Random = 4};

#@onready var bulletSpeed: int;
#@onready var damage: int;
@onready var bulletSpeed = 100;
@onready var damage = 5;
@onready var price: int;
@onready var sellPrice: int;
@onready var sprite = $Sprite2D
@onready var typeTarget: Target;
@onready var target: Enemy;
@onready var targetableEnemy: Array[Enemy];


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if targetableEnemy.is_empty():
		return
	if target != null:
		fireTarget()
	else:
		selectTarget()


func selectTarget():
	target = targetableEnemy.back()


func fireTarget():
	if $ReloadTimer.is_stopped():
		$ReloadTimer.start()
		print("on tire")
		var bullet = Bullet.instantiate()
		bullet.damage = damage
		bullet.speed = bulletSpeed
		bullet.target = target
		get_node("BulletContainer").add_child(bullet)
		bullet.global_position = $Aim.global_position


func _on_area_entered(area: Enemy):
	if "enemy" in area.name:
		print("un ennemi est entré")
		targetableEnemy.append(area)


func _on_area_exited(area: Enemy):
	print("un ennemi est sorti")
	if targetableEnemy.find(area) != -1 :
		targetableEnemy.erase(area)
