extends Area2D
# Phase 1: Base station for selling resources and buying upgrades

# Signals
signal player_entered()
signal player_exited()

# State
var player_in_range := false
var base_menu: CanvasLayer = null

func _ready():
	# Connect body detection signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	# Find or wait for base menu
	call_deferred("_find_base_menu")

func _find_base_menu():
	base_menu = get_tree().get_first_node_in_group("base_menu")
	if base_menu == null:
		base_menu = get_node_or_null("/root/Main/BaseMenu")

func _on_body_entered(body: Node2D):
	if body.is_in_group("player") or body.name == "PlayerShip":
		player_in_range = true
		player_entered.emit()
		_show_menu()

func _on_body_exited(body: Node2D):
	if body.is_in_group("player") or body.name == "PlayerShip":
		player_in_range = false
		player_exited.emit()
		_hide_menu()

func _show_menu():
	if base_menu and base_menu.has_method("show_menu"):
		base_menu.show_menu()

func _hide_menu():
	if base_menu and base_menu.has_method("hide_menu"):
		base_menu.hide_menu()
