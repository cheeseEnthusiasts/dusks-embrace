extends CanvasLayer

@onready var player = get_parent().get_parent().get_node("player")
#this was a pain to get working but it finds the parent of the debug node, then finds the parent of the hud node, then it gets the player

var playerX: float
var playerY: float
var checkpointX: float
var checkpointY: float
var distanceToObjective: float
var checkpoint: int
var respawnX: float
var respawnY: float

var toggled = false

func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("debug"):
		if not toggled:
			toggled = true
			visible = true
		else:
			toggled = false
			visible = false

	if toggled:
		update()
		$xpos.text = "x: " + str(playerX)
		$ypos.text = "y: " + str(playerY)
		$cxpos.text = "checkpoint x: " + str(checkpointX)
		$cypos.text = "checkpoint y: " + str(checkpointY)
		$distanceToObj.text = "Distance to Objective: " + str(distanceToObjective)
		$checkpoint.text = "checkpoint: " + str(checkpoint)
		$respawnXpos.text = "respawn x: " + str(respawnX)
		$respawnYpos.text = "respawn y: " + str(respawnY)


func update(): #updates all the variables
	playerX = player.position.x
	playerY = player.position.y
	checkpointX = global.checkpointXPOS[global.checkpointNum+1]
	checkpointY = global.checkpointYPOS[global.checkpointNum+1]
	distanceToObjective = player.math
	checkpoint = global.checkpointNum
	respawnX = player.respawnX
	respawnY = player.respawnY
