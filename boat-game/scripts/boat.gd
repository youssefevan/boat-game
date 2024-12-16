extends RigidBody3D

@export var buoyancy := 1.0
@export var gravity := 10.0

@export var drag := 0.05
@export var angular_drag := 0.05

var water_height := 0.0

var submerged := false

func _physics_process(delta) -> void:
	handle_controls()
	
	for point in $BuoyancyPoints.get_children():
		apply_buoyancy(delta, point.global_position)

# Based on this video: https://www.youtube.com/watch?v=_R2KDcAp1YQ&t=227s
func apply_buoyancy(delta, pos) -> void:
	var depth = $"../Water".get_height(pos) - pos.y + 0.75
	if depth > 0:
		submerged = true
		apply_force(Vector3.UP * buoyancy * gravity * depth, pos - global_position)
	else:
		submerged = false

# based on this video: https://www.youtube.com/watch?v=_R2KDcAp1YQ&t=227s
func _integrate_forces(state) -> void:
	if submerged:
		state.linear_velocity *= 1 - drag
		state.angular_velocity *= 1 - angular_drag

func handle_controls():
	$CameraSpring.global_position = global_position
	
	if Input.is_action_pressed("steer_right"):
		apply_torque(transform.basis.y * -2)
	
	if Input.is_action_pressed("steer_left"):
		apply_torque(transform.basis.y * 2)
	
	if Input.is_action_pressed("throttle"):
		apply_central_force(transform.basis.z * -10)
