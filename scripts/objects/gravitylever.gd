extends Area2D

var enabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	flip()
			
			
func toggle_me():
	$AnimatedSprite2D.play("flip")

func _on_body_entered(body):
	if body.has_method("player"):
		print("player here")
		enabled = true


func _on_body_exited(body):
	if body.has_method("player"):
		enabled = false


#func _input_event(viewport, event, shape_idx):
#	if event.input_event(Input.is_action_just_pressed("interact")):
#		if enabled:
#			print("Inverting gravity")
#			global.toggle_gravity()
		
func flip():
	if Input.is_action_just_pressed("interact"):
		if enabled:
			print("Inverting gravity2")
			global.toggle_gravity()
			toggle_me()


