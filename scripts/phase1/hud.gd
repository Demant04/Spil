extends CanvasLayer

@export var game_state_path: NodePath
@export var player_ship_path: NodePath
@export var base_ui_path: NodePath

@onready var cargo_label: Label = $HUDPanel/CargoLabel
@onready var credits_label: Label = $HUDPanel/CreditsLabel
@onready var mining_bar: ProgressBar = $HUDPanel/MiningProgress
@onready var game_state: Node = get_node_or_null(game_state_path)
@onready var player_ship: Node = get_node_or_null(player_ship_path)
@onready var base_ui: Control = get_node_or_null(base_ui_path)

func _ready():
	if game_state != null:
		game_state.cargo_changed.connect(_on_cargo_changed)
		game_state.credits_changed.connect(_on_credits_changed)
		_on_cargo_changed(game_state.cargo_current, game_state.cargo_capacity)
		_on_credits_changed(game_state.credits)
	if base_ui != null:
		base_ui.hide()

func _process(_delta):
	if player_ship == null:
		mining_bar.visible = false
		return
	if player_ship.mining_active:
		mining_bar.visible = true
		mining_bar.value = (player_ship.mining_progress / player_ship.MINING_TIME) * 100.0
	else:
		mining_bar.visible = false

func show_base_ui():
	if base_ui != null:
		base_ui.show()

func hide_base_ui():
	if base_ui != null:
		base_ui.hide()

func _on_cargo_changed(current: int, capacity: int):
	cargo_label.text = "Cargo (Iron): %d/%d" % [current, capacity]

func _on_credits_changed(current: int):
	credits_label.text = "Credits: %d" % current
