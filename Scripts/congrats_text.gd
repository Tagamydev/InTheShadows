extends RichTextLabel

func	turn_on():
	visible = true
	
func _ready():
	visible = false
	SignalBus.really_solved.connect(turn_on)
	
