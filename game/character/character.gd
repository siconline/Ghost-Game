extends KinematicBody2D


var movement = Vector2(0, 0)
var speed = 150
var playerInput = false
var light_off = true
var score = 0
var ghost_speed = 150
var start_cover_effect = false
var cover_effect_one_time = true
var boost = false
var goal = false # by true set in main_scene ghost collision disabled
var nimbus_state = false
var jewel # value for main_scene to change variable in jewel scene
var light_on # value for main_scene to change variable in jewel scene




func _ready():
	
	
	randomize()
	
	jewel = randi()%4 # change jewel at start - random value for jewel
	
	
	
	
func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("ui_right"):
		if playerInput == true:
			playerInput = false
			$Sprite.flip_h = false
			$Sprite/Light2D.scale.x = 0.576612		# nimbus bloom direction
			$Sprite/Light2D.position.x = -4.358089	# nimbus bloom direction
			movement = Vector2(speed, 0)
			
	elif Input.is_action_just_pressed("ui_left"):
		if playerInput == true:
			playerInput = false
			$Sprite.flip_h = true
			$Sprite/Light2D.scale.x = -0.576612		# nimbus bloom direction
			$Sprite/Light2D.position.x = 4.358089	# nimbus bloom direction
			movement = Vector2(-speed, 0)
			
	elif self.position.x <= 0-100 || self.position.x >= 768+100:
		movement = Vector2(0, 0)
		light_off = true
		# MANAGE SCORE - only level up by light on
		if get_node("../../main_scene/Light2D_right").enabled == true || get_node("../../main_scene/Light2D_left").enabled == true:
			score += 1
		else:
			score -= 1
		self.position.x = 768/2
		ghost_speed += 10
		
		# JEWEL
		jewel = randi()%4 # change jewel - random value for jewel
		light_on = true # value for jewel to set jewel
		get_node("../../main_scene")._reset_jewel() # value for visibility false at jewel
		
	elif self.position.x <= 0 || self.position.x >= 768:
		if cover_effect_one_time == true:
			start_cover_effect = true
			cover_effect_one_time = false
	
	if Input.is_action_just_pressed("ui_down"):
		if playerInput == true:
			playerInput = false
			movement = Vector2(0, speed)
			
	elif Input.is_action_just_pressed("ui_up"):
		if playerInput == true:
			playerInput = false
			movement = Vector2(0, -speed)
			
	elif self.position.y <= 0-100 || self.position.y >= 768+100:
		movement = Vector2(0, 0)
		light_off = true
		# MANAGE SCORE - only level up by light on
		if get_node("../../main_scene/Light2D_up").enabled == true || get_node("../../main_scene/Light2D_down").enabled == true:
			score += 1
		else:
			score -= 1
		self.position.y = 768/2
		ghost_speed += 10
		
		# JEWEL
		jewel = randi()%4 # change jewel - random value for jewel
		light_on = true # value for jewel to set jewel
		get_node("../../main_scene")._reset_jewel() #value for visibility false at jewel
	
	elif self.position.y <= 0 || self.position.y >= 768:
		if cover_effect_one_time == true:
			start_cover_effect = true
			cover_effect_one_time = false
	
	
	# RESET var goal
	if light_off == true:
		goal = true
	else:
		goal = false
	
	
	# BOOST CONTROL - MANAGE CHARACTER SPEED
	if nimbus_state == true:
		boost = true
			
	if nimbus_state == false:
			boost = false

	if boost == true:
		if movement.x >= 150 && movement.y == 0:
			movement = Vector2(ghost_speed, 0)
		elif movement.x == 0 && movement.y >= 150:
			movement = Vector2(0, ghost_speed)
		elif movement.x <= -150 && movement.y == 0:
			movement = Vector2(-ghost_speed, 0)
		elif movement.x == 0 && movement.y <= -150:
			movement = Vector2(0, -ghost_speed)
	else:
		if movement.x > 150 && movement.y == 0:
			movement = Vector2(speed, 0)
		elif movement.x == 0 && movement.y > 150:
			movement = Vector2(0, speed)
		elif movement.x < -150 && movement.y == 0:
			movement = Vector2(-speed, 0)
		elif movement.x == 0 && movement.y < -150:
			movement = Vector2(0, -speed)
	
	
	move_and_collide(movement * delta)
	