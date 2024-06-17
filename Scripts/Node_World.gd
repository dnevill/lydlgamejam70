extends Node2D

const TILE_SIZE = 32;

var JSON_FILE = {};
var TILE_SHEET;
var MAP_WIDTH;
var MAP_HEIGHT;
var MAP_NAME;
var FILE_NAME;

func _on_World_ready():
	var FileHandler = FileAccess.open("res://Tilemaps/pondsample.json", FileAccess.READ);
	var json_string = FileHandler.get_as_text();
	FileHandler.close();
	
	JSON_FILE = JSON.parse_string(json_string);
	
	# read map properties
	MAP_WIDTH = int(JSON_FILE["width"]);
	MAP_HEIGHT = int(JSON_FILE["height"]);
	for mapProp in JSON_FILE["properties"]:
		match mapProp["name"]:
			"MapName":
				MAP_NAME = mapProp["value"];
	pass;
	
	print("LOADING MAP");
	
	# read layer data
	var LAYER_INDEX_FOREGROUND = null;
	var LAYER_INDEX_BACKGROUND = null;
	for i in range(0, JSON_FILE["layers"].size()):
		match JSON_FILE["layers"][i]["name"]:
			"fg":
				LAYER_INDEX_FOREGROUND = i;
			"bg":
				LAYER_INDEX_BACKGROUND = i;
	pass;
	assert(LAYER_INDEX_FOREGROUND != null);
	
	print("LAYER_INDEX_FOREGROUND "+str(LAYER_INDEX_FOREGROUND));
	print("LAYER_INDEX_BACKGROUND "+str(LAYER_INDEX_BACKGROUND));
	
	# populate tiles
	var iy = 0;
	var ix = 0;
	var iFG = 0;
	var iBG = 0;
	for i in range(0, (MAP_WIDTH * MAP_HEIGHT)):
		iFG = int(JSON_FILE["layers"][LAYER_INDEX_FOREGROUND]["data"][i])-1;
		if(iFG > -1):
			$ForegroundMap.set_cell(0,Vector2i(ix,iy),0,Vector2i(iFG % 10,iFG / 10));
			print("Placing FG "+str(iFG)+" at "+str(ix)+","+str(iy));
		if(LAYER_INDEX_BACKGROUND != null):
			iBG = int(JSON_FILE["layers"][LAYER_INDEX_BACKGROUND]["data"][i])-1;
			if(iBG > -1):
				$BackgroundMap.set_cell(0,Vector2i(ix,iy),0,Vector2i(iBG % 10,iBG / 10));
				print("Placing BG "+str(iBG)+" at "+str(ix)+","+str(iy));
		ix = ix + 1;
		if(ix == MAP_WIDTH):
			iy = iy + 1;
			ix = 0;
		pass;
	pass;
	
	print("LOADED");
