extends Path2D


@export var fly_scene: PackedScene
@export var delay: float = 1
@export var delay_random_delta: float = 0.5
@export var speed_multiplier_base: float = 1
@export var speed_multiplier_delta: float = 0.2


var _timer: Timer = Timer.new()
var _follower: PathFollow2D = PathFollow2D.new()


func _ready() -> void:
	add_child(_timer)
	add_child(_follower)
	
	_timer.timeout.connect(spawn)
	Globals.play.connect(restart_timer)
	Globals.loose.connect(_timer.stop)


func spawn() -> void:
	_follower.progress_ratio = randf()
	var global_pos: Vector2 = _follower.global_position
	
	var new_fly: Fly = fly_scene.instantiate()
	new_fly.speed *= speed_multiplier_base + (randf()-0.5) * speed_multiplier_delta * 2.0
	add_child(new_fly)
	new_fly.global_position = global_pos
	print(new_fly.global_position)
	restart_timer()


func restart_timer() -> void:
	_timer.start(delay + (randf()-0.5) * delay_random_delta*2)
