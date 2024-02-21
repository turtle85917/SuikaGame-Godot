extends Resource;
class_name SaveManager;

static var SAVE_PATH = "user://data.save";

static func saveData(score:int):
	var stream = FileAccess.open(SAVE_PATH, FileAccess.WRITE);
	stream.store_line(str(score));

static func loadScore() -> int:
	var stream = FileAccess.open(SAVE_PATH, FileAccess.READ);
	if(stream == null): return 0;
	return int(stream.get_line());
