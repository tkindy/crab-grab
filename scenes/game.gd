extends Node2D

signal game_over
signal restart_game

const FISH = preload("res://scenes/fish.tscn")
const PUFFER = preload("res://scenes/pufferfish.tscn")
const PUFFER_RATIO = 0.2

var score = 0


func _on_fish_spawn_timer_timeout() -> void:
  var is_puffer = randf() < PUFFER_RATIO

  var scene = PUFFER if is_puffer else FISH
  var new_fish = scene.instantiate()

  var spawn_side_index = randi() % 2
  new_fish.moving_left = spawn_side_index == 1

  var spawn_side = [$FishSpawnLeft, $FishSpawnRight][spawn_side_index]
  var spawn_location: PathFollow2D = spawn_side.get_node("SpawnLocation")
  spawn_location.progress_ratio = randf()

  new_fish.position = spawn_location.position

  var body_entered_callback = _on_puffer_entered if is_puffer else _on_fish_entered
  new_fish.body_entered.connect(body_entered_callback)
  game_over.connect(new_fish.game_over)
  restart_game.connect(new_fish.restart_game)

  $Fish.add_child(new_fish)


func _on_fish_entered(body: Node2D) -> void:
  _increment_score()


func _on_puffer_entered(body: Node2D) -> void:
  game_over.emit()

  $FishSpawnTimer.stop()
  $Player.set_game_over()

  var overlay = load("res://scenes/game_over_overlay.tscn").instantiate()
  overlay.set_score(score)
  overlay.play_again.connect(_on_play_again)

  add_child(overlay)


func _on_play_again() -> void:
  restart_game.emit()
  _set_score(0)
  get_node("GameOverOverlay").queue_free()

  for fish in $Fish.get_children():
    fish.queue_free()

  $FishSpawnTimer.start()
  $Player.restart_game()


func _increment_score() -> void:
  _set_score(score + 1)


func _set_score(new_score: int) -> void:
  score = new_score
  $Score.text = "Score: %d" % score
