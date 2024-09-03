extends Label


func set_leaderboard(leaderboard: Leaderboard) -> void:
  var content = ""
  var entries = leaderboard.get_entries()

  for i in entries.size():
    content += "%s. %s\n" % [i + 1, entries[i].get_score()]

  text = content
