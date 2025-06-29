extends Node2D


@onready var menu: VBoxContainer = $GUI/Menu
@onready var score: Label = $GUI/Score
@onready var high_score: Label = $GUI/Menu/HighScore

@onready var frog: Node2D = $Frog


func _ready() -> void:
	Globals.frog = frog
	Globals.score_changed.connect(func(new_score): score.text = str(new_score))
	Globals.highscore_changed.connect(
		func(new_score): high_score.text = "Highscore: " + str(new_score)
	)
	Globals.loose.connect(_on_lost)


func _on_play_pressed() -> void:
	menu.hide()
	score.show()
	Globals.restart()


func _on_lost() -> void:
	menu.show()
	high_score.show()
