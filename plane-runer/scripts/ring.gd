extends Area3D


@export var high_value = false

func _ready() -> void:
	if high_value:
		get_tree().get_root().get_node("main").find_child("Plane").connect_ring_high(self)
	else:
		get_tree().get_root().get_node("main").find_child("Plane").connect_ring_low(self)
