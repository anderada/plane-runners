extends RigidBody3D

var velocity : Vector3
@export var speed : float = 1
var horizontalSpeeds = [0.7, 1.4]
var verticalSpeeds = [0.5,1]

func _ready() -> void:
	velocity = Vector3(horizontalSpeeds[0], verticalSpeeds[0], 0)

func _physics_process(delta: float) -> void:
	linear_velocity = velocity * speed
	
	
func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("Left1")):
		velocity.x = -horizontalSpeeds[0]
	elif(event.is_action_pressed("Left2")):
		velocity.x = -horizontalSpeeds[1]
	elif(event.is_action_pressed("Right1")):
		velocity.x = horizontalSpeeds[0]
	elif(event.is_action_pressed("Right2")):
		velocity.x = horizontalSpeeds[1]
	elif(event.is_action_pressed("Up1")):
		velocity.y = verticalSpeeds[0]
	elif(event.is_action_pressed("Up2")):
		velocity.y = verticalSpeeds[1]
	elif(event.is_action_pressed("Down1")):
		velocity.y = -verticalSpeeds[0]
	elif(event.is_action_pressed("Down2")):
		velocity.y = -verticalSpeeds[1]
