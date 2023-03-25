extends CanvasLayer;

@onready var scoreLabel = $RichTextLabel as RichTextLabel;

func _process(_delta: float) -> void:
	if Globals.level == null: return;

	var text = """
		[img=40x40]assets/sprites/ui/coin_cat.png[/img][font_size=42]%s[/font_size]
	""".strip_edges();

	scoreLabel.text = text % Globals.level.money;
