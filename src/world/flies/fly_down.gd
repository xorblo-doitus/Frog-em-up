extends Fly





func _physics_process(delta: float) -> void:
	position.y += speed * delta
