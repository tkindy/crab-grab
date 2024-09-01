extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ALLOWED_JUMPS = 3

var jumps = ALLOWED_JUMPS

func _physics_process(delta: float) -> void:
  # Add the gravity.
  if not is_on_floor():
    velocity += get_gravity() * delta

  # Handle jump.
  if is_on_floor():
    jumps = ALLOWED_JUMPS

  if Input.is_action_just_pressed("jump") and jumps != 0:
    jumps -= 1
    velocity.y += JUMP_VELOCITY

  # Get the input direction and handle the movement/deceleration.
  var direction := Input.get_axis("move_left", "move_right")
  if direction:
    velocity.x = direction * SPEED
  else:
    velocity.x = move_toward(velocity.x, 0, SPEED)

  if velocity.x:
    $AnimationPlayer.play("walk")
  else:
    $AnimationPlayer.play("RESET")

  move_and_slide()
