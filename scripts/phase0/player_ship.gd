extends CharacterBody2D
# Phase 0: Player ship movement
# Click-to-move navigation with acceleration and friction

# Movement constants - tuned for "chill" feel
const MAX_SPEED = 300.0        # Maximum velocity in pixels per second
const ACCELERATION = 600.0     # Acceleration in pixels per second²
const FRICTION = 0.15          # Deceleration factor (0-1, higher = more drag)
const STOP_THRESHOLD = 3.0     # Speed below which the ship fully stops

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var has_target := false

func _ready():
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var target_position = get_global_mouse_position()
		nav_agent.target_position = target_position
		has_target = true

func _physics_process(delta):
	if has_target:
		_follow_path(delta)
	else:
		_apply_friction_and_move()

func _follow_path(delta):
	if nav_agent.is_navigation_finished():
		has_target = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		if velocity.length() < STOP_THRESHOLD:
			velocity = Vector2.ZERO
		move_and_slide()
		return

	var next_position = nav_agent.get_next_path_position()
	var desired_direction = (next_position - global_position)
	if global_position.distance_to(nav_agent.target_position) <= nav_agent.target_desired_distance:
		has_target = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		if velocity.length() < STOP_THRESHOLD:
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
	if velocity.length() < STOP_THRESHOLD:
		velocity = Vector2.ZERO

	# Clamp velocity to maximum speed to keep ship controllable
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Apply the velocity to move the ship
	# move_and_slide() handles frame-rate independent movement
	move_and_slide()
