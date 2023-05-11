class_name PlacementTower;
extends Button;


var index: int;

var price_label_text := """
	[center][color=%s][font size=30]%s[/font] [img=28x28]assets/sprites/ui/coin_cat.png[/img][/color][/center]
""".strip_edges();

var purchasable: bool:
	set(value):
		purchasable = value;
		if price_label == null: return;

		var color := "#ffffff" if value else "#ff7070";
		price_label.text = price_label_text % [color, tower_stats.base_price];

var tower_stats: TowerStats = null;

@onready var price_label := $PriceLabel as RichTextLabel;
@onready var viewport := $SubViewportContainer/SubViewport as SubViewport;


func _on_pressed() -> void:
	var map := Globals.level.map as Map;
	map.update_selected_tower(index);


func set_tower(tower_scene: PackedScene, index: int) -> void:
	self.index = index;

	var tower := tower_scene.instantiate() as ITower;
	tower.process_mode = Node.PROCESS_MODE_DISABLED;

	viewport.add_child(tower);
	tower.position = viewport.size / 2;
	tower_stats = tower.stats;
