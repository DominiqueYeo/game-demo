extends Label

var time_elapsed := 0.0

@onready var player_vars = get_node("/root/PlayerVariables")



func _process(delta: float) -> void:
	
	player_vars.time_elapsed += delta
	var mins_elapsed = int(player_vars.time_elapsed) / 60
	var seconds_elapsed = int(player_vars.time_elapsed) % 60 
	self.text = "%02d:%02d" % [mins_elapsed,seconds_elapsed]
	
