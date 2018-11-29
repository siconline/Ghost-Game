extends Area2D


var jewel
var jewel_pos # this is the position from the light
var light_on = false # information from main_scene


func _ready():
	
	
	randomize()
	
	$green.visible 	= false
	$orange.visible 	= false
	$blue.visible 	= false
	$red.visible 		= false
	
	
	
	
func _process(delta):

	
	if light_on == true:
		match jewel:
			0:
				#print("green")
				if $AnimationPlayer.is_playing():
					pass
				else:
						$AnimationPlayer.play("green")
			1:
				#print("orange")
				if $AnimationPlayer.is_playing():
					pass
				else:
						$AnimationPlayer.play("orange")
			2:
				#print("blue")
				if $AnimationPlayer.is_playing():
					pass
				else:
						$AnimationPlayer.play("blue")
			3:
				#print("red")
				if $AnimationPlayer.is_playing():
					pass
				else:
						$AnimationPlayer.play("red")
		
		
		match jewel_pos:
			0:
				var value = randi()%2
				match value:
					0:
						self.position = Vector2(384, 200)
					1:
						self.position = Vector2(384, 568)
			1:
				var value = randi()%2
				match value:
					0:
						self.position = Vector2(200, 384)
					1:
						self.position = Vector2(568, 384)
			2:
				var value = randi()%2
				match value:
					0:
						self.position = Vector2(384, 200)
					1:
						self.position = Vector2(384, 568)
			3:
				var value = randi()%2
				match value:
					0:
						self.position = Vector2(200, 384)
					1:
						self.position = Vector2(568, 384)
		light_on = false
