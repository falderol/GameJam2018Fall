extends Area2D

var dead
var ammoCount
var noDodge
enum action {SHOOT_GREEN, SHOOT_RED, SHOOT_YELLOW, SHOOT_BLUE, DODGE, RELOAD, NONE}
var playerLocation = Vector2(96,480)
var rotationOffset
	
func get_dead():
	return dead
		
func set_dead(isDead):
	dead = isDead
	
func get_action():
	return action

func set_action(desiredAction):
	action = desiredAction

func increment_ammo():
	ammoCount +=1
	
func decrement_ammo():
	ammoCount -=1

func get_no_dodge():
	return noDodge

func set_no_dodge(dodged):
	noDodge = dodged
	
func get_ammo_count():
	return ammoCount

func _ready():
	dead = false
	ammoCount = 0
	noDodge = true
	action = 7
	rotationOffset = 3*PI/2

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
