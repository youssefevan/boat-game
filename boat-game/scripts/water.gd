extends CSGMesh3D

# Based on this video: https://www.youtube.com/watch?v=_R2KDcAp1YQ&t=227s

var wave_speed : float
var wave_scale : float
var height_scale : float
var time : float
var normal : Vector3

func _ready():
	wave_speed = material.get_shader_parameter("wave_speed")
	wave_scale = material.get_shader_parameter("wave_scale")
	height_scale = material.get_shader_parameter("height_scale")

func _process(delta):
	global_position.x = $"../Boat".global_position.x
	global_position.z = $"../Boat".global_position.z
	
	time += delta
	material.set_shader_parameter("wave_time", time)

func get_height(world_position : Vector3) -> float:
	var x = world_position.x * wave_scale + (time * wave_speed)
	var z = world_position.z * wave_scale + (time * wave_speed)
	
	var y = (cos(x) * sin(z)) * height_scale
	
	return global_position.y + y
