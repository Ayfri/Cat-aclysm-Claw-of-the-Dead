extends Area2D

@export var speed = 300
@export var effect_duration = 5

func _ready():
	position.x = randf_range(400,1200)

func _process(delta):
	position.y += speed * delta
	if position.y > 900:
		position.y = -200
		position.x = randf_range(400,1200)
		visible = true

func apply_powerup_effect():
		Globals.enemy_speed = 400;
		await get_tree().create_timer(2.0).timeout
		Globals.enemy_speed = 20;

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		visible = false
		apply_powerup_effect()
