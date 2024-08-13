extends CharacterBody3D

# References
@onready var mesh = $Mesh

# Export variables
@export var minSpeed := 10.0
@export var maxSpeed := 30.0
@export var turnSpeed := 1.05
@export var pitchSpeed := 0.5
@export var levelSpeed := 3.0
@export var throttleDelta := 30.0
@export var acceleration := 6.0

# Variables
var forwardSpeed := 0.0
var targetSpeed := 0.0
var turnInput := 0.0
var pitchInput := 0.0

func _process(delta):
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitchInput * pitchSpeed * delta)
	transform.basis = transform.basis.rotated(Vector3.UP, turnInput * turnSpeed * delta)
	mesh.rotation.z = lerp(mesh.rotation.z, turnInput, levelSpeed * delta)
	forwardSpeed = lerp(forwardSpeed, targetSpeed, acceleration * delta)
	velocity = -transform.basis.z * forwardSpeed
	move_and_slide()

func get_input(delta):
	if Input.is_action_pressed("ThrottleUp"):
		targetSpeed = min(forwardSpeed + throttleDelta * delta, maxSpeed)
	if Input.is_action_pressed("ThrottleDown"):
		targetSpeed = max(forwardSpeed - throttleDelta * delta, minSpeed)
	print(targetSpeed)
	turnInput = Input.get_axis("RollRight", "RollLeft") * targetSpeed / maxSpeed
	pitchInput = Input.get_axis("PitchUp", "PitchDown") * targetSpeed / maxSpeed
