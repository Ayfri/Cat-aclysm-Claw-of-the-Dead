extends CanvasLayer;

@onready var scoreLabel = $RichTextLabel as RichTextLabel;

func _process(delta: float) -> void:
	if Globals.level == null:
		return;

	var text = """
		[img=32x32]assets/sprites/ui/coin_cat.png[/img][font_size=big]test %s[/font_size]
	""";
	text = text.strip_edges();

	scoreLabel.text = text % Globals.level.money;
