extends CharacterBody3D

const SPEED = 5.0
const JUMP_FORCE = 4.5

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	set_physics_process( get_multiplayer_authority() )
	set_process_input( get_multiplayer_authority() )

	$Camera3D.current = is_multiplayer_authority()
	$Camera3D/Direction.visible = !is_multiplayer_authority()

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == 2:
		rotation.y -= deg2rad(event.relative.x / 18)
		$Camera3D.rotation.x -= deg2rad(event.relative.y / 18)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg2rad(-90), deg2rad(90))

func _physics_process(delta):
	if not is_multiplayer_authority():
		return
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	# Add the gravity.
	if not is_on_floor():
		motion_velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		motion_velocity.y = JUMP_FORCE

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		motion_velocity.x = direction.x * SPEED
		motion_velocity.z = direction.z * SPEED
	else:
		motion_velocity.x = move_toward(motion_velocity.x, 0, SPEED)
		motion_velocity.z = move_toward(motion_velocity.z, 0, SPEED)

	move_and_slide()
	
	rpc( &"share_data", transform, $Camera3D.rotation.x )

@rpc
func share_data(player_transform, camera_rotation):
	transform = player_transform
	$Camera3D.rotation.x = camera_rotation
