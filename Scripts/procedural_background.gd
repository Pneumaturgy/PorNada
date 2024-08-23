extends Node2D
	
@onready var sprite_2d = $ParallaxBackground/GroundLayer/Sprite2D
const TRIANGLE = preload("res://Assets/2D/Sprites/Triangle.png")
var noise_texture : NoiseTexture2D

@onready var back_layer = $ParallaxBackground/BackLayer
@onready var ground_layer = $ParallaxBackground/GroundLayer
@onready var bush_layer = $ParallaxBackground/BushLayer
@onready var tree_layer = $ParallaxBackground/TreeLayer


func _ready():
	await create_new_noise()
	generate_new_terrain()


func generate_new_terrain():
	var new_image = noise_texture.get_image()
	if new_image != null:
		for y in range(new_image.get_height()):
			for x in range(new_image.get_width()):
				var color = new_image.get_pixelv(Vector2(x, y)).r  # Get the grayscale value
				if color < 0.1:
					spawn_sprite(ground_layer, Vector2(x, y))
				elif color < 0.2:
					spawn_sprite(bush_layer, Vector2(x, y))
				elif color < 0.3:
					spawn_sprite(tree_layer, Vector2(x, y))
	else:
		print("null image ", new_image)

func create_new_noise():
	noise_texture = NoiseTexture2D.new()
	noise_texture.noise = FastNoiseLite.new()
	noise_texture.noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise_texture.width = 512  # Set the width
	noise_texture.height = 512  # Set the height
	noise_texture.generate_mipmaps = true
	await get_tree().process_frame

func spawn_sprite(layer, position: Vector2):
	var sprite_instance = Sprite2D.new()
	sprite_instance.texture = TRIANGLE
	sprite_instance.scale = Vector2(0.05, 0.05)  # Set scale as a Vector2
	sprite_instance.position = position
	layer.add_child(sprite_instance)  # Add the sprite to the correct layer
