extends Node2D

var multi_mesh_instance_array = {}
@export var spawn_chances : PackedFloat32Array
@export var variance_multiplier : PackedFloat32Array
@export var ranges_array : PackedVector2Array
var noise_texture : NoiseTexture2D

func _ready():
	for child in get_children().size():
		if get_child(child) is MultiMeshInstance2D:
			multi_mesh_instance_array[child] = get_child(child)
	if variance_multiplier.size() and ranges_array.size() != multi_mesh_instance_array.size():
		push_error("Some values are misisng for the multimesh instances - Please check Variance Multipliers and Ranges Array!")
	do_distribution()

func do_distribution():
	await create_new_noise()
	for multi_mesh in multi_mesh_instance_array:
		var new_multi_mesh = multi_mesh_instance_array[multi_mesh].multimesh
		new_multi_mesh.mesh = multi_mesh_instance_array[multi_mesh].get_child(0).mesh
		generate_new_terrain(new_multi_mesh, ranges_array[multi_mesh], variance_multiplier[multi_mesh], spawn_chances[multi_mesh])


func create_new_noise():
	noise_texture = NoiseTexture2D.new()
	noise_texture.noise = FastNoiseLite.new()
	noise_texture.noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise_texture.noise.seed = randi()
	noise_texture.width = 512 # Set the width
	noise_texture.height = 512  # Set the height
	noise_texture.generate_mipmaps = true
	await get_tree().process_frame

func generate_new_terrain(multi_mesh, total_range, variance, chance):
	var new_image = noise_texture.get_image()
	if new_image != null:
		var candidates = []
		for y in range(new_image.get_height()):
			for x in range(new_image.get_width()):
				var color = new_image.get_pixelv(Vector2(x, y)).r  # Get the grayscale value
				if color > total_range.x and color < total_range.y:
					if randf_range(0.0, 100.0) <= chance:
						candidates.append(Vector2(x, y))
		
		candidates.shuffle()
		
		var instance_index = 0
		for pos in candidates:
			if instance_index >= multi_mesh.instance_count:
				break
			
			var new_position = Vector2(pos.x * 100 + randf_range(-variance, variance), pos.y * 100 + randf_range(-variance, variance))
			multi_mesh.set_instance_transform_2d(instance_index, Transform2D(randf_range(-0.2, 0.2), new_position))
			instance_index += 1
		
		multi_mesh.visible_instance_count = instance_index
	else:
		print("null image ", new_image)
