extends Fly





func _physics_process(delta: float) -> void:
	super(delta)
	
	position.y += speed * delta
