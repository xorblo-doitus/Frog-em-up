@tool
extends Fly



func _physics_process(delta: float) -> void:
	super(delta)
	
	global_position = global_position.move_toward(
		Globals.frog.global_position,
		speed * delta
	)
