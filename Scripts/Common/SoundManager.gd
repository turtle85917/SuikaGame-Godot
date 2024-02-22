extends Node

func playSFX(name:String):
	var audioStream:AudioStreamPlayer = get_node(name);
	if(audioStream.playing): audioStream.stream_paused = true;
	audioStream.playing = true;
