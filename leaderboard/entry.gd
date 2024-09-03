class_name LeaderboardEntry

var _score: int


func _init(score: int):
  self._score = score


static func from(csv_line: PackedStringArray) -> LeaderboardEntry:
  return LeaderboardEntry.new(int(csv_line[0]))


func get_score() -> int:
  return _score


func to_csv():
  return [str(_score)]
