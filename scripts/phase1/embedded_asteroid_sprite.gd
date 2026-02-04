extends Sprite2D
# Phase 1: Procedurally generated asteroid sprite
# Creates a simple rocky circle texture at runtime

const ASTEROID_SIZE := 64
const ASTEROID_COLOR := Color(0.45, 0.35, 0.3)  # Brownish gray

func _ready():
	texture = _create_asteroid_texture()

func _create_asteroid_texture() -> ImageTexture:
	var image = Image.create(ASTEROID_SIZE, ASTEROID_SIZE, false, Image.FORMAT_RGBA8)
	var center = Vector2(ASTEROID_SIZE / 2.0, ASTEROID_SIZE / 2.0)
	var radius = ASTEROID_SIZE / 2.0 - 2

	# Fill with transparent
	image.fill(Color(0, 0, 0, 0))

	# Draw a rough circle with some variation for rocky look
	for x in range(ASTEROID_SIZE):
		for y in range(ASTEROID_SIZE):
			var pos = Vector2(x, y)
			var dist = pos.distance_to(center)

			# Add some noise to the radius for rocky edges
			var angle = (pos - center).angle()
			var noise_offset = sin(angle * 5) * 3 + cos(angle * 7) * 2

			if dist < radius + noise_offset:
				# Vary color slightly based on position for texture
				var color_variation = (sin(x * 0.5) * cos(y * 0.5)) * 0.1
				var pixel_color = ASTEROID_COLOR
				pixel_color.r += color_variation
				pixel_color.g += color_variation * 0.8
				pixel_color.b += color_variation * 0.6

				# Darken edges slightly
				var edge_factor = dist / radius
				pixel_color = pixel_color.darkened(edge_factor * 0.3)

				image.set_pixel(x, y, pixel_color)

	return ImageTexture.create_from_image(image)
