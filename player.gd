extends CharacterBody2D

@onready var player_vars = get_node("/root/PlayerVariables")

var player_speed = 300
var health = 100.0
signal health_depleted
signal treasure_opened


func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * player_vars.speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
		%HappyBoo2.play_walk_animation()
		%HappyBoo3.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		%HappyBoo2.play_idle_animation()
		%HappyBoo3.play_idle_animation()
		
	var overlapping_mobs = %HitBox.get_overlapping_bodies()
	const DAMAGE_RATE = 10.0
	if overlapping_mobs.size() > 0:
		player_vars.player_health-= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = player_vars.player_health
		if player_vars.player_health <= 0.0:
			health_depleted.emit()
			
	
	if player_vars.level == 1 :
		%HappyBoo.visible = true
		%HappyBoo2.visible = false
		%HappyBoo3.visible = false
	if player_vars.level == 2 :
		%HappyBoo.visible = false
		%HappyBoo2.visible = true
		
	if player_vars.level == 3 :
		%HappyBoo2.visible = false
		%HappyBoo3.visible = true
		

func open_treasure():
	print("TREASURE!!!!!")
	treasure_opened.emit()




func _on_game_add_health():
	player_vars.player_health = 100
	%ProgressBar.value = player_vars.player_health


func _on_game_add_speed():
	player_vars.speed += 300
