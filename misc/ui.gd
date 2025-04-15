extends Control
@onready var progress_bar: ProgressBar = $PlayerHealth
var max_hp = PlayerVariables.max_health
var current_hp = PlayerVariables.current_health
func _ready():
	progress_bar.min_value = 0
	progress_bar.max_value = max_hp
	progress_bar.value = current_hp
