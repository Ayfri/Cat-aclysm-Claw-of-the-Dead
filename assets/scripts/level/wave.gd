class_name Wave;
extends Resource;


@export var zombie_count: int;
@export var big_probability : float;
@export var max_duration: float;
@export var possible_path: Array[String];


@warning_ignore('shadowed_variable')
func _init(
	zombie_count: int = 5,
	big_probability: float = 0.1,
	max_duration: float = -1,
	possible_path: Array[String] = ["FirstPath"],
):
	self.zombie_count = zombie_count;
	self.big_probability = big_probability;
	self.max_duration = max_duration;
	self.possible_path = possible_path;
