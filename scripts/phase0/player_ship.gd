extends CharacterBody2D
# Phase 0: Player ship movement
# Simple acceleration-based movement with rotation and friction

# Movement constants - tuned for "chill" feel
const MAX_SPEED = 300.0        # Maximum velocity in pixels per second
const ACCELERATION = 600.0     # Acceleration in pixels per second²
const FRICTION = 0.15          # Deceleration factor (0-1, higher = more drag)
const ROTATION_SPEED = 3.0     # Rotation speed in radians per second

func _physics_process(delta):
	# Read input axes
	# ui_left/ui_right are mapped to A/D and Left/Right arrow keys
	# ui_up/ui_down are mapped to W/S and Up/Down arrow keys
	var rotation_input = Input.get_axis("ui_left", "ui_right")
	var thrust_input = Input.get_axis("ui_up", "ui_down")

	# Rotate the ship based on left/right input
	rotation += rotation_input * ROTATION_SPEED * delta

	# Calculate thrust direction based on ship's rotation
	# Vector2.UP points to (0, -1), we rotate it to match ship's facing
	var thrust_direction = Vector2.UP.rotated(rotation)

	# Apply acceleration when thrust input is present
	if thrust_input != 0:
		velocity += thrust_direction * thrust_input * ACCELERATION * delta

	# Always apply friction to create natural deceleration
	# This gives the ship a satisfying "drift" feel
	velocity *= (1.0 - FRICTION)

	# Clamp velocity to maximum speed to keep ship controllable
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Apply the velocity to move the ship
	# move_and_slide() handles frame-rate independent movement
	move_and_slide()
