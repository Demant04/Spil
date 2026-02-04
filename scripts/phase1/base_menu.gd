extends CanvasLayer
# Phase 1: Base station menu for selling resources and buying upgrades

# Constants
const IRON_PRICE := 10  # credits per iron
const CARGO_UPGRADE_COST := 500
const CARGO_UPGRADE_AMOUNT := 50

# UI References
@onready var panel: PanelContainer = $CenterContainer/PanelContainer
@onready var iron_label: Label = $CenterContainer/PanelContainer/VBoxContainer/SellSection/IronLabel
@onready var sell_button: Button = $CenterContainer/PanelContainer/VBoxContainer/SellSection/SellButton
@onready var upgrade_label: Label = $CenterContainer/PanelContainer/VBoxContainer/UpgradeSection/UpgradeLabel
@onready var upgrade_button: Button = $CenterContainer/PanelContainer/VBoxContainer/UpgradeSection/UpgradeButton
@onready var close_button: Button = $CenterContainer/PanelContainer/VBoxContainer/CloseButton
@onready var game_state: Node = get_node("/root/GameState")

func _ready():
	add_to_group("base_menu")

	# Connect button signals
	sell_button.pressed.connect(_on_sell_pressed)
	upgrade_button.pressed.connect(_on_upgrade_pressed)
	close_button.pressed.connect(_on_close_pressed)

	# Connect to GameState signals
	game_state.cargo_changed.connect(_on_cargo_changed)
	game_state.credits_changed.connect(_on_credits_changed)

	# Start hidden
	hide_menu()

func show_menu():
	visible = true
	_update_display()

func hide_menu():
	visible = false

func _update_display():
	_update_sell_display()
	_update_upgrade_display()

func _update_sell_display():
	var iron_amount = game_state.get_resource_amount("iron")
	var potential_credits = iron_amount * IRON_PRICE

	if iron_amount > 0:
		iron_label.text = "Iron: %d units (worth %d credits)" % [iron_amount, potential_credits]
		sell_button.disabled = false
	else:
		iron_label.text = "Iron: 0 units"
		sell_button.disabled = true

func _update_upgrade_display():
	if game_state.has_upgrade("cargo_upgrade_1"):
		upgrade_label.text = "Cargo Expansion: OWNED"
		upgrade_button.text = "Owned"
		upgrade_button.disabled = true
	else:
		upgrade_label.text = "Cargo Expansion: +%d capacity (%d credits)" % [CARGO_UPGRADE_AMOUNT, CARGO_UPGRADE_COST]
		if game_state.credits >= CARGO_UPGRADE_COST:
			upgrade_button.text = "Buy"
			upgrade_button.disabled = false
		else:
			upgrade_button.text = "Need %d credits" % CARGO_UPGRADE_COST
			upgrade_button.disabled = true

func _on_sell_pressed():
	var iron_amount = game_state.get_resource_amount("iron")
	if iron_amount <= 0:
		return

	var credits_earned = iron_amount * IRON_PRICE

	# Remove all iron
	game_state.remove_resource("iron", iron_amount)

	# Add credits
	game_state.add_credits(credits_earned)

	_update_display()

func _on_upgrade_pressed():
	if game_state.purchase_upgrade("cargo_upgrade_1", CARGO_UPGRADE_COST):
		_update_display()

func _on_close_pressed():
	hide_menu()

func _on_cargo_changed(_resource: String, _amount: int):
	if visible:
		_update_sell_display()

func _on_credits_changed(_amount: int):
	if visible:
		_update_upgrade_display()
