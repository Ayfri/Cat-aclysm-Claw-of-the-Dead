extends Node2D

@onready var pigeon := $AnimatedSprite2D as AnimatedSprite2D;
@onready var audio_stream_player := $AudioStreamPlayer as AudioStreamPlayer;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	audio_stream_player.play();
	pigeon.position.x += 130 * delta;
	if pigeon.position.x > 5000:
		pigeon.position.x = 50;

