extends Camera3D

@export var shakeTime = 50
var shakeTimer = 0
@export var shakeIntensity = 0.1

func _physics_process(_delta: float) -> void:
	shakeTimer -= 1
	if shakeTimer >= 0:
		@warning_ignore("integer_division")
		position.y = (shakeTimer % (shakeTime / 7)) * shakeIntensity 

func camera_shake()->void:
	shakeTimer = shakeTime
