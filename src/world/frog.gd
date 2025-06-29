@tool
extends Node2D


@export_range(-180, 180, 0.001, "radians_as_degrees") var min_tongue_angle_rad: float = -PI
@export_range(-180, 180, 0.001, "radians_as_degrees") var max_tongue_angle_rad: float = PI

@onready var tongue: Marker2D = $Tongue
@onready var tongue_line: Line2D = $Tongue/TongueLine
@onready var tongue_tip: Sprite2D = $Tongue/TongueTip

func _process(delta: float) -> void:
	tongue.look_at(get_global_mouse_position() - Vector2(0, 50))
	tongue.rotation = clamp(tongue.rotation + PI/2, min_tongue_angle_rad, max_tongue_angle_rad)
