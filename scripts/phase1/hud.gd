extends CanvasLayer
# Phase 1: HUD display for cargo and credits

@onready var cargo_label: Label = $MarginContainer/VBoxContainer/CargoLabel
@onready var credits_label: Label = $MarginContainer/VBoxContainer/CreditsLabel
@onready var game_state: Node = get_node("/root/GameStateSingleton")
@onready var minimap_container: PanelContainer = $MinimapContainer
@onready var minimap_viewport: SubViewport = $MinimapContainer/MinimapViewportContainer/MinimapViewport

var minimap_scene: PackedScene = preload("res://scenes/minimap.tscn")
var minimap_instance: Node2D

func _ready():
	# Connect to GameState signals
	game_state.credits_changed.connect(_on_credits_changed)
	game_state.cargo_changed.connect(_on_cargo_changed)
	game_state.cargo_full.connect(_on_cargo_full)

	minimap_instance = minimap_scene.instantiate()
	minimap_viewport.add_child(minimap_instance)
	minimap_container.gui_input.connect(_on_minimap_gui_input)

	# Initial display
	_update_cargo_display()
	_update_credits_display()

func _on_credits_changed(_new_amount: int):
	_update_credits_display()

func _on_cargo_changed(_resource: String, _new_amount: int):
	_update_cargo_display()

func _on_cargo_full():
	# Brief visual feedback when cargo is full
	cargo_label.modulate = Color(1, 0.5, 0.5)  # Reddish tint
	var tween = create_tween()
	tween.tween_property(cargo_label, "modulate", Color.WHITE, 0.5)

func _update_cargo_display():
	var iron = game_state.get_resource_amount("iron")
	var max_cargo = game_state.cargo_max
	cargo_label.text = "Iron: %d/%d" % [iron, max_cargo]

func _update_credits_display():
	credits_label.text = "Credits: %d" % game_state.credits

func _on_minimap_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var viewport_container := $MinimapContainer/MinimapViewportContainer
		var local_event := minimap_container.make_input_local(event)
		var local_pos := local_event.position - viewport_container.position
		if local_pos.x < 0 or local_pos.y < 0:
			return
		if local_pos.x > minimap_viewport.size.x or local_pos.y > minimap_viewport.size.y:
			return

		if minimap_instance and minimap_instance.has_method("minimap_to_world"):
			var world_pos: Vector2 = minimap_instance.call("minimap_to_world", local_pos)
			_set_player_target(world_pos)
			minimap_container.accept_event()

func _set_player_target(world_pos: Vector2) -> void:
	var player_ship := get_tree().get_first_node_in_group("player")
	if player_ship == null:
		return
	var nav_agent := player_ship.get_node_or_null("NavigationAgent2D") as NavigationAgent2D
	if nav_agent == null:
		return
	nav_agent.target_position = world_pos
	player_ship.set("has_target", true)
