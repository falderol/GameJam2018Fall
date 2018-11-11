#Animation.finished for all need to return to idle or dead depending on players isDead state
extends Node

var deadPlayers
var randAction
var active
var greenStatus
var redStatus
var yellowStatus
var blueStatus
var countdown

func _ready():
	$GameOver/Text.hide()
	$Countdown/Countdown.hide()
	deadPlayers = 0
	greenStatus = true
	redStatus = true
	yellowStatus = true
	blueStatus = true
	Input.connect("joy_connection_changed",self,"joy_con_changed")
	randomize()
	$SplashScreen/StartScreen.show()
	countdown = 3
	$Round.stop()


func round_initialize():
	$Countdown/Countdown.hide()
	$SplashScreen/StartScreen.hide()
	$greenPlayer.set_dead(false)
	$greenPlayer.ammoCount = 0
	greenStatus = true
	$redPlayer.set_dead(false)
	$redPlayer.ammoCount = 0
	redStatus = true
	$yellowPlayer.set_dead(false)
	$yellowPlayer.ammoCount = 0
	yellowStatus = true
	$bluePlayer.set_dead(false)
	$bluePlayer.ammoCount = 0
	blueStatus = true
	$Round.start()

func countdown_initialize():
	active = true
	$GameOver/Timer.stop()
	$Countdown/Countdown.text = str(countdown)
	$GameOver/Text.hide()
	$SplashScreen/StartScreen.hide()
	$Countdown/Countdown.show()
	$Countdown/LongTick.start()
	$Countdown/ShortTick.start()
	$BackgroundMusic.play()

func _process(delta):
	if Input.is_joy_known(0):
		if Input.is_joy_button_pressed(0,JOY_L2):
			set_action_dodge($greenPlayer)
		elif Input.is_joy_button_pressed(0,JOY_R2):
			set_action_reload($greenPlayer)
		elif Input.is_joy_button_pressed(0,JOY_XBOX_A):
			set_action_shoot_green($greenPlayer)
			if !active:
				countdown_initialize()
		elif Input.is_joy_button_pressed(0,JOY_XBOX_B):
			set_action_shoot_red($greenPlayer)
		elif Input.is_joy_button_pressed(0,JOY_XBOX_Y):
			set_action_shoot_yellow($greenPlayer)
		elif Input.is_joy_button_pressed(0,JOY_XBOX_X):
			set_action_shoot_blue($greenPlayer)
	if Input.is_joy_known(1):
		if Input.is_joy_button_pressed(1,JOY_L2):
			set_action_dodge($redPlayer)
		elif Input.is_joy_button_pressed(1,JOY_R2):
			set_action_reload($redPlayer)
		elif Input.is_joy_button_pressed(1,JOY_XBOX_A):
			set_action_shoot_green($redPlayer)
			if !active:
				countdown_initialize()
		elif Input.is_joy_button_pressed(1,JOY_XBOX_B):
			set_action_shoot_red($redPlayer)
		elif Input.is_joy_button_pressed(1,JOY_XBOX_Y):
			set_action_shoot_yellow($redPlayer)
		elif Input.is_joy_button_pressed(1,JOY_XBOX_X):
			set_action_shoot_blue($redPlayer)
	else:
		randAction = randi() % 7 +1
		if randAction == 2:
			$redPlayer.set_action(5)
		else:
			if randAction == 1 && $greenPlayer.get_dead():
				$redPlayer.set_action(6)
			elif randAction == 3 && $yellowPlayer.get_dead():
				$redPlayer.set_action(6)
			elif randAction == 4 && $bluePlayer.get_dead():
				$redPlayer.set_action(6)
			else:
				$redPlayer.set_action(randAction)
			
	if Input.is_joy_known(2):
		if Input.is_joy_button_pressed(2,JOY_L2):
			set_action_dodge($yellowPlayer)
		elif Input.is_joy_button_pressed(2,JOY_R2):
			set_action_reload($yellowPlayer)
		elif Input.is_joy_button_pressed(2,JOY_XBOX_A):
			set_action_shoot_green($yellowPlayer)
			if !active:
				countdown_initialize()
		elif Input.is_joy_button_pressed(2,JOY_XBOX_B):
			set_action_shoot_red($yellowPlayer)
		elif Input.is_joy_button_pressed(2,JOY_XBOX_Y):
			set_action_shoot_yellow($yellowPlayer)
		elif Input.is_joy_button_pressed(2,JOY_XBOX_X):
			set_action_shoot_blue($yellowPlayer)
	else:
		randAction = randi() % 7 +1
		if randAction == 3:
			$yellowPlayer.set_action(5)
		else:
			if randAction == 1 && $greenPlayer.get_dead():
				$yellowPlayer.set_action(6)
			elif randAction == 2 && $redPlayer.get_dead():
				$yellowPlayer.set_action(6)
			elif randAction == 4 && $bluePlayer.get_dead():
				$yellowPlayer.set_action(6)
			else:
				$yellowPlayer.set_action(randAction)
		
	if Input.is_joy_known(3):
		active = true
		if Input.is_joy_button_pressed(3,JOY_L2):
			set_action_dodge($bluePlayer)
		elif Input.is_joy_button_pressed(3,JOY_R2):
			set_action_reload($bluePlayer)
		elif Input.is_joy_button_pressed(3,JOY_XBOX_A):
			set_action_shoot_green($bluePlayer)
			if !active:
				countdown_initialize()
		elif Input.is_joy_button_pressed(3,JOY_XBOX_B):
			set_action_shoot_red($bluePlayer)
		elif Input.is_joy_button_pressed(3,JOY_XBOX_Y):
			set_action_shoot_yellow($bluePlayer)
		elif Input.is_joy_button_pressed(3,JOY_XBOX_X):
			set_action_shoot_blue($bluePlayer)
	else:
		randAction = randi() % 7 +1
		if randAction == 4:
			$bluePlayer.set_action(5)
		else:
			if randAction == 1 && $greenPlayer.get_dead():
				$bluePlayer.set_action(6)
			elif randAction == 2 && $redPlayer.get_dead():
				$bluePlayer.set_action(6)
			elif randAction == 3 && $yellowPlayer.get_dead():
				$bluePlayer.set_action(6)
			else:
				$bluePlayer.set_action(randAction)
		
	if active:
		$SplashScreen/StartScreen.hide()

func set_action_none(player):
	player.set_action(7)
	
func set_action_reload(player):
	player.set_action(6)
	
func set_action_dodge(player):
	player.set_action(5)
	
func set_action_shoot_green(player):
	#if player != $greenPlayer:
		player.set_action(1)
	#else:
		#player.set_action(7)

func set_action_shoot_red(player):
	#if player != $redPlayer:
		player.set_action(2)
	#else:
		#player.set_action(7)
		
func set_action_shoot_yellow(player):
	#if player != $yellowPlayer:
		player.set_action(3)
	#else:
		#player.set_action(7)
		
func set_action_shoot_blue(player):
	#if player != $bluePlayer:
		player.set_action(4)
	#else:
		#player.set_action(7)

func dodge_check():
	if $greenPlayer.get_action() == 5:#$greenPlayer.action.DODGE:
		$greenPlayer/greenAnimations.animation = "dodge"
		$greenPlayer.set_no_dodge(false)
	
	if $redPlayer.get_action() == 5:#$redPlayer.action.DODGE:
		$redPlayer/redAnimations.animation = "dodge"
		$redPlayer.set_no_dodge(false)
		
	if $yellowPlayer.get_action() == 5:#$yellowPlayer.action.DODGE:
		$yellowPlayer/yellowAnimations.animation = "dodge"
		$yellowPlayer.set_no_dodge(false)
		
	if $bluePlayer.get_action() == 5:#$bluePlayer.action.DODGE:
		$bluePlayer/blueAnimations.animation = "dodge"
		$bluePlayer.set_no_dodge(false)
		
		
func dodge_reset():
	$greenPlayer.set_no_dodge(true)
	$redPlayer.set_no_dodge(true)
	$yellowPlayer.set_no_dodge(true)
	$bluePlayer.set_no_dodge(true)


func action_reset():
	set_action_none($greenPlayer)
	set_action_none($redPlayer)
	set_action_none($yellowPlayer)
	set_action_none($bluePlayer)


func process_player_actions(currentPlayer, currentAnimation):
	match currentPlayer.get_action():
		1:#currentPlayer.action.SHOOT_GREEN:
			currentPlayer.look_at($greenPlayer.playerLocation)
			currentPlayer.rotate(currentPlayer.rotationOffset)
			if currentPlayer.get_ammo_count() > 0:
				currentAnimation.animation = "shoot"
				currentPlayer.decrement_ammo()
				if $greenPlayer.get_no_dodge() && !$greenPlayer.get_dead():
					$greenPlayer.set_dead(true)
			else:
				currentAnimation.animation = "shootEmpty"
		2:#currentPlayer.action.SHOOT_RED:
			currentPlayer.look_at($redPlayer.playerLocation)
			currentPlayer.rotate(currentPlayer.rotationOffset)
			if currentPlayer.get_ammo_count() > 0:
				currentAnimation.animation = "shoot"
				currentPlayer.decrement_ammo()
				if $redPlayer.get_no_dodge() && !$redPlayer.get_dead():
					# Shot Animation
					$redPlayer.set_dead(true)
			else:
				currentAnimation.animation = "shootEmpty"
		3:#currentPlayer.action.SHOOT_YELLOW:
			currentPlayer.look_at($yellowPlayer.playerLocation)
			currentPlayer.rotate(currentPlayer.rotationOffset)
			if currentPlayer.get_ammo_count() > 0:
				currentAnimation.animation = "shoot"
				currentPlayer.decrement_ammo()
				if $yellowPlayer.get_no_dodge() && !$yellowPlayer.get_dead():
					# Shot Animation
					$yellowPlayer.set_dead(true)
			else:
				currentAnimation.animation = "shootEmpty"
		4:#currentPlayer.action.SHOOT_BLUE:
			currentPlayer.look_at($bluePlayer.playerLocation)
			currentPlayer.rotate(currentPlayer.rotationOffset)
			if currentPlayer.get_ammo_count() > 0:
				currentAnimation.animation = "shoot"
				currentPlayer.decrement_ammo()
				if $bluePlayer.get_no_dodge() && !$bluePlayer.get_dead():
					# Shot Animation
					$bluePlayer.set_dead(true)
			else:
				currentAnimation.animation = "shootEmpty"
		6:#currentPlayer.action.RELOAD:
			currentAnimation.animation = "reload"
			currentPlayer.increment_ammo()
		_:
			pass

func check_shot():
	if $greenPlayer.get_dead() && (greenStatus == true):
		greenStatus = false;
		$greenPlayer/greenAnimations.animation = "shot"
	if $redPlayer.get_dead() && (redStatus == true):
		redStatus = false;
		$redPlayer/redAnimations.animation = "shot"
	if $yellowPlayer.get_dead() && (yellowStatus == true):
		yellowStatus = false;
		$yellowPlayer/yellowAnimations.animation = "shot"
	if $bluePlayer.get_dead() && (blueStatus == true):
		blueStatus = false;
		$bluePlayer/blueAnimations.animation = "shot"

func check_deaths():
	deadPlayers = 0
	if $greenPlayer.get_dead():
		deadPlayers +=1
		set_action_none($greenPlayer)
		
	if $redPlayer.get_dead():
		deadPlayers +=1
		set_action_none($redPlayer)
		
	if $yellowPlayer.get_dead():
		deadPlayers +=1
		set_action_none($yellowPlayer)
		
	if $bluePlayer.get_dead():
		deadPlayers +=1
		set_action_none($bluePlayer)

	if deadPlayers == 3:
		game_over()
	elif deadPlayers > 3:
		game_over()

func game_over():
	active = false
	if greenStatus:
		$Win.play()
		$GameOver/Text.text = str("Green George Survives")
	elif redStatus:
		$Win.play()
		$GameOver/Text.text = str("Pink Phil Survives")
	elif yellowStatus:
		$Win.play()
		$GameOver/Text.text = str("Orange Oscar Survives")
	elif blueStatus:
		$Win.play()
		$GameOver/Text.text = str("Silver Sam Survives")
	else:
		$Draw.play()
		$GameOver/Text.text = str("No Survivors")
	$GameOver/Text.show()
	$GameOver/Timer.start()
	$BackgroundMusic.stop()
	$Round.stop()
	

func _on_Round_timeout():
	check_deaths()
	dodge_check()
	process_player_actions($greenPlayer, $greenPlayer/greenAnimations)
	process_player_actions($redPlayer, $redPlayer/redAnimations)
	process_player_actions($yellowPlayer, $yellowPlayer/yellowAnimations)
	process_player_actions($bluePlayer, $bluePlayer/blueAnimations)
	check_shot()
	dodge_reset()
	action_reset()
	$greenPlayer/greenAnimations.play()
	$redPlayer/redAnimations.play()
	$yellowPlayer/yellowAnimations.play()
	$bluePlayer/blueAnimations.play()


func _on_greenAnimations_animation_finished():
	if $greenPlayer.get_dead():
		$greenPlayer/greenAnimations.animation = "dead"
	else:
		$greenPlayer/greenAnimations.animation = "idle"

func _on_redAnimations_animation_finished():
	if $redPlayer.get_dead():
		$redPlayer/redAnimations.animation = "dead"
	else:
		$redPlayer/redAnimations.animation = "idle"


func _on_yellowAnimations_animation_finished():
	if $yellowPlayer.get_dead():
		$yellowPlayer/yellowAnimations.animation = "dead"
	else:
		$yellowPlayer/yellowAnimations.animation = "idle"


func _on_blueAnimations_animation_finished():
	if $bluePlayer.get_dead():
		$bluePlayer/blueAnimations.animation = "dead"
	else:
		$bluePlayer/blueAnimations.animation = "idle"


func _on_LongTick_timeout():
	$Countdown/LongTick.stop()
	$Countdown/ShortTick.stop()
	$Countdown/Countdown.hide()
	countdown = 3
	$Countdown/Countdown.text = str(countdown)
	round_initialize()


func _on_ShortTick_timeout():
	countdown -=1
	$Countdown/Countdown.text = str(countdown)
	#$Countdown/Countdown.show()


func _on_Timer_timeout():
	$GameOver/Timer.stop()
	$GameOver/Text.hide()
	$SplashScreen/StartScreen.show()
