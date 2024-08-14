extends Node3D

# References
var ROCKET = load("res://scenes/Missiles.tscn")
@onready var missiles = $"../../Missiles"

# Export variables
@export var spawnRate := 3.0 # In seconds
@export var rateRandomness := 1.0 # In seconds
@export var posRandomness := 3.0 # In meters

# Variables
var timer := 0.0
@onready var wait := randf_range(spawnRate - rateRandomness, spawnRate + rateRandomness)

func _process(delta):
	timer += delta
	
	if timer > wait:
		timer = 0.0
		wait = randf_range(spawnRate - rateRandomness, spawnRate + rateRandomness)
		
		# Instantiate rocket
		var inst = ROCKET.instantiate()
		
		# Generate random pos that is not, for example, behind a wall (using a raycast)
		
		var collision = {a = 0}; var pos
		while not collision.is_empty():
			pos = randomVector3(posRandomness)
			var directState = get_world_3d().direct_space_state
			collision = directState.intersect_ray(PhysicsRayQueryParameters3D.create(position, pos))
		
		inst.position = global_position + pos
		missiles.add_child(inst)

func randomVector3(r):
	return Vector3(randf_range(-r, r), randf_range(-r, r), randf_range(-r, r))
