extends Node


signal score_changed(new_score: int)
signal highscore_changed(new_high_score: int)


signal play()
signal loose()

var playing: bool = false
var frog: Frog


var score: int = 0:
	set(new):
		score = new
		score_changed.emit(new)
var highscore: int = 0:
	set(new):
		highscore = new
		highscore_changed.emit(new)


func restart() -> void:
	score = 0
	playing = true
	play.emit()


func stop():
	if score > highscore:
		highscore = score
	playing = false
	loose.emit()
