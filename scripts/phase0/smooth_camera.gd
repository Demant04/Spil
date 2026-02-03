extends Camera2D
# Phase 0: Smooth camera follow
# Uses lerp (linear interpolation) to smoothly follow the player ship

var player_ship: CharacterBody2D = null
const FOLLOW_SPEED = 0.08  # Lerp factor (0-1): lower = smoother/laggier, higher = tighter/more rigid

func _ready():
	# Find the player ship in the scene tree
	# Assumes PlayerShip is a sibling node under the same parent
	player_ship = get_node("../PlayerShip")

	if player_ship == null:
		push_error("Player ship not found! Check scene structure.")

func _process(_delta):
	# Update camera position every visual frame (not physics frame)
	# This ensures smooth camera movement at display refresh rate
	if player_ship != null:
		# Lerp smoothly moves camera toward ship position
		# FOLLOW_SPEED determines how quickly the camera catches up
		global_position = global_position.lerp(player_ship.global_position, FOLLOW_SPEED)
