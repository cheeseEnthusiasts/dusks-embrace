extends Area2D

var enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enabled:
		if Input.is_action_just_pressed("interact"):
			if global.gravityflip == true:
				global.gravityflip = false
			else:
				global.gravityflip = true
			$AnimatedSprite2D.play("flip")


func _on_body_entered(body):
	if body.has_method("player"):
			enabled = true


func _on_body_exited(body):
	if body.has_method("player"):
			enabled = false
