@tool
extends Node2D


@export_range(-180, 180, 0.001, "radians_as_degrees") var min_tongue_angle_rad: float = -PI
@export_range(-180, 180, 0.001, "radians_as_degrees") var max_tongue_angle_rad: float = PI

@onready var tongue: Marker2D = $Tongue
@onready var tongue_line: Line2D = $Tongue/TongueLine
@onready var tongue_tip: Sprite2D = $Tongue/TongueTip
@onready var croak: AudioStreamPlayer = $Croak

var _tongue_out: bool = false
@warning_ignore("unused_private_class_variable")
var _tongue_global_position: Vector2:
	set(new):
		tongue_tip.global_position = new
		tongue_line.set_point_position(1, tongue_line.to_local(new))
	get:
		return tongue_tip.global_position


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if _tongue_out:
		return
	tongue.look_at(get_global_mouse_position() - Vector2(0, 50))
	tongue.rotation = clamp(tongue.rotation + PI/2, min_tongue_angle_rad, max_tongue_angle_rad)

var tween: Tween
func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if not event.pressed:
		return
	
	tween = create_tween()
	const duration = 0.04
	tween.tween_property(self, ^"_tongue_global_position", event.global_position, duration)
	
	_tongue_out = true
	tongue.rotation = 0
	
	tween.finished.connect(_on_tween_end.bind(tween))
	
	tween.play()
	croak.play(0.1)


func _on_tween_end(finished_tween: Tween) -> void:
	catch_all()
	
	if finished_tween != tween:
		return
	
	tween = create_tween()
	const duration = 0.1
	tween.tween_property(self, ^"_tongue_global_position", tongue.global_position + Vector2(0, -24), duration)
	tween.finished.connect(_on_retract_end.bind(tween))
	tween.play()


func _on_retract_end(finished_tween: Tween) -> void:
	if finished_tween != tween:
		return
	
	_tongue_out = false
	
	for fly: Fly in get_tree().get_nodes_in_group(&"caught"):
		fly.queue_free()



func catch_all() -> void:
	for fly: Fly in get_tree().get_nodes_in_group(&"caught"):
		fly.reparent(tongue_tip)
