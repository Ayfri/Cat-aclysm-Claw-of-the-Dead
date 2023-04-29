class_name PlacementTower;
extends Node;


@onready var viewport = $SubViewportContainer/SubViewport as SubViewport;

var index: int;


func set_tower(tower_scene: PackedScene, index: int) -> void:
	self.index = index;

	var tower_instance := tower_scene.instantiate() as ITower;
	tower_instance.process_mode = Node.PROCESS_MODE_DISABLED;

	viewport.add_child(tower_instance);
	tower_instance.position = viewport.size / 2;


func _on_pressed() -> void:
	Globals.level.map.current_tower_index = index;
