extends Control
@onready var progress_bar: ProgressBar = $PlayerHealth
var max_hp = PlayerVariables.max_health
func _ready():
	progress_bar.min_value = 0
	progress_bar.max_value = max_hp

func _process(_delta):
	progress_bar.value = PlayerVariables.current_health
