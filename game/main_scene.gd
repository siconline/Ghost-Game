extends Node


var angle = 0
var light_state = 0
var light_on = false
onready var ghost_state = $ghost.ghost_state




func _ready():
	
	
	randomize()
	
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://music/Happy_Haunts.ogg")
	player.play()
	
	
	
func _process(delta):
	
	
	$Score.text = str("Level : ", $character.score)
	$ghost.speed = $character.ghost_speed
	
	if $character.light_off == true:
		light_on = false
		$character.light_off = false
	
	if light_on == true:
		$light.visible = true
	else:
		$light.visible = false
		
	$light.rotation = deg2rad(angle)


func _on_Timer_timeout():
	
	
	light_state = randi()%4
	
	light_on = true
	
	$character.playerInput = true
	
	match light_state:
		0: 
			$ghost.position.x = 768
			$ghost.position.y = 768/2
			angle = 0 
			$ghost.value = "left"
		1: 
			$ghost.position.y = 768
			$ghost.position.x = 768/2
			angle = 90
			$ghost.value = "up"
		2: 
			$ghost.position.x = 0
			$ghost.position.y = 768/2
			angle = 180
			$ghost.value = "right"
		3: 
			$ghost.position.y = 0
			$ghost.position.x = 768/2
			angle = 270
			$ghost.value = "down"
	
	$ghost/CollisionShape2D.disabled = false
	$ghost/Sprite.visible = true
