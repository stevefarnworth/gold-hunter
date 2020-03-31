extends KinematicBody2D

var speed = rand_range(50,100)
var velocity = Vector2()

func _physics_process(delta):
	var ppo = get_tree().get_root().get_node("Node2D/Player").position
	var direction = ( ppo - self.position ).normalized()
	var collision = move_and_collide(direction * speed * delta)
	$AnimatedSprite.play("right")
