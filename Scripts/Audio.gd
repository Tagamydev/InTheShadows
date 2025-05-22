extends AudioStreamPlayer

func	turn_audio_off():
	playing = false


func	turn_audio_on():
	playing = true


func	_ready():
	SignalBus.music_off.connect(turn_audio_off)
	SignalBus.music_on.connect(turn_audio_on)
	if SignalBus.music_enabled:
		turn_audio_on()
	else:
		turn_audio_off()
