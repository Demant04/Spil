extends Sprite2D
# Phase 1: Procedurally generated base station sprite
# Creates a simple station shape at runtime

const BASE_SIZE := 96
const BASE_COLOR := Color(0.6, 0.6, 0.7)  # Metallic gray
const ACCENT_COLOR := Color(0.3, 0.5, 0.8)  # Blue accent

func _ready():
	texture = _create_base_texture()

func _create_base_texture() -> ImageTexture:
	var image = Image.create(BASE_SIZE, BASE_SIZE, false, Image.FORMAT_RGBA8)
	var center = Vector2(BASE_SIZE / 2.0, BASE_SIZE / 2.0)

	# Fill with transparent
	image.fill(Color(0, 0, 0, 0))

	# Draw main station body (octagon-ish shape)
	for x in range(BASE_SIZE):
		for y in range(BASE_SIZE):
			var pos = Vector2(x, y)
			var rel = pos - center

			# Create octagonal shape using max of x and y distances
			var dist_x = abs(rel.x)
			var dist_y = abs(rel.y)
			var dist_diag = (dist_x + dist_y) * 0.7

			var max_dist = max(dist_x, max(dist_y, dist_diag))

			if max_dist < 35:
				# Main body
				var color = BASE_COLOR
				# Add some panel lines
				if int(x) % 12 == 0 or int(y) % 12 == 0:
					color = color.darkened(0.2)
				# Darken edges
				color = color.darkened(max_dist / 70.0)
				image.set_pixel(x, y, color)

			# Draw docking lights (small circles at corners)
			var light_positions = [
				Vector2(-25, -25), Vector2(25, -25),
				Vector2(-25, 25), Vector2(25, 25)
			]
			for light_pos in light_positions:
				if pos.distance_to(center + light_pos) < 5:
					image.set_pixel(x, y, ACCENT_COLOR)

	return ImageTexture.create_from_image(image)
