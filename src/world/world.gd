extends Node2D


@onready var menu: VBoxContainer = $GUI/Menu
@onready var score: Label = $GUI/Score

@onready var frog: Node2D = $Frog


func _ready() -> void:
	Globals.frog = frog
	Globals.score_changed.connect(func(new_score): score.text = str(new_score))
	Globals.highscore_changed.connect(
		func(new_score): score.text = "Highscore: " + str(new_score)
	)


func _on_play_pressed() -> void:
	menu.hide()
	Globals.restart()
	score.show()
	Globals.play.emit()
