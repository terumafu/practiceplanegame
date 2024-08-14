extends CharacterBody3D

# References
@onready var target = $"../../Player"

# Export variables
@export var maxSpeed := 10.0 # m/s
@export var acceleration := 0.3 # m/s
@export var slowDownPoint := 0.5 # m/s

# Variables
var vel := Vector3.ZERO
var previousVel := Vector3.ZERO
var slowDown := 0.0
var speed := 0.0

func _process(delta):
	var currentRot = rotation
	look_at(target.global_transform.origin, Vector3.UP)
	
	speed += (acceleration * delta) * slowDown
	velocity -= transform.basis.z * speed
	slowDown = clamp(maxSpeed - velocity.distance_to(previousVel) / delta, 0, slowDownPoint) / slowDownPoint
	
	previousVel = velocity
	move_and_slide()
