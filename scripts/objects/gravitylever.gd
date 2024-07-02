extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("interact"):
		if global.gravityflip == true:
			global.gravityflip = false
		else:
			global.gravityflip = true
		$AnimatedSprite2D.play("flip")

