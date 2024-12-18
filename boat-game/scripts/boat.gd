extends BuoyantObject

func _physics_process(delta) -> void:
	super._physics_process(delta)
	handle_controls()

func handle_controls():
	$CameraSpring.global_position = global_position
	
	if submerged:
		if Input.is_action_pressed("steer_right"):
			apply_torque(transform.basis.y * -8)
		
		if Input.is_action_pressed("steer_left"):
			apply_torque(transform.basis.y * 8)
		
		if Input.is_action_pressed("throttle"):
			apply_central_force(transform.basis.z * 30)
			
		if Input.is_action_pressed("brake"):
			apply_central_force(transform.basis.z * -10)
