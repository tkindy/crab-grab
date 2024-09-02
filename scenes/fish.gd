extends "res://scenes/abstract_fish.gd"


func get_width():
  return $Sprite2D.texture.get_size().x * $Sprite2D.scale.x
