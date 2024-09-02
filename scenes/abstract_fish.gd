extends Area2D

const SPEED = 120

var moving_left: bool

func _ready() -> void:
  var half_width = get_width() / 2
  $VisibleOnScreenNotifier2D.rect.position = Vector2(-half_width, 0)
  $VisibleOnScreenNotifier2D.rect.end = Vector2(half_width, 0)

  if moving_left:
    position.x += half_width
  else:
    position.x -= half_width
    scale.x = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
  var x_change = SPEED * delta

  if moving_left:
    position.x -= x_change
  else:
    position.x += x_change


func game_over():
  collision_mask = 0b0


func restart_game():
  collision_mask = 0b1


func _on_body_entered(body: Node2D) -> void:
  queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
  queue_free()


func get_width() -> int:
  assert(false, "Not implemented")
  return 0
