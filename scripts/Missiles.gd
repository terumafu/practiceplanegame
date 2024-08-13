extends CharacterBody3D

# References
@onready var target = $"../3DWorld/player"

# Export variables
@export var maxSpeed := 1.0 # m/s
@export var acceleration := 0.3 # m/s
@export var slowDownPoint := 0.5 # m/s
@export var turnSpeed := 60 # deg/s

# Variables
var vel := Vector3.ZERO
var previousVel := Vector3.ZERO
var slowDown := 0.0
var speed := 0.0

func _process(delta):
	var currentRot = rotation
	look_at(target.global_transform.origin, Vector3.UP)
	lerp_3d_rotation(currentRot, rotation, turnSpeed * delta)
	
	speed += (acceleration * delta) * slowDown
	vel -= global_transform.origin.normalized() * speed * delta
	slowDown = clamp(maxSpeed - vel.distance_to(previousVel) / delta, 0, slowDownPoint) / slowDownPoint
	
	previousVel = vel
	position += vel

func lerp_3d_rotation(from, to, ratio):
	rotation.x = lerp_angle(from.x, to.x, ratio)
	rotation.y = lerp_angle(from.y, to.y, ratio)
	rotation.z = lerp_angle(from.z, to.z, ratio)
