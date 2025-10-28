extends CharacterBody3D

@export var speed : float = 1
var horizontalSpeeds = [0.7, 1.4]
var verticalSpeeds = [0.5,1]
var horizontalRotations = [15,30]
var verticalRotations = [15,30]

signal player_hit

func _ready() -> void:
	velocity = Vector3(horizontalSpeeds[0], verticalSpeeds[0], 0)

func _physics_process(_delta: float) -> void:
	velocity *= speed
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Left1")):
		velocity.x = -horizontalSpeeds[0]
		rotation_degrees.z = horizontalRotations[0]
	elif(event.is_action_pressed("Left2")):
		velocity.x = -horizontalSpeeds[1]
		rotation_degrees.z = horizontalRotations[1]
	elif(event.is_action_pressed("Right1")):
		velocity.x = horizontalSpeeds[0]
		rotation_degrees.z = -horizontalRotations[0]
	elif(event.is_action_pressed("Right2")):
		velocity.x = horizontalSpeeds[1]
		rotation_degrees.z = -horizontalRotations[1]
	elif(event.is_action_pressed("Up1")):
		velocity.y = verticalSpeeds[0]
		rotation_degrees.x = verticalRotations[0]
	elif(event.is_action_pressed("Up2")):
		velocity.y = verticalSpeeds[1]
		rotation_degrees.x = verticalRotations[1]
	elif(event.is_action_pressed("Down1")):
		velocity.y = -verticalSpeeds[0]
		rotation_degrees.x = -verticalRotations[0]
	elif(event.is_action_pressed("Down2")):
		velocity.y = -verticalSpeeds[1]
		rotation_degrees.x = -verticalRotations[1]

func hit_wall(body: Node3D)->void:
	if(body.name == "Plane"):
		player_hit.emit()

func connect_wall(wall : Area3D)->void:
	wall.connect("body_entered", hit_wall)
