extends KinematicBody2D

var speed = 125
var velocity = Vector2()

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		$AnimatedSprite.set_flip_h( false )
		$AnimatedSprite.play("right")
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$AnimatedSprite.set_flip_h( true )
		$AnimatedSprite.play("right")
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
		$AnimatedSprite.set_flip_h( false )
		$AnimatedSprite.play("down")
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		$AnimatedSprite.set_flip_h( false )
		$AnimatedSprite.play("up")
		
	velocity = velocity.normalized() * speed
			
	if Input.is_action_just_pressed('press_b'):
		if GameGlobals.logs < 3:
			pass
		else:
			var base = load("res://Base.tscn")
			var base_place = base.instance()
			base_place.position = Vector2((self.position.x - 10), (self.position.y + 10))
			get_tree().get_root().call_deferred("add_child", base_place)	
			GameGlobals.logs = GameGlobals.gold - 3
			var logs_label = get_tree().get_root().get_node("Node2D/GUILayer/Logs")
			logs_label.set_text(str(GameGlobals.logs))
			GameGlobals.bases = GameGlobals.bases + 1
			var bases_label = get_tree().get_root().get_node("Node2D/GUILayer/Bases")
			bases_label.set_text(str(GameGlobals.bases))					
		
	if Input.is_action_just_pressed('press_l'):
		if GameGlobals.logs < 1:
			pass
		else:
			var light = load("res://Light.tscn")
			var light_place = light.instance()
			light_place.position = Vector2(self.position)
			get_tree().get_root().call_deferred("add_child", light_place)
			GameGlobals.logs = GameGlobals.logs - 1
			var logs_label = get_tree().get_root().get_node("Node2D/GUILayer/Logs")
			logs_label.set_text(str(GameGlobals.logs))	
		
	if Input.is_action_just_pressed("zoom_out"):
		$Camera2D.zoom = $Camera2D.get_zoom() + Vector2(0.1,0.1)
		
	if Input.is_action_just_pressed("zoom_in"):
		if $Camera2D.get_zoom() == Vector2(0.1,0.1):
			pass
		else:
			$Camera2D.zoom = $Camera2D.get_zoom() - Vector2(0.1,0.1)		

func _physics_process(delta):
	get_input()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		$AnimatedSprite.play("boom")
		GameGlobals.health = GameGlobals.health - 1
		var lab = get_node("RichTextLabel")
		lab.set_text(str(GameGlobals.health))		
	elif velocity.x == 0 and velocity.y == 0:
		$AnimatedSprite.play("stand")

	if GameGlobals.health == 0:
		self.position = Vector2(rand_range(-800,800),rand_range(-400,350))
		GameGlobals.health = 100
		GameGlobals.lives = GameGlobals.lives - 1
		var lives_label = get_tree().get_root().get_node("Node2D/GUILayer/Lives")
		lives_label.set_text(str(GameGlobals.lives))		
		
	if GameGlobals.lives == 0:	
		get_tree().paused = true	
		get_tree().change_scene("res://DiedLayer.tscn")
		
	if GameGlobals.gold == 20:
		get_tree().paused = true	
		get_tree().change_scene("res://DiedLayer.tscn")
