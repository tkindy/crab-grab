extends Node2D


const FISH = preload("res://scenes/fish.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  pass


func _on_fish_spawn_timer_timeout() -> void:
  var new_fish = FISH.instantiate()

  var spawn_side_index = randi() % 2
  new_fish.moving_left = spawn_side_index == 1

  var spawn_side = [$FishSpawnLeft, $FishSpawnRight][spawn_side_index]
  var spawn_location: PathFollow2D = spawn_side.get_node("SpawnLocation")
  spawn_location.progress_ratio = randf()

  var direction = spawn_location.rotation - PI / 2

  new_fish.position = spawn_location.position

  $Fish.add_child(new_fish)
