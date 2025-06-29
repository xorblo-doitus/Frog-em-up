@tool
extends Node2D
class_name Fly

@onready var wing: Wing = $Wing/Wing
@export_range(0, 100, 1, "or_greater", "or_less") var score: int = 10
@export_range(1, 100, 1, "or_greater") var radius: int = 32:
	set(new):
		radius = new
		scale = Vector2.ONE * (new / 32.0)
@export_range(1, 100, 1, "or_greater") var hitbox_margin: int = 5
@export_range(1, 1000, 1, "or_greater") var speed: float = 500


func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)
	wing.animation_player.seek(0.5)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_on_mouse_input(event)


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, radius + hitbox_margin, Color.RED, false)


func _on_mouse_input(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if not event.pressed:
		return
	
	if event.global_position.distance_squared_to(global_position) > (radius + hitbox_margin)**2:
		return
	
	add_to_group(&"caught")
	Globals.score += score
