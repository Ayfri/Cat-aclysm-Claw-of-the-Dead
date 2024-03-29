class_name LevelInterface;
extends CanvasLayer;


const PlacementTowerScene := preload("res://scenes/towers/placement_tower.tscn");

var placement_towers: Array[PlacementTower] = [];

@onready var end_panel := $EndInterface as EndInterface;
@onready var money_label := $MoneyDisplay as RichTextLabel;
@onready var health_label := $HealthDisplay as RichTextLabel;
@onready var placement_towers_list := $TowerSelectorContainer/TowersList as HBoxContainer;
@onready var wave_label := $WaveDisplay as RichTextLabel;


func _ready() -> void:
	for index in len(Globals.tower_stats):
		var tower_stat := Globals.tower_stats[index];

		var placement_tower := PlacementTowerScene.instantiate() as PlacementTower;
		placement_towers_list.add_child(placement_tower);
		placement_tower.set_tower(tower_stat.tower_scene, index);
		placement_tower.purchasable = false;
		placement_towers.append(placement_tower);


func _process(_delta: float) -> void:
	if Globals.level == null: return;

	var money_label_text := """
		[img=40x40]assets/sprites/ui/coin_cat.png[/img] [font_size=41]%s[/font_size]
	""".strip_edges();

	var health_label_text := """
		[img=40x40]assets/sprites/ui/heart_cat.png[/img] [font_size=41]%s[/font_size]
	""".strip_edges();

	var wave_label_text := """
		[font_size=41]Wave: %s[/font_size]
	""".strip_edges();

	money_label.text = money_label_text % Globals.level.money;
	health_label.text = health_label_text % Globals.level.health;
	wave_label.text = wave_label_text % Globals.level.wave;

	for tower in placement_towers:
		tower.purchasable = tower.tower_stats.base_price <= Globals.level.money;


func show_end_panel(win: bool) -> void:
	end_panel.refresh_values(win);
	end_panel.visible = true;
