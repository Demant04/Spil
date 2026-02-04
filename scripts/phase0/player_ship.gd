extends CharacterBody2D
# Phase 0: Player ship movement
# Simple acceleration-based movement with rotation and friction

# Movement constants - tuned for "chill" feel
const MAX_SPEED = 300.0        # Maximum velocity in pixels per second
const ACCELERATION = 600.0     # Acceleration in pixels per second²
const FRICTION = 0.15          # Deceleration factor (0-1, higher = more drag)
const ROTATION_SPEED = 3.0     # Rotation speed in radians per second
const TARGET_STOP_DISTANCE = 10.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var has_target := false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var target_position = get_global_mouse_position()
		nav_agent.target_position = target_position
		has_target = true

func _physics_process(delta):
	# Read input axes
	# ui_left/ui_right are mapped to A/D and Left/Right arrow keys
	# ui_up/ui_down are mapped to W/S and Up/Down arrow keys
	var rotation_input = Input.get_axis("ui_left", "ui_right")
	var thrust_input = Input.get_axis("ui_up", "ui_down")

	if rotation_input != 0 or thrust_input != 0:
		has_target = false

	if has_target:
		_follow_path(delta)
	else:
		_manual_move(delta, rotation_input, thrust_input)

func _manual_move(delta, rotation_input, thrust_input):
	# Rotate the ship based on left/right input
	rotation += rotation_input * ROTATION_SPEED * delta

	# Calculate thrust direction based on ship's rotation
	# Vector2.UP points to (0, -1), we rotate it to match ship's facing
	var thrust_direction = Vector2.UP.rotated(rotation)

	# Apply acceleration when thrust input is present
	if thrust_input != 0:
		velocity += thrust_direction * thrust_input * ACCELERATION * delta

	_apply_friction_and_move()

func _follow_path(delta):
	if nav_agent.is_navigation_finished():
		has_target = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		move_and_slide()
		return

	var next_position = nav_agent.get_next_path_position()
	var desired_direction = (next_position - global_position)
	if desired_direction.length() <= TARGET_STOP_DISTANCE:
		has_target = false
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var desired_velocity = desired_direction.normalized() * MAX_SPEED
	velocity = velocity.move_toward(desired_velocity, ACCELERATION * delta)
	rotation = velocity.angle() + PI / 2.0
	_apply_friction_and_move()

func _apply_friction_and_move():
	# Always apply friction to create natural deceleration
	# This gives the ship a satisfying "drift" feel
	velocity *= (1.0 - FRICTION)

	# Clamp velocity to maximum speed to keep ship controllable
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Apply the velocity to move the ship
	# move_and_slide() handles frame-rate independent movement
	move_and_slide()
