extends SpringArm3D

@export var sensitivity := 0.1

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	top_level = true
	
	rotation_degrees.x = -30.0

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90, 30)
		
		rotation_degrees.y -= event.relative.x * sensitivity
	
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
