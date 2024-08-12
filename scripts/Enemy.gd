extends CharacterBody3D

@export var speed := 5 # m/s
@export var turnSpeed := 40 # deg/s

@onready var player = $"../Player"

func _ready():
	pass

func _process(delta):
	var rot = rotation_degrees
	look_at(player.global_transform.origin, Vector3.UP)
	var playerRot = rotation_degrees
	print((rot - playerRot) / 180)
	rotation_degrees = rot + ((rot - playerRot).normalized() * turnSpeed * delta)
	
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += Vector3(dir.x, 0, dir.y) * speed * delta
