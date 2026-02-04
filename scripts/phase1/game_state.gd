extends Node

signal cargo_changed(current: int, capacity: int)
signal credits_changed(current: int)
signal upgrade_changed(new_capacity: int)

const RESOURCE_TYPE := "Iron"
const UPGRADE_COST := 500
const UPGRADE_AMOUNT := 50

var credits := 0
var cargo_capacity := 100
var cargo_current := 0

func add_cargo(amount: int) -> int:
	var space_left = cargo_capacity - cargo_current
	if space_left <= 0:
		return 0
	var added = min(amount, space_left)
	cargo_current += added
	emit_signal("cargo_changed", cargo_current, cargo_capacity)
	return added

func sell_all() -> int:
	if cargo_current <= 0:
		return 0
	var earned = cargo_current
	cargo_current = 0
	credits += earned
	emit_signal("cargo_changed", cargo_current, cargo_capacity)
	emit_signal("credits_changed", credits)
	return earned

func can_upgrade() -> bool:
	return credits >= UPGRADE_COST

func upgrade_cargo() -> bool:
	if credits < UPGRADE_COST:
		return false
	credits -= UPGRADE_COST
	cargo_capacity += UPGRADE_AMOUNT
	emit_signal("credits_changed", credits)
	emit_signal("cargo_changed", cargo_current, cargo_capacity)
	emit_signal("upgrade_changed", cargo_capacity)
	return true
