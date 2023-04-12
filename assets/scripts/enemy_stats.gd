class_name EnemyStats;
extends Resource

@export var base_health: float;
@export var base_speed : float;
@export var base_reward: float;

func _init(base_health: int, base_speed: int, base_reward: int):
	self.base_health = base_health;
	self.base_speed = base_speed;
	self.base_reward = base_reward;
