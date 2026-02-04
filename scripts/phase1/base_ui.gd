extends Control

@export var game_state_path: NodePath

@onready var game_state: Node = get_node_or_null(game_state_path)
@onready var sell_button: Button = $Panel/VBoxContainer/SellButton
@onready var upgrade_button: Button = $Panel/VBoxContainer/UpgradeButton
@onready var info_label: Label = $Panel/VBoxContainer/InfoLabel

func _ready():
	sell_button.pressed.connect(_on_sell_pressed)
	upgrade_button.pressed.connect(_on_upgrade_pressed)
	if game_state != null:
		game_state.cargo_changed.connect(_update_info)
		game_state.credits_changed.connect(_update_info)
		game_state.upgrade_changed.connect(_update_info)
	_update_info()

func _on_sell_pressed():
	if game_state == null:
		return
	game_state.sell_all()

func _on_upgrade_pressed():
	if game_state == null:
		return
	game_state.upgrade_cargo()
	_update_info()

func _update_info(_value = null):
	if game_state == null:
		return
	upgrade_button.disabled = not game_state.can_upgrade()
	info_label.text = "Upgrade: +%d cargo (Cost: %d)" % [game_state.UPGRADE_AMOUNT, game_state.UPGRADE_COST]
