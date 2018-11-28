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
	elif Input.is_action_just_released("ui_accept"):
		boost = false
	
	if boost == true:
		$boost/Nimbus2000/bloom.energy = 2
		if $boost.nimbus_state >= 0:
			$boost.nimbus_state -= 1 * delta
		if $boost.nimbus_state > 0.1:
			$character.nimbus_state = true
		else:
			$character.nimbus_state = false
			$boost/Nimbus2000/bloom.energy = 1
	else:
		$boost/Nimbus2000/bloom.energy = 1
		$character.nimbus_state = false
		if $boost.nimbus_state <= 1.5:
			$boost.nimbus_state += 0.05 * delta




func _on_Timer_timeout():
	
	
	light_state = randi()%4
	
	$character.playerInput = true
	
	match light_state:
		0: 
			$ghost.position.x = 768
			$ghost.position.y = 768/2
			$ghost.value = "left"
			$Light2D_left.enabled = true
		1: 
			$ghost.position.y = 768
			$ghost.position.x = 768/2
			$ghost.value = "up"
			$Light2D_up.enabled = true
		2: 
			$ghost.position.x = 0
			$ghost.position.y = 768/2
			$ghost.value = "right"
			$Light2D_right.enabled = true
		3: 
			$ghost.position.y = 0
			$ghost.position.x = 768/2
			$ghost.value = "down"
			$Light2D_down.enabled = true
	
	$ghost/CollisionShape2D.disabled = false
	$ghost/Sprite.visible = true
