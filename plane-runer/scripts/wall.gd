extends Area3D

var speed = 0.0

func _ready() -> void:
	get_tree().get_root().get_node("main").find_child("Plane").connect_wall(self)
	speed = get_tree().get_root().get_node("main").globalSpeed

func _physics_process(delta: float) -> void:
	position += Vector3(0,0,speed * delta)
