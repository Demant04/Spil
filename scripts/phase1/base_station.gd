extends Area2D

@export var hud_path: NodePath

@onready var hud: CanvasLayer = get_node_or_null(hud_path)

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	update()

func _draw():
	draw_circle(Vector2.ZERO, 36.0, Color(0.2, 0.8, 0.9))
	draw_circle(Vector2.ZERO, 24.0, Color(0.1, 0.3, 0.4))

func _on_body_entered(body):
	if body.name != "PlayerShip":
		return
	if hud != null:
		hud.show_base_ui()

func _on_body_exited(body):
	if body.name != "PlayerShip":
		return
	if hud != null:
		hud.hide_base_ui()
