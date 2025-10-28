extends Area3D

@export var speed = 5.0

func _ready() -> void:
	%Plane.connect_wall(self)

func _physics_process(delta: float) -> void:
	position += Vector3(0,0,speed * delta)
