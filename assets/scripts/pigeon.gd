extends Node2D

@onready var audio_stream_player := $AudioStreamPlayer as AudioStreamPlayer;
var speed = 130;

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 88;
	position.y = 116;
	audio_stream_player.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta;
	if position.x > 1700:
		speed = 130;
	if position.x > 5000:
		position.x = 50;

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if !event is InputEventMouseButton: return;

	var mouse_button_event := event as InputEventMouseButton;
	if mouse_button_event.button_index == MOUSE_BUTTON_LEFT and mouse_button_event.is_pressed():
		audio_stream_player.play();
		speed = speed * 2 ;
