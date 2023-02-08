extends CharacterBody2D;
class_name PreviewTower;

@onready @export var isPreview: bool = false:
	set = _set_preview;

@onready @export var isValidPlacement: bool = true:
	set = _set_isValidPlacement;

func _set_preview(value: bool) -> void:
	modulate.a = .6 if value else 1.0
	isPreview = value;

func _set_isValidPlacement(value: bool) -> void:
	modulate =  Color(1, 1, 1, modulate.a) if value else Color(.8, .2, .2, modulate.a);
	isValidPlacement = value;
