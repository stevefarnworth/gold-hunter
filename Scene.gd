extends Node2D

var bulletscene = load("res://Enemy.tscn")
var goldscene = load("res://Gold.tscn")
var logscene = load("res://Log.tscn")

func _ready():
	pass
	
func add_zombie():
	GameGlobals.enemies = GameGlobals.enemies + 1
	if GameGlobals.enemies < 10:
		var bullet = bulletscene.instance()
		bullet.position = Vector2(rand_range(-800,800),rand_range(-400,350))
		get_tree().get_root().call_deferred("add_child", bullet)	
		var enemies_label = get_node("GUILayer/Enems")
		enemies_label.set_text(str(GameGlobals.enemies))	
		
func add_gold():
	var gold = goldscene.instance()
	gold.position = Vector2(rand_range(-400,400),rand_range(-400,350))
	get_tree().get_root().call_deferred("add_child", gold)		

func add_logs():
	var loggy = logscene.instance()
	loggy.position = Vector2(rand_range(-400,400),rand_range(-400,350))
	get_tree().get_root().call_deferred("add_child", loggy)		


#func _physics_process(delta):
#	pass


func _on_Timer_timeout():
	if GameGlobals.enemies < 10:
		add_zombie()
		add_gold()
		add_logs()
