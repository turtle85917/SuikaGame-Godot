extends Node

func playSFX(sfxName:String):
	var audioStream:AudioStreamPlayer = get_node(sfxName);
	if(audioStream.playing): audioStream.stream_paused = true;
	audioStream.playing = true;
