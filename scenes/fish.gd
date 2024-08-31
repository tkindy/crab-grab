extends Area2D

const SPEED = 120

var moving_left: bool

func _ready() -> void:
  var half_width = $Sprite2D.texture.get_size().x * $Sprite2D.scale.x / 2

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
