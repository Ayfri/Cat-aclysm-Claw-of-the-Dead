extends Camera2D

@export var min_zoom := 1.0;
@export var max_zoom := 10.0;
@export var zoom_factor := .1;
@export var zoom_duration := 0.2;
@export var pan_duration := 0.1
@export var pan_speed := 0.1

var _mouse_position: Vector2;

var _zoom_level := min_zoom:
	set = _set_zoom_level;

func _set_zoom_level(value: float) -> void:
	if _zoom_level == min_zoom:
		position = _mouse_position;

	_zoom_level = clamp(value, min_zoom, max_zoom);

	if _zoom_level == max_zoom:
		return;

	var tween := create_tween();
	tween.set_trans(Tween.TRANS_SINE);
	tween.set_ease(Tween.EASE_OUT);
	tween.set_parallel(true);

	if _zoom_level > zoom.x && position != _mouse_position:
#		tween.tween_property(
#			self,
#			"position",
#			lerp(position, _mouse_position, .5),
#			pan_duration
#		);
		position = lerp(position, _mouse_position, .5);

	tween.tween_property(
		self,
		"zoom",
		_zoom_level * Vector2.ONE,
		zoom_duration
	);

func _unhandled_input(event: InputEvent):
	if not event is InputEventMouse:
		return;

	var mouse_event := event as InputEventMouse;
	if mouse_event is InputEventMouseMotion:
		_mouse_position = get_global_mouse_position();
		
		if mouse_event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			var clamped_position: Vector2 = mouse_event.relative / zoom;
			position -= clamped_position;
	
	if mouse_event.is_action_pressed("Zoom Out"):
		_set_zoom_level(_zoom_level * (1 - zoom_factor));
	if mouse_event.is_action_pressed("Zoom In"):
		_set_zoom_level(_zoom_level * (1 + zoom_factor));
		
