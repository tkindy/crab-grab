extends CanvasLayer

signal play_again


func set_score(score: int) -> void:
  $ScoreDescription.text = "You caught %s fish" % score


func set_leaderboard(leaderboard: Leaderboard) -> void:
  $Leaderboard.set_leaderboard(leaderboard)


func _on_retry_button_pressed() -> void:
  play_again.emit()
