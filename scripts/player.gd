extends Node2D


var speed : int = 100
var jumpheight : int = 100


func _ready(): 
	pass


func _process(_delta):
	movement()

func movement():
	var _velocity : Vector2 = get_velocity()
	var direction : Vector2 = Vector2.ZERO


	#if Input.is_action_just_pressed("ui_up"):
	
	if Input.is_action_just_pressed("ui_left"):	
		direction.x -= 1
	if Input.is_action_just_pressed("ui_right"):		
		direction.x -= 1
	
	move_and_slide()	
	set_velocity(_velocity)
