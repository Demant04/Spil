extends Node
class_name GameState
# Phase 1: Global game state singleton (autoload)
# Manages credits, cargo, upgrades, and persistence

# Signals for UI updates
signal credits_changed(new_amount: int)
signal cargo_changed(resource: String, new_amount: int)
signal cargo_full()
signal upgrade_purchased(upgrade_id: String)

# Economy
var credits: int = 0

# Cargo system
var cargo: Dictionary = {"iron": 0}
var cargo_max: int = 100

# Upgrades - track which upgrades have been purchased
var upgrades: Dictionary = {
	"cargo_upgrade_1": false
}

# Constants
const SAVE_PATH := "user://save.json"

func _ready():
	load_game()

# --- Cargo Management ---

func add_resource(resource: String, amount: int) -> int:
	"""Add resource to cargo. Returns amount actually added (may be less if cargo full)."""
	var space_remaining = get_cargo_space_remaining()
	var actual_amount = min(amount, space_remaining)

	if actual_amount <= 0:
		cargo_full.emit()
		return 0

	if not cargo.has(resource):
		cargo[resource] = 0

	cargo[resource] += actual_amount
	cargo_changed.emit(resource, cargo[resource])

	if get_cargo_space_remaining() <= 0:
		cargo_full.emit()

	return actual_amount

func remove_resource(resource: String, amount: int) -> bool:
	"""Remove resource from cargo. Returns true if successful."""
	if not cargo.has(resource) or cargo[resource] < amount:
		return false

	cargo[resource] -= amount
	cargo_changed.emit(resource, cargo[resource])
	return true

func get_resource_amount(resource: String) -> int:
	"""Get current amount of a specific resource."""
	return cargo.get(resource, 0)

func get_cargo_total() -> int:
	"""Get total cargo currently held."""
	var total = 0
	for resource in cargo:
		total += cargo[resource]
	return total

func get_cargo_space_remaining() -> int:
	"""Get remaining cargo space."""
	return cargo_max - get_cargo_total()

func is_cargo_full() -> bool:
	"""Check if cargo is full."""
	return get_cargo_total() >= cargo_max

# --- Credits Management ---

func add_credits(amount: int):
	"""Add credits."""
	credits += amount
	credits_changed.emit(credits)

func spend_credits(amount: int) -> bool:
	"""Spend credits if enough available. Returns true if successful."""
	if credits < amount:
		return false
	credits -= amount
	credits_changed.emit(credits)
	return true

# --- Upgrade Management ---

func has_upgrade(upgrade_id: String) -> bool:
	"""Check if an upgrade has been purchased."""
	return upgrades.get(upgrade_id, false)

func purchase_upgrade(upgrade_id: String, cost: int) -> bool:
	"""Purchase an upgrade. Returns true if successful."""
	if has_upgrade(upgrade_id):
		return false  # Already owned

	if not spend_credits(cost):
		return false  # Not enough credits

	upgrades[upgrade_id] = true
	_apply_upgrade(upgrade_id)
	upgrade_purchased.emit(upgrade_id)
	save_game()
	return true

func _apply_upgrade(upgrade_id: String):
	"""Apply the effects of an upgrade."""
	match upgrade_id:
		"cargo_upgrade_1":
			cargo_max += 50

# --- Save/Load ---

func save_game():
	"""Save game state to file."""
	var save_data = {
		"credits": credits,
		"cargo": cargo,
		"cargo_max": cargo_max,
		"upgrades": upgrades
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

func load_game():
	"""Load game state from file."""
	if not FileAccess.file_exists(SAVE_PATH):
		return  # No save file, use defaults

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return

	var json_string = file.get_as_text()
	file.close()

	var json = JSON.new()
	var parse_result = json.parse(json_string)
	if parse_result != OK:
		push_warning("Failed to parse save file, using defaults")
		return

	var save_data = json.data
	if typeof(save_data) != TYPE_DICTIONARY:
		return

	# Restore state
	credits = save_data.get("credits", 0)
	cargo = save_data.get("cargo", {"iron": 0})
	cargo_max = save_data.get("cargo_max", 100)
	upgrades = save_data.get("upgrades", {"cargo_upgrade_1": false})

	# Re-apply upgrades (in case cargo_max wasn't saved correctly)
	for upgrade_id in upgrades:
		if upgrades[upgrade_id]:
			_apply_upgrade(upgrade_id)

func reset_game():
	"""Reset all progress (for testing)."""
	credits = 0
	cargo = {"iron": 0}
	cargo_max = 100
	upgrades = {"cargo_upgrade_1": false}

	# Delete save file
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

	credits_changed.emit(credits)
	cargo_changed.emit("iron", 0)
