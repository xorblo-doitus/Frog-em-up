extends Node


signal score_changed(new_score: int)
signal highscore_changed(new_high_score: int)

var score: int = 0:
	set(new):
		score = new
		score_changed.emit(new)
var highscore: int = 0:
	set(new):
		highscore = new
		highscore_changed.emit(new)


func restart() -> void:
	if score > highscore:
		highscore = score
	score = 0
