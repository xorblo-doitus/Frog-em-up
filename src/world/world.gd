extends Node2D


@onready var menu: VBoxContainer = $GUI/Menu
@onready var score: Label = $GUI/Score
@onready var high_score: Label = $GUI/Menu/HighScore

@onready var frog: Frog = $Frog


func _ready() -> void:
	Globals.frog = frog
	Globals.score_changed.connect(func(new_score): score.text = str(new_score))
	Globals.highscore_changed.connect(
		func(new_score): high_score.text = "Highscore: " + str(new_score)
	)
	Globals.loose.connect(_on_lost)


func _physics_process(delta: float) -> void:
	Globals.difficulty += delta/20


func _on_play_pressed() -> void:
	menu.hide()
	score.show()
	Globals.restart()
	for fly in get_tree().get_nodes_in_group("fly"):
		fly.queue_free()
	frog.lives = 4
	frog.global_position.x = 540


func _on_lost() -> void:
	menu.show()
	high_score.show()
