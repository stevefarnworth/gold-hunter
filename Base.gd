extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Base_body_entered")
	connect("body_exited", self, "_on_Base_body_exited")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Base_body_entered(body):
	print("boooom")
	if (body.get_name() != "Player"):
		#$AnimatedSprite.play("boom")
		body.queue_free() 
		if GameGlobals.enemies == 0:
			pass
		else:
			GameGlobals.enemies = GameGlobals.enemies - 1
			var enemies_label = get_tree().get_root().get_node("Node2D/GUILayer/Enems")
			enemies_label.set_text(str(GameGlobals.enemies))	

	elif (body.get_name() == "Player"):
		if GameGlobals.health > 95:
			pass
		else:
			GameGlobals.health = GameGlobals.health + 1
			var lab = get_tree().get_root().get_node("Node2D/Player/RichTextLabel")
			lab.set_text(str(GameGlobals.health))	

func _on_Base_body_exited(_body):
	pass
