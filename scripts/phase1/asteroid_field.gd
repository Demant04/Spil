extends Node2D
# Phase 1: Asteroid field spawner
# Spawns a cluster of mineable asteroids

# Signals - forwarded from individual asteroids
signal asteroid_clicked(asteroid: Area2D)

# Constants
const MIN_ASTEROIDS := 3
const MAX_ASTEROIDS := 5
const SPAWN_RADIUS := 300.0
const MIN_SPACING := 80.0  # Minimum distance between asteroids

# Preload asteroid scene
var asteroid_scene = preload("res://scenes/asteroid.tscn")

# Track spawned asteroids
var asteroids: Array[Area2D] = []

func _ready():
	add_to_group("asteroid_field")
	spawn_asteroids()

func spawn_asteroids():
	var num_asteroids = randi_range(MIN_ASTEROIDS, MAX_ASTEROIDS)
	var spawn_positions: Array[Vector2] = []

	for i in range(num_asteroids):
		var spawn_pos = _find_valid_spawn_position(spawn_positions)
		spawn_positions.append(spawn_pos)

		var asteroid = asteroid_scene.instantiate()
		asteroid.position = spawn_pos
		add_child(asteroid)
		asteroids.append(asteroid)

		# Connect asteroid signals
		asteroid.clicked.connect(_on_asteroid_clicked)

func _find_valid_spawn_position(existing_positions: Array[Vector2]) -> Vector2:
	"""Find a position that doesn't overlap with existing asteroids."""
	var max_attempts = 50

	for _attempt in range(max_attempts):
		# Random position within spawn radius
		var angle = randf() * TAU
		var distance = randf() * SPAWN_RADIUS
		var pos = Vector2(cos(angle), sin(angle)) * distance

		# Check distance from all existing positions
		var valid = true
		for existing_pos in existing_positions:
			if pos.distance_to(existing_pos) < MIN_SPACING:
				valid = false
				break

		if valid:
			return pos

	# Fallback: return random position anyway
	var angle = randf() * TAU
	var distance = randf() * SPAWN_RADIUS
	return Vector2(cos(angle), sin(angle)) * distance

func _on_asteroid_clicked(asteroid: Area2D):
	"""Forward asteroid click to anyone listening."""
	asteroid_clicked.emit(asteroid)

func get_asteroids() -> Array[Area2D]:
	"""Get list of all asteroids in this field."""
	return asteroids

func respawn_asteroid_at(old_position: Vector2):
	"""Respawn a depleted asteroid near its old position after delay."""
	# TODO: Add respawn timer if needed for gameplay balance
	pass
