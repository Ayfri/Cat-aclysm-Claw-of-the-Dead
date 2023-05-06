class_name PlacementTower;
extends Node;


var index: int;

@onready var price_label := $PriceLabel as RichTextLabel;
@onready var viewport = $SubViewportContainer/SubViewport as SubViewport;



func set_tower(tower_scene: PackedScene, index: int) -> void:
	self.index = index;

	var tower := tower_scene.instantiate() as ITower;
	tower.process_mode = Node.PROCESS_MODE_DISABLED;

	viewport.add_child(tower);
	tower.position = viewport.size / 2;
	print(tower.name, tower.stats)
	price_label.text = price_label.text % tower.stats.base_price;


func _on_pressed() -> void:
	var map := Globals.level.map as Map;
	map.update_selected_tower(index);
