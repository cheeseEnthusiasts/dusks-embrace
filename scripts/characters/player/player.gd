extends CharacterBody2D

@export var inv = Inventory

var SPEED = 500
var JUMP_VELOCITY = -500
const DASH_SPEED = 750

var can_jump : bool
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facingLeft : bool = false
var sprinting : bool = false
var lantern : bool = false




func _physics_process(delta):
	if !is_on_floor():
		coyote_time()

	#gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	#jumping
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		velocity.y = JUMP_VELOCITY
	#checking if can jump
	if is_on_floor():
		can_jump = true
	#basic movement
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
		$lantern.move_local_x(-25)
		$lantern/PointLight2D.scale.x = $lantern/PointLight2D.scale.x * -1
		$lantern/PointLight2D.move_local_x(-202)
		facingLeft = true
	if Input.is_action_just_pressed("ui_right")and facingLeft: 
		$AnimatedSprite2D.flip_h = false
		$lantern.move_local_x(25)
		$lantern/PointLight2D.move_local_x(202)
		$lantern/PointLight2D.scale.x = $lantern/PointLight2D.scale.x * -1
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
		SPEED = 750
	elif !sprinting:
		SPEED = 500
		
		
	#lantern holding
	if lantern:
		$lantern.visible = true
	
	else: 
		$lantern.visible = false
		
	if Input.is_action_just_pressed("lantern-toggle") and lantern and !sprinting:
		lantern = false
	elif Input.is_action_just_pressed("lantern-toggle") and !lantern and !sprinting:
		lantern = true

	if lantern and !sprinting:
		SPEED = 500.0
		JUMP_VELOCITY = -250
	elif !lantern and !sprinting:
		SPEED = 750.0
		JUMP_VELOCITY = -500


#sprinmt
func dash(_direction):
	if Input.is_action_just_pressed("player_dash") and !lantern:
		sprinting = true
	if Input.is_action_just_released("player_dash"):
		sprinting = false

#kill
func kill():
	if position.y >= 1000:
		position.x = 0
		position.y = 0

func coyote_time():
	await get_tree().create_timer(0.25).timeout
	if velocity.y < 0:
		can_jump = false


