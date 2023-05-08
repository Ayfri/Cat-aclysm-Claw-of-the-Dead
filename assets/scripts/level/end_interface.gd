class_name EndInterface;
extends PanelContainer;


@onready var health_label := %Health as RichTextLabel;
@onready var killed_zombies_label := %KilledZombies as RichTextLabel;
@onready var total_money_label := %TotalMoney as RichTextLabel;
@onready var total_score_label := %TotalScore as RichTextLabel;


func refresh_values() -> void:
	health_label.text = health_label.text % Globals.level.health;


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene();


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn");
