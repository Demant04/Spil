extends Area2D

signal depleted(asteroid: Area2D)

@export var resource_type := "Iron"
@export var total_amount := 40
@export var radius := 26.0

var remaining_amount := 0

func _ready():
	remaining_amount = total_amount
	add_to_group("asteroids")
	update()

func _draw():
	var color = Color(0.6, 0.6, 0.7)
	draw_circle(Vector2.ZERO, radius, color)
	draw_circle(Vector2.ZERO, radius - 6.0, Color(0.3, 0.3, 0.4))

func harvest(amount: int) -> int:
	if remaining_amount <= 0:
		return 0
	var harvested = min(amount, remaining_amount)
	remaining_amount -= harvested
	if remaining_amount <= 0:
		emit_signal("depleted", self)
		queue_free()
	return harvested
