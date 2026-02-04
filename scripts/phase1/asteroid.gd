extends Area2D
# Phase 1: Mineable asteroid

# Signals
signal clicked(asteroid: Area2D)
signal mining_started(asteroid: Area2D)
signal mining_progress_updated(progress_percent: float)
signal mining_complete(asteroid: Area2D, resource: String, amount: int)
signal depleted(asteroid: Area2D)

# Constants
const MINING_TIME := 4.0  # seconds to fully mine
const IRON_YIELD := 10    # iron per asteroid

# State
var mining_progress := 0.0
var is_being_mined := false
var is_depleted := false

@onready var sprite: Sprite2D = $Sprite2D
@onready var progress_bar: ProgressBar = $ProgressBar

func _ready():
	# Connect input event for click detection
	input_event.connect(_on_input_event)

	# Hide progress bar initially
	if progress_bar:
		progress_bar.visible = false
		progress_bar.value = 0

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int):
	if is_depleted:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			clicked.emit(self)

func start_mining():
	"""Called when ship arrives and starts mining."""
	if is_depleted or is_being_mined:
		return

	is_being_mined = true
	mining_progress = 0.0

	if progress_bar:
		progress_bar.visible = true
		progress_bar.value = 0

	mining_started.emit(self)

func stop_mining():
	"""Called when mining is interrupted."""
	is_being_mined = false

	if progress_bar:
		progress_bar.visible = false

func process_mining(delta: float) -> bool:
	"""Process mining tick. Returns true when mining is complete."""
	if not is_being_mined or is_depleted:
		return false

	mining_progress += delta
	var progress_percent = (mining_progress / MINING_TIME) * 100.0

	if progress_bar:
		# Smooth progress bar update
		progress_bar.value = lerp(progress_bar.value, progress_percent, 0.2)

	mining_progress_updated.emit(progress_percent)

	# Visual feedback: shrink slightly while being mined
	var shrink_factor = 1.0 - (mining_progress / MINING_TIME) * 0.3
	if sprite:
		sprite.scale = Vector2.ONE * shrink_factor

	if mining_progress >= MINING_TIME:
		_complete_mining()
		return true

	return false

func _complete_mining():
	"""Called when mining finishes."""
	is_being_mined = false
	is_depleted = true

	if progress_bar:
		progress_bar.visible = false

	# Visual feedback: fade out
	if sprite:
		sprite.modulate = Color(0.3, 0.3, 0.3, 0.5)

	mining_complete.emit(self, "iron", IRON_YIELD)
	depleted.emit(self)

func reset_asteroid():
	"""Reset asteroid for respawning."""
	is_depleted = false
	is_being_mined = false
	mining_progress = 0.0

	if sprite:
		sprite.scale = Vector2.ONE
		sprite.modulate = Color.WHITE

	if progress_bar:
		progress_bar.visible = false
		progress_bar.value = 0
