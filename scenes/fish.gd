extends "res://scenes/abstract_fish.gd"


func get_width():
  return $Sprite2D.texture.get_size().x * $Sprite2D.scale.x


func _on_body_entered(body: Node2D) -> void:
  set_deferred("monitoring", false)

  $AnimationPlayer.play("catch")
  await $AnimationPlayer.animation_finished

  queue_free()
