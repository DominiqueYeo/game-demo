extends Node2D

signal add_health
signal add_speed
signal restart_game

@onready var player_var = get_node("/root/PlayerVariables")

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	if player_var.time_elapsed >= 30.0 :
		new_mob = preload("res://mob_2.tscn").instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)


func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true


func spawn_treasure_box():
	const TREASURE_BOX = preload("res://treasure_box.tscn")
	var new_treasure = TREASURE_BOX.instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	new_treasure.global_position = %PathFollow2D.global_position
	add_child(new_treasure)

func _on_box_spawn_timer_timeout():
	spawn_treasure_box()


func _on_player_treasure_opened():
	%TreasureOpen.visible = true
	get_tree().paused = true


func _on_health_button_pressed():
	%TreasureOpen.visible = false
	get_tree().paused = false
	add_health.emit()


func _on_speed_button_pressed():
	%TreasureOpen.visible = false
	get_tree().paused = false
	add_speed.emit()


func _on_restart_button_pressed():
	get_tree().call_group("mobs1", "queue_free")
	get_tree().call_group("mobs2", "queue_free")
	get_tree().call_group("box1", "queue_free")
	player_var.time_elapsed = 0.0
	player_var.speed = 300
	player_var.exp = 10
	player_var.level = 1
	player_var.player_health = 100
	player_var.bullet_speed = 500
	player_var.bullet_range = 600
	player_var.bullet_max_pierce = 0
	$Player.global_position = Vector2(902, 523)
	%GameOver.visible = false
	get_tree().paused = false




func _on_bullet_range_button_pressed():
	player_var.bullet_range += 600
	%TreasureOpen.visible = false
	get_tree().paused = false


func _on_bullet_speed_button_pressed():
	player_var.bullet_speed += 500
	%TreasureOpen.visible = false
	get_tree().paused = false


func _on_bullet_pierce_button_pressed():
	player_var.bullet_max_pierce += 1
	%TreasureOpen.visible = false
	get_tree().paused = false
