extends CanvasLayer;

@onready var money_label := $MoneyDisplay as RichTextLabel;
@onready var health_label := $HealthDisplay as RichTextLabel;

func _process(_delta: float) -> void:
	if Globals.level == null: return;

	var money_label_text := """
		[img=40x40]assets/sprites/ui/coin_cat.png[/img] [font_size=42]%s[/font_size]
	""".strip_edges();

	var health_label_text := """
		[img=40x40]assets/sprites/ui/heart_cat.png[/img] [font_size=42]%s[/font_size]
	""".strip_edges();

	money_label.text = money_label_text % Globals.level.money;
	health_label.text = health_label_text % Globals.level.health;
