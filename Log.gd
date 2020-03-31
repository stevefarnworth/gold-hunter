extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_Log_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Log_body_entered(body):
	print("boooom")
	if (body.get_name() == "Player"):
		GameGlobals.logs = GameGlobals.logs + 1
		var logs_label = get_tree().get_root().get_node("Node2D/GUILayer/Logs")
		logs_label.set_text(str(GameGlobals.logs))	
		queue_free()

