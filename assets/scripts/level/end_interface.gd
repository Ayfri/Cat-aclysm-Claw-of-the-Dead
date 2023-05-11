class_name EndInterface;
extends PanelContainer;


@onready var buttons_container := $PanelContainer/ButtonsContainer as MarginContainer;
@onready var end_title_label := %EndTitle as RichTextLabel;
@onready var health_label := %Health as RichTextLabel;
@onready var killed_zombies_label := %KilledZombies as RichTextLabel;
@onready var panel_container := $PanelContainer as PanelContainer;
@onready var time_label := %Time as RichTextLabel;
@onready var total_money_label := %TotalMoney as RichTextLabel;
@onready var total_score_label := %TotalScore as RichTextLabel;
@onready var waves_label := %Waves as RichTextLabel;


func refresh_values(win: bool) -> void:
	end_title_label.text = end_title_label.text % ("You won" if win else "Game over");

	if !win:
		waves_label.visible = true;
		waves_label.text = waves_label.text % [Globals.level.wave, Globals.waves.size() + 1];
		buttons_container.add_theme_constant_override("margin_top", 460);
		panel_container.custom_minimum_size.y = 550;
	else:
		time_label.visible = true;

	health_label.text = health_label.text % Globals.level.health;
	killed_zombies_label.text = killed_zombies_label.text % Globals.level.killed_zombies;
	total_money_label.text = total_money_label.text % Globals.level.total_money;
	total_score_label.text = total_score_label.text % Globals.level.score;
	time_label.text = time_label.text % ("%02d:%02d" % [Globals.level.time / 60, Globals.level.time % 60]);


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene();


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn");
