extends Node


var light_state = 0
onready var ghost_state = $ghost.ghost_state
var boost = false




func _ready():
	
	
	randomize()
	
	$Light2D_left.enabled = false
	$Light2D_right.enabled = false
	$Light2D_up.enabled = false
	$Light2D_down.enabled = false
	
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://music/Happy_Haunts.ogg")
	player.play()
	
	
	
func _process(delta):

	
	if $character.start_cover_effect == true:
		$cover/Cover_effect/AnimationPlayer.play("white_to_black")
		$character.start_cover_effect = false
	if $cover/Cover_effect/AnimationPlayer.is_playing() == false:
		$character.cover_effect_one_time = true
	
	$Score.text = str("Level : ", $character.score)
	$ghost.speed = $character.ghost_speed
	
	if $character.light_off == true:
		$Light2D_left.enabled = false
		$Light2D_right.enabled = false
		$Light2D_up.enabled = false
		$Light2D_down.enabled = false
		$character.light_off = false
	
	if $character.goal == true:
		$ghost/CollisionShape2D.disabled = true
	
	
	# BOOST CONTROL - MANAGE STATEBAR BOOST
	if Input.is_action_just_pressed("ui_accept"):
		if $character.movement.x > 0 || $character.movement.y > 0 || $character.movement.x < 0 || $character.movement.y < 0:
			boost = true
			if $character/Sprite/bloomOUTPlayer.is_playing():	# bloom controll on character
				pass
			else:
				$character/Sprite/bloomINPlayer.play("bloom")		# bloom controll on character
	elif Input.is_action_just_released("ui_accept"):
		boost = false
	
	if boost == true:	# main boost aktivate
		if $boost.nimbus_state >= 0:
			$boost.nimbus_state -= 1 * delta
		if $boost.nimbus_state > 0.1:
			$character.nimbus_state = true
		else:
			$character.nimbus_state = false
			if $character/Sprite/bloomOUTPlayer.is_playing():	# bloom controll on character
				pass
			else:
				if $character/Sprite/Light2D.energy < 1:	# bloom controll on character
					pass
				else:
					$character/Sprite/bloomOUTPlayer.play_backwards("bloom")	# bloom controll on character
	else:
		if $character/Sprite/bloomOUTPlayer.is_playing():	# bloom controll on character
			pass
		else:
			if $character/Sprite/Light2D.energy < 1:
				pass
			else:
				$character/Sprite/bloomOUTPlayer.play_backwards("bloom")	# bloom controll on character
		$character.nimbus_state = false
		if $boost.nimbus_state <= 1.5:
			$boost.nimbus_state += 0.05 * delta
	




func _set_jewel():
	# JEWEL
	# change value for jewel
	$jewel.jewel = $character.jewel
	$jewel.jewel_pos = light_state
	if $character.light_on == true:
		$jewel.light_on = $character.light_on
		$character.light_on = false

func _reset_jewel():
	$jewel/green.visible 	= false
	$jewel/orange.visible 	= false
	$jewel/blue.visible 	= false
	$jewel/red.visible 		= false



func _on_Timer_timeout():
	
	
	light_state = randi()%4
	
	$character.playerInput = true
	
	if $character.score == 0 :
		$ghost.position.x = 1000
		$ghost.position.y = 1000
		$Light2D_left.enabled = true
		$Light2D_up.enabled = true
		$Light2D_right.enabled = true
		$Light2D_down.enabled = true
	else:
		match light_state:
			0: 
				$ghost.position.x = 768
				$ghost.position.y = 768/2
				$ghost.value = "left"
				$Light2D_left.enabled = true
				_set_jewel()
			1: 
				$ghost.position.y = 768
				$ghost.position.x = 768/2
				$ghost.value = "up"
				$Light2D_up.enabled = true
				_set_jewel()
			2: 
				$ghost.position.x = 0
				$ghost.position.y = 768/2
				$ghost.value = "right"
				$Light2D_right.enabled = true
				_set_jewel()
			3: 
				$ghost.position.y = 0
				$ghost.position.x = 768/2
				$ghost.value = "down"
				$Light2D_down.enabled = true
				_set_jewel()
	
	$ghost/CollisionShape2D.disabled = false
	$ghost/Sprite.visible = true
