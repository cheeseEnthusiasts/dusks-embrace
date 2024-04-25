extends CharacterBody2D


var SPEED = 150.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 500


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facingLeft : bool = false
var sprinting : bool = false

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")


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
	
	#kill
	kill()
	#sprinting stuff
	dash(direction)
	if sprinting:
		SPEED = 300
	elif !sprinting:
		SPEED = 150
	

#sprinmt
func dash(direction):
	if Input.is_action_just_pressed("player_dash"):
		sprinting = true
	if Input.is_action_just_released("player_dash"):
		sprinting = false

#kill
func kill():
	if position.y >= 1000:
		position.x = 0
		position.y = 0

