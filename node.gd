extends Node
func _ready():
	DiscordRPC.app_id = 1360066631191101631
	DiscordRPC.details = "A reverse souls rpg where you play as the endgame boss"
	DiscordRPC.state = "Testing game"
	
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	
	DiscordRPC.refresh()
	
func _process(_delta):
	DiscordRPC.run_callbacks()
