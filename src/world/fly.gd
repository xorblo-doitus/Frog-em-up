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

@onready var buzz: AudioStreamPlayer = $Buzz

var alive: bool = true


func _ready() -> void:
	if Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)
	wing.animation_player.seek(0.5)
	Globals.loose.connect(func(): speed = 0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		_on_mouse_input(event)


@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if alive and is_touching(Globals.frog.global_position):
		Globals.frog.hit()
		queue_free()


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO, radius + hitbox_margin, Color.RED, false)


func _on_mouse_input(event: InputEventMouseButton) -> void:
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if not event.pressed:
		return
	
	if not is_touching(event.global_position):
		return
	
	alive = false
	add_to_group(&"caught")
	Globals.score += score
	buzz.finished.connect(buzz.queue_free)
	buzz.play()
	buzz.reparent(Globals.frog)


func is_touching(global_point: Vector2) -> bool:
	return global_point.distance_squared_to(global_position) < (radius + hitbox_margin)**2
