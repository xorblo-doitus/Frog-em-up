extends Node2D


@onready var menu: VBoxContainer = $GUI/Menu
@onready var score: Label = $GUI/Score


func _ready() -> void:
	Score.score_changed.connect(func(new_score): score.text = str(new_score))
	Score.highscore_changed.connect(
		func(new_score): score.text = "Highscore: " + str(new_score)
	)


func _on_play_pressed() -> void:
	menu.hide()
	Score.restart()
	score.show()
