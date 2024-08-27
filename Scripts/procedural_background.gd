extends Node2D


#var mesh_2d : MeshInstance2D
#@export var range = Vector2(0.4,0.2)
#@export var new_instance_count : int
var multi_mesh_instance_array = {}
@export var spawn_chances : PackedFloat32Array
@export var variance_multiplier : PackedFloat32Array
@export var ranges_array : PackedVector2Array
#@onready var multi_mesh_instance_2d = $MultiMeshInstance2D
var noise_texture : NoiseTexture2D

func _ready():
	for child in get_children().size():
		#print(child)
		if get_child(child) is MultiMeshInstance2D:
			multi_mesh_instance_array[child] = get_child(child)
	#print(multi_mesh_instance_array)
	if variance_multiplier.size() and ranges_array.size() != multi_mesh_instance_array.size():
		push_error("Some values are misisng for the multimesh instances - Please check Variance Multipliers and Ranges Array!")
	do_distribution()

func do_distribution():
	await create_new_noise()
	for multi_mesh in multi_mesh_instance_array:
		#print(multi_mesh)
		var new_multi_mesh = multi_mesh_instance_array[multi_mesh].multimesh
		#print(new_multi_mesh)
		#print(multi_mesh_instance_array[multi_mesh].get_child(0).mesh)
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
	print("new noise done")
#

func generate_new_terrain(multi_mesh, range, variance, chance):
	var new_image = noise_texture.get_image()
	if new_image != null:
		var instance_index = 0
		for y in range(new_image.get_height()):
			for x in range(new_image.get_width()):
				var color = new_image.get_pixelv(Vector2(x, y)).r  # Get the grayscale value
				if instance_index < multi_mesh.instance_count:
					if color > range.x and color < range.y:
						if randf_range(0.0, 100.0) <= chance:
							var new_position = Vector2(x*100+randf_range(-variance,variance), y*100+randf_range(-variance,variance))
							#var new_transform = Vector2(0.0,new_position)
							multi_mesh.set_instance_transform_2d(instance_index, Transform2D(randf_range(-0.2,0.2), new_position))
							#print("placed: ", multi_mesh.get_instance_transform_2d(instance_index))
							instance_index += 1
				if instance_index >= multi_mesh.instance_count:
					break
			if instance_index >= multi_mesh.instance_count:
				break
	else:
		print("null image ", new_image)
