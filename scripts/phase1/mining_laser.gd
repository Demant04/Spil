extends Line2D

@export var player_ship_path: NodePath

@onready var player_ship: Node = get_node_or_null(player_ship_path)

func _ready():
	visible = false

func _process(_delta):
	if player_ship == null:
		visible = false
		return
	if player_ship.mining_active and is_instance_valid(player_ship.mining_target):
		visible = true
		points = PackedVector2Array([
			to_local(player_ship.global_position),
			to_local(player_ship.mining_target.global_position)
		])
	else:
		visible = false
