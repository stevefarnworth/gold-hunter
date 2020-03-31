extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Gold_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Gold_body_entered(body):
	print("boooom")
	if (body.get_name() == "Player"):
		GameGlobals.gold = GameGlobals.gold + 1
		var gold_label = get_tree().get_root().get_node("Node2D/GUILayer/Gold")
		gold_label.set_text(str(GameGlobals.gold))	
		queue_free()

