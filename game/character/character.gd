extends KinematicBody2D


var movement = Vector2(0, 0)
var speed = 150
var playerInput = false
var light_off
var score = 0
var ghost_speed = 150



func _physics_process(delta):
	print(score)
	
	if Input.is_action_just_pressed("ui_right"):
		if playerInput == true:
			playerInput = false
			$Sprite.flip_h = false
			movement = Vector2(speed, 0)
			
	elif Input.is_action_just_pressed("ui_left"):
		if playerInput == true:
			playerInput = false
			$Sprite.flip_h = true
			movement = Vector2(-speed, 0)
			
	elif self.position.x <= 0-100 || self.position.x >= 768+100:
		movement = Vector2(0, 0)
		light_off = true
		score += 1
		self.position.x = 768/2
		ghost_speed += 10
	
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
		score += 1
		self.position.y = 768/2
		ghost_speed += 10
	
	move_and_collide(movement * delta)
