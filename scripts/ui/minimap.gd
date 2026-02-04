extends Node2D

const WORLD_BOUNDS := Rect2(Vector2(-2000, -2000), Vector2(4000, 4000))
const PLAYER_COLOR := Color(0.2, 1, 0.2)
const BASE_COLOR := Color(1, 0.8, 0.2)
const ASTEROID_COLOR := Color(0.7, 0.7, 0.7)
const PLAYER_RADIUS := 4.0
const BASE_RADIUS := 5.0
const ASTEROID_RADIUS := 3.0

var minimap_size := Vector2(200, 200)
var player: Node2D
var base_station: Node2D
var asteroid_field: Node2D

func _ready():
	_update_references()
	_update_minimap_size()
	set_process(true)

func _process(_delta: float) -> void:
	_update_references()
	_update_minimap_size()
	queue_redraw()

func _update_minimap_size() -> void:
	var viewport := get_viewport()
	if viewport:
		minimap_size = viewport.get_visible_rect().size

func _update_references() -> void:
	if player == null or not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player") as Node2D
	if base_station == null or not is_instance_valid(base_station):
		var stations := get_tree().get_nodes_in_group("BaseStation")
		if stations.size() > 0:
			base_station = stations[0] as Node2D
		else:
			base_station = get_node_or_null("/root/Main/BaseStation") as Node2D
	if asteroid_field == null or not is_instance_valid(asteroid_field):
		asteroid_field = get_tree().get_first_node_in_group("asteroid_field") as Node2D

func world_to_minimap(world_pos: Vector2) -> Vector2:
	var normalized := (world_pos - WORLD_BOUNDS.position) / WORLD_BOUNDS.size
	return normalized * minimap_size

func minimap_to_world(minimap_pos: Vector2) -> Vector2:
	var normalized := minimap_pos / minimap_size
	return WORLD_BOUNDS.position + (normalized * WORLD_BOUNDS.size)

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, minimap_size), Color(0, 0, 0, 0.4), true)
	draw_rect(Rect2(Vector2.ZERO, minimap_size), Color(0.2, 0.6, 1, 0.6), false, 1.0)

	if asteroid_field and asteroid_field.has_method("get_asteroids"):
		var asteroids := asteroid_field.call("get_asteroids")
		for asteroid in asteroids:
			if asteroid and is_instance_valid(asteroid):
				draw_circle(world_to_minimap(asteroid.global_position), ASTEROID_RADIUS, ASTEROID_COLOR)

	if base_station and is_instance_valid(base_station):
		draw_circle(world_to_minimap(base_station.global_position), BASE_RADIUS, BASE_COLOR)

	if player and is_instance_valid(player):
		draw_circle(world_to_minimap(player.global_position), PLAYER_RADIUS, PLAYER_COLOR)
