@tool
extends Sprite2D


@export_range(-180, 180, 0.001, "radians_as_degrees") var min_angle_rad: float = -PI
@export_range(-180, 180, 0.001, "radians_as_degrees") var max_angle_rad: float = PI


@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	look_at(get_global_mouse_position() - Vector2(0, 100))
	rotation += PI/2
	rotation = clamp(rotation, min_angle_rad, max_angle_rad)
