extends "res://scenes/abstract_fish.gd"


func get_width() -> int:
  return $Body.texture.get_size().x * $Body.scale.x


func _on_body_entered(body: Node2D) -> void:
  # Override default behavior to remove
  pass
