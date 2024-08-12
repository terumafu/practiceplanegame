extends CharacterBody3D


const SPEED = 5.0


func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
	#print(global_rotation)
	#velocity = global_rotation_degrees * SPEED
	#velocity.z = -1.0 * SPEED
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var updown = Input.get_axis("s","w");
	var leftright = Input.get_axis("d","a");
	#otation_degrees.x = -89;
	#print(rotation_degrees)
	#print(transform.basis)
	transform.basis = global_transform.basis.rotated(transform.basis.x, updown * 0.05)
	velocity = -transform.basis.z * SPEED;
	transform.basis = transform.basis.rotated(transform.basis.y,leftright * 0.05)
	"""
	if updown:
		
		rotate_x(updown/10.0)
		
	if leftright:
		var temp = leftright/10.0
		if rotation_degrees.x > 0 && rotation_degrees.y < 180:
			
			pass
		print(leftright)
		rotate_y(leftright/10.0)
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	"""
	
	

	move_and_slide()
