extends CanvasLayer
# Phase 1: HUD display for cargo and credits

@onready var cargo_label: Label = $MarginContainer/VBoxContainer/CargoLabel
@onready var credits_label: Label = $MarginContainer/VBoxContainer/CreditsLabel

func _ready():
	# Connect to GameState signals
	GameState.credits_changed.connect(_on_credits_changed)
	GameState.cargo_changed.connect(_on_cargo_changed)
	GameState.cargo_full.connect(_on_cargo_full)

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
	var iron = GameState.get_resource_amount("iron")
	var max_cargo = GameState.cargo_max
	cargo_label.text = "Iron: %d/%d" % [iron, max_cargo]

func _update_credits_display():
	credits_label.text = "Credits: %d" % GameState.credits
