extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var player_vars = get_node("/root/PlayerVariables")

#func _ready():
	#player = get_node("/root/Game/Player")

var health = 5
func _ready():
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 200
	move_and_slide()


func take_damage():
	health -= player_vars.level
	%Slime.play_hurt()
	
	
	
	if health <= 0 : 
		queue_free()
		
		player_vars.exp += 1
		player_vars.level = player_vars.exp/10
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		
		get_parent().add_child(smoke)
		smoke.global_position = global_position
