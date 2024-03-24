extends Node

@onready var BGM:AudioStreamPlayer = get_node("BGM");

func playBGM():
	BGM.play()
func replayBGM():
	BGM.stop()
	BGM.play()
func stopBGM():
	BGM.stop()

func playSFX(sfxName:String):
	var audioStream:AudioStreamPlayer = get_node(sfxName);
	if(audioStream.playing): audioStream.stream_paused = true;
	audioStream.playing = true;
