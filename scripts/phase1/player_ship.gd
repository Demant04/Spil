extends CharacterBody2D

const MAX_SPEED = 300.0
const ACCELERATION = 600.0
const FRICTION = 0.15
const MINING_TIME = 3.5
const MINING_RANGE = 48.0
const MINING_YIELD = 10

@export var asteroid_collision_mask := 2
@export var game_state_path: NodePath

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var game_state: Node = get_node_or_null(game_state_path)

var has_target := false
var mining_target: Area2D = null
var mining_progress := 0.0
var mining_active := false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			_clear_mining()
			var target_position = get_global_mouse_position()
			nav_agent.target_position = target_position
			has_target = true
		elif event.button_index == MOUSE_BUTTON_LEFT:
			_try_set_mining_target()

func _physics_process(delta):
	if mining_target != null:
		_handle_mining(delta)
	elif has_target:
		_follow_path(delta)
	else:
		_apply_friction_and_move()

func _try_set_mining_target():
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collide_with_bodies = false
	query.collision_mask = asteroid_collision_mask
	var results = space_state.intersect_point(query, 1)
	if results.is_empty():
		return
	var collider = results[0].collider
	if collider == null or not collider.is_in_group("asteroids"):
		return
	mining_target = collider
	mining_progress = 0.0
	mining_active = false
	nav_agent.target_position = mining_target.global_position
	has_target = true

func _handle_mining(delta):
	if not is_instance_valid(mining_target):
		_clear_mining()
		return

	var distance_to_target = global_position.distance_to(mining_target.global_position)
	if distance_to_target > MINING_RANGE:
		mining_active = false
		nav_agent.target_position = mining_target.global_position
		has_target = true
		_follow_path(delta)
		return

	has_target = false
	velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
	move_and_slide()
	mining_active = true
	mining_progress += delta

	if mining_progress >= MINING_TIME:
		var harvested = mining_target.harvest(MINING_YIELD)
		var added = 0
		if game_state != null:
			added = game_state.add_cargo(harvested)
		if added < harvested:
			_clear_mining()
		mining_progress = 0.0

func _follow_path(delta):
	if nav_agent.is_navigation_finished():
		has_target = false
		velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		move_and_slide()
		return

	var next_position = nav_agent.get_next_path_position()
	var desired_direction = (next_position - global_position)
	if global_position.distance_to(nav_agent.target_position) <= nav_agent.target_desired_distance:
		has_target = false
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var desired_velocity = desired_direction.normalized() * MAX_SPEED
	velocity = velocity.move_toward(desired_velocity, ACCELERATION * delta)
	if velocity.length() > 0.0:
		rotation = velocity.angle() + PI / 2.0
	_apply_friction_and_move()

func _apply_friction_and_move():
	velocity *= (1.0 - FRICTION)
	if velocity.length() < 1.0:
		velocity = Vector2.ZERO
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	move_and_slide()

func _clear_mining():
	mining_target = null
	mining_progress = 0.0
	mining_active = false
