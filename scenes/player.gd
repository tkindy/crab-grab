extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ALLOWED_JUMPS = 3

var jumps = ALLOWED_JUMPS
var _game_over = false

func _physics_process(delta: float) -> void:
  # Add the gravity.
  if not is_on_floor():
    velocity += get_gravity() * delta

  # Handle jump.
  if is_on_floor():
    jumps = ALLOWED_JUMPS

  if not _game_over and Input.is_action_just_pressed("jump") and jumps != 0:
    jumps -= 1
    velocity.y += JUMP_VELOCITY
    $AnimationPlayer.stop(true)
    $AnimationPlayer.play("jump")

  # Get the input direction and handle the movement/deceleration.
  var direction := Input.get_axis("move_left", "move_right")
  if not _game_over and direction:
    velocity.x = direction * SPEED
  else:
    velocity.x = move_toward(velocity.x, 0, SPEED)

  if not _game_over and $AnimationPlayer.current_animation != "jump":
    if velocity.x:
      $AnimationPlayer.play("walk")
    else:
      $AnimationPlayer.play("RESET")

  move_and_slide()


func set_game_over():
  _game_over = true
  collision_mask = 0b010
  $AnimationPlayer.play("die")


func restart_game():
  _game_over = false
  collision_mask = 0b110
  $AnimationPlayer.play("RESET")
