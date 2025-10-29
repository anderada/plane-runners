extends Camera3D

@export var shakeTime = 0.5
var shakeTimer = 0.0
@export var shakeIntensity = 0.5

func _physics_process(_delta: float) -> void:
	shakeTimer -= _delta
	if shakeTimer >= 0:
		@warning_ignore("integer_division")
		position.y = sin(shakeTimer * 50) * shakeIntensity 

func camera_shake()->void:
	shakeTimer = shakeTime
