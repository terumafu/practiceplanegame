extends CharacterBody3D

# References
@onready var mesh = $Mesh
@onready var cam = $Camera3D

# Export variables
@export var minSpeed := 10.0
@export var maxSpeed := 30.0
@export var turnSpeed := 1.05
@export var pitchSpeed := 1.05
@export var levelSpeed := 3.0
@export var throttleDelta := 30.0
@export var acceleration := 6.0
@export var weight := 1.0

# Variables
var forwardSpeed := 0.0
var targetSpeed := 0.0
var turnInput := 0.0
var pitchInput := 0.0
var Yvel := 0.0

var camZoom := 1.0

func _process(delta):
	get_input(delta)
	# Physical rotation
	transform.basis = transform.basis.rotated(transform.basis.x, pitchInput * pitchSpeed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turnInput * turnSpeed * delta)
	
	# Visual rotation
	mesh.rotation.z = lerp(mesh.rotation.z, turnInput, levelSpeed * delta)
	
	# Move plane
	forwardSpeed = lerp(forwardSpeed, targetSpeed, acceleration * delta)
	velocity = -transform.basis.z * forwardSpeed
	
	# Apply gravity
	Yvel -= 9.81 * weight
	Yvel *= ((maxSpeed - forwardSpeed) / maxSpeed) # Gravity has less influence the closer to max speed you fly
	if is_on_floor():
		Yvel = 0.0
	velocity.y += Yvel
	
	move_and_slide() # Apply movement
	
	handle_cam(delta)

func get_input(delta):
	if Input.is_action_pressed("SpeedUp"):
		targetSpeed = min(forwardSpeed + throttleDelta * delta, maxSpeed)
	else:
		targetSpeed = lerp(targetSpeed, 0.0, delta / acceleration)
	
	turnInput = Input.get_axis("RollRight", "RollLeft") * targetSpeed / maxSpeed
	pitchInput = Input.get_axis("PitchUp", "PitchDown") * targetSpeed / maxSpeed

func handle_cam(delta):
	if Input.is_action_just_pressed("ZoomIn"):
		camZoom -= 1.0
	if Input.is_action_just_pressed("ZoomOut"):
		camZoom += 1.0
	camZoom = clamp(camZoom, 1.0, 10.0)
	cam.position.y = lerp(cam.position.y, camZoom * 3.0, delta)
	cam.position.z = lerp(cam.position.z, camZoom * 5.0, delta)
	cam.fov = 90 + ((((maxSpeed - forwardSpeed) / maxSpeed * -1) + 1) * 20)
