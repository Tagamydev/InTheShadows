extends CheckButton


func _on_button_down():
	SignalBus.music_enabled = true
	SignalBus.music_on.emit()
	pass # Replace with function body.


func _on_button_up():
	SignalBus.music_enabled = false
	SignalBus.music_off.emit()
	pass # Replace with function body.

func open_menu():
	get_parent().visible = true


func close_menu():
	get_parent().visible = false

func _ready():
	SignalBus.open_menu.connect(open_menu)
	SignalBus.return_menu.connect(close_menu)
	get_parent().visible = false


func _on_button_2_button_down():
	get_parent().visible = false
	pass # Replace with function body.
