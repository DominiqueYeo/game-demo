extends Area2D

@onready var player_vars = get_node("/root/PlayerVariables")

var travelled_distance = 0 
var actual_pierce = 0
func _physics_process(delta):

	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * player_vars.bullet_speed * delta
	
	travelled_distance += player_vars.bullet_speed * delta
	if travelled_distance > player_vars.bullet_range :
		queue_free()


func _on_body_entered(body):
	actual_pierce += 1
	if actual_pierce > player_vars.bullet_max_pierce:
		queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
