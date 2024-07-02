extends CharacterBody2D

var SPEED = 500
var JUMP_VELOCITY = -700

var can_jump : bool
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facingLeft : bool = false
var sprinting : bool = false
var lantern : bool = false
var pathX : float
var pathY : float
var objectiveX : float
var objectiveY : float
var math : float
var respawnX : float = 0
var respawnY : float = 0
var checkup : float 

func ready():
	global.checkpointNum = 0
	checkup = global.checkpointXPOS
	
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

	#checkpoints
	locate()
	objective()
	
	#kill
	kill()
	
	#sprinting stuff
	dash(direction)

	if lantern and !sprinting:
		SPEED = 400
		JUMP_VELOCITY = -500
	elif !lantern and !sprinting:
		SPEED = 500
		JUMP_VELOCITY = -600

	if sprinting:
		SPEED = 750

	#lantern holding
	if lantern:
		$lantern.visible = true
	else: 
		$lantern.visible = false

#	if Input.is_action_just_pressed("lantern-toggle") and lantern and !sprinting:
#		lantern = false
#	elif Input.is_action_just_pressed("lantern-toggle") and !lantern and !sprinting:
#		lantern = true

#sprinmt
func dash(_direction):
	if Input.is_action_just_pressed("player_dash") and !lantern:
		sprinting = true
	if Input.is_action_just_released("player_dash"):
		sprinting = false

#kill
func kill():
	if position.y >= 1000:
		respawnX = global.checkpointXPOS[global.checkpointNum]
		respawnY = global.checkpointYPOS[global.checkpointNum]
		position.x = respawnX
		position.y = respawnY
	if global.spike_touch:
		respawnX = global.checkpointXPOS[global.checkpointNum]
		respawnY = global.checkpointYPOS[global.checkpointNum]
		position.x = respawnX
		position.y = respawnY
func coyote_time():
	await get_tree().create_timer(0.25).timeout
	if velocity.y < 0:
		can_jump = false

#checkpoints
func locate():
	pathX = position.x - global.checkpointXPOS[global.checkpointNum+1]
	pathY = position.y - global.checkpointYPOS[global.checkpointNum+1]
	math = (pathX*pathX) + (pathY * pathY)
	math = sqrt(math)
func objective():
	#print("Distance to next objective: ",math,"          ","Checkpoint: ",global.checkpointNum)
	#print("x",position.x)
	#print("y",position.y)
	#print("cx",global.checkpointXPOS[global.checkpointNum+1])
	#print("cy",global.checkpointYPOS[global.checkpointNum+1])
	#print("RX",respawnX,"    ","RY",respawnY)
	# replaced with in-game menu, toggle it with grave [`]

	if math<50 and global.checkpointXPOS[global.checkpointNum] == checkup:
		global.checkpointNum += 1
