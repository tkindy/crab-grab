class_name Leaderboard

const PATH = "user://leaderboard.csv"
const MAX_ENTRIES = 3

var _entries: Array[LeaderboardEntry]

static func open() -> Leaderboard:
  var file = FileAccess.open(PATH, FileAccess.READ)
  if file == null and FileAccess.get_open_error() == Error.ERR_FILE_NOT_FOUND:
    return Leaderboard.new()

  var entries: Array[LeaderboardEntry] = []

  while file.get_position() < file.get_length():
    entries.append(LeaderboardEntry.from(file.get_csv_line()))

  var leaderboard = Leaderboard.new()
  leaderboard._entries = entries
  return leaderboard


func get_entries() -> Array[LeaderboardEntry]:
  return _entries


func add(entry: LeaderboardEntry) -> void:
  var spot = 0
  for i in range(_entries.size()):
    if entry.get_score() > _entries[i].get_score():
      break
    spot += 1

  var result = _entries.slice(0, spot)
  result.append(entry)
  result.append_array(_entries.slice(spot))

  _entries = result.slice(0, MAX_ENTRIES)


func write() -> void:
  var file = FileAccess.open(PATH, FileAccess.WRITE)
  for entry in _entries:
    file.store_csv_line(entry.to_csv())
