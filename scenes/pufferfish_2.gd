extends "res://scenes/abstract_fish.gd"


func get_width() -> int:
  return $Body.texture.get_size().x * $Body.scale.x
