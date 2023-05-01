extends CanvasLayer;

const PlacementTowerScene := preload("res://scenes/towers/placement_tower.tscn");

@onready var money_label := $MoneyDisplay as RichTextLabel;
@onready var health_label := $HealthDisplay as RichTextLabel;
@onready var wave_label := $WaveDisplay as RichTextLabel;
@onready var placement_towers_list := $TowerSelectorContainer/TowersList as HBoxContainer;


func _ready() -> void:
	for index in len(Globals.tower_stats):
		var tower_stat := Globals.tower_stats[index];

		var placement_tower := PlacementTowerScene.instantiate() as PlacementTower;
		placement_towers_list.add_child(placement_tower);
		placement_tower.set_tower(tower_stat.tower_scene, index);


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
