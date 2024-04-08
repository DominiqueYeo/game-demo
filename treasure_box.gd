extends Area2D




func _on_body_entered(body):
	queue_free()
	if body.has_method("open_treasure"):
		body.open_treasure()
