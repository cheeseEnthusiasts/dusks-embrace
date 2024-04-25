extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 500

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facingLeft : bool = false

func _physics_process(delta):

	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")

	# Handles dashing
	dash(direction)

	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	if Input.is_action_just_pressed("ui_left")and !facingLeft: 
		$AnimatedSprite2D.flip_h = true
		facingLeft = true
	if Input.is_action_just_pressed("ui_right")and facingLeft: 
		$AnimatedSprite2D.flip_h = false
		facingLeft = false
		
	if not is_on_floor() and velocity.y >= 0:
		$AnimatedSprite2D.play("jump")
		$AnimatedSprite2D.set_frame_and_progress(1, 0.0)
	elif not is_on_floor() and velocity.y <= 0:
		$AnimatedSprite2D.play("jump")
		$AnimatedSprite2D.set_frame_and_progress(0, 0.0)


func dash(direction):
	if Input.is_action_just_pressed("player_dash"):
		
		velocity.x = direction * DASH_SPEED
