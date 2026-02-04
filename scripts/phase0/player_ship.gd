extends CharacterBody2D
# Phase 0 + Phase 1: Player ship movement and mining
# Click-to-move navigation with acceleration and friction
# Left-click asteroid to mine, right-click to move

# Movement constants - tuned for "chill" feel
const MAX_SPEED = 300.0        # Maximum velocity in pixels per second
const ACCELERATION = 600.0     # Acceleration in pixels per second²
const FRICTION = 0.15          # Deceleration factor (0-1, higher = more drag)
const STOP_THRESHOLD = 3.0     # Speed below which the ship fully stops

# Mining constants
const MINING_RANGE = 60.0      # Distance to start mining

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var mining_laser: Line2D = $MiningLaser
@onready var game_state: Node = get_node("/root/GameStateSingleton")

var has_target := false

# Mining state
var mining_target: Area2D = null  # The asteroid we're targeting
var is_mining := false            # Are we currently mining?

func _ready():
	set_process_unhandled_input(true)

	# Hide mining laser initially
	if mining_laser:
		mining_laser.visible = false

	# Connect to asteroid field when scene is ready
	call_deferred("_connect_to_asteroid_field")

func _connect_to_asteroid_field():
	var asteroid_field = get_tree().get_first_node_in_group("asteroid_field")
	if asteroid_field == null:
		# Try to find by name
		asteroid_field = get_node_or_null("/root/Main/AsteroidField")
	if asteroid_field:
		asteroid_field.asteroid_clicked.connect(_on_asteroid_clicked)

func _on_asteroid_clicked(asteroid: Area2D):
	"""Handle when player clicks on an asteroid."""
	# Stop any current mining
	stop_mining()

	# Set as new mining target
	mining_target = asteroid

	# Navigate to asteroid
	nav_agent.target_position = asteroid.global_position
	has_target = true

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		# Right-click: manual movement (cancels mining)
		stop_mining()
		mining_target = null

		var target_position = get_global_mouse_position()
		nav_agent.target_position = target_position
		has_target = true

func _physics_process(delta):
	if has_target:
		_follow_path(delta)
	else:
		_apply_friction_and_move()

	# Check if we should start mining
	if mining_target and not is_mining:
		var distance = global_position.distance_to(mining_target.global_position)
		if distance <= MINING_RANGE:
			start_mining()

	# Process mining
	if is_mining:
		_process_mining(delta)

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
	if desired_direction.length() < 1.0:
		has_target = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		if velocity.length() < STOP_THRESHOLD:
			velocity = Vector2.ZERO
		move_and_slide()
		return
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

# --- Mining Methods (Phase 1) ---

func start_mining():
	"""Start mining the current target asteroid."""
	if mining_target == null or mining_target.is_depleted:
		return

	is_mining = true
	has_target = false  # Stop moving
	velocity = Vector2.ZERO

	mining_target.start_mining()
	_show_laser()

func stop_mining():
	"""Stop mining and hide laser."""
	if is_mining and mining_target:
		mining_target.stop_mining()

	is_mining = false
	_hide_laser()

func _process_mining(delta):
	"""Process ongoing mining."""
	if mining_target == null:
		stop_mining()
		return

	# Check if target moved out of range
	var distance = global_position.distance_to(mining_target.global_position)
	if distance > MINING_RANGE * 1.5:
		stop_mining()
		return

	# Update laser visual
	_update_laser()

	# Let the asteroid process mining
	var mining_complete = mining_target.process_mining(delta)

	if mining_complete:
		# Mining finished - collect resources
		var amount = game_state.add_resource("iron", mining_target.IRON_YIELD)
		if amount < mining_target.IRON_YIELD:
			# Cargo was full or nearly full
			pass  # Game state already emits cargo_full signal

		stop_mining()
		mining_target = null

func _show_laser():
	"""Show the mining laser."""
	if mining_laser:
		mining_laser.visible = true
		_update_laser()

func _hide_laser():
	"""Hide the mining laser."""
	if mining_laser:
		mining_laser.visible = false

func _update_laser():
	"""Update laser line points."""
	if mining_laser and mining_target:
		# Laser goes from ship (local origin) to target (converted to local coords)
		var target_local = to_local(mining_target.global_position)
		mining_laser.clear_points()
		mining_laser.add_point(Vector2.ZERO)
		mining_laser.add_point(target_local)
