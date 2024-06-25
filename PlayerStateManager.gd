extends Node2D

var DEBUG = false; # make true to enable console output
var creditsPBGoffset = 0; # to stash parallax bg offset
var endScene = preload("res://Scenes/campfire_interstitial.tscn")

enum GooseFates {DIDNT_MEET_YET, HELPED, ATE, IGNORED}
enum LumberjackAxeFates {DIDNT_MEET_YET, GAVE, STOLE, LEFT}
enum FishermanFates {DIDNT_MEET_YET, BUCKET_KNOCKED, FISHERMAN_KNOCKED, ASKED_FOR_FISH}
enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
enum OxFates {DIDNT_MEET_YET, RELEASED, PLOWED, IGNORED}
enum FishermanIIFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELSE, IGNORED}
enum HunterFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELSE, IGNORED}
enum FieldNPCFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELESE, IGNORED}
enum FarmerFates {DIDNT_MEET_YET, SNEAKED_IN, DID_SOMETHING_CUTE, IGNORED}

var cycleNum = 1
const MAXCYCLE = 3

var enable_curvature = true

var GooseFate = GooseFates.DIDNT_MEET_YET
var LumberjackAxeFate = LumberjackAxeFates.DIDNT_MEET_YET
var FishermanFate = FishermanFates.DIDNT_MEET_YET
var DeerFate = DeerFates.DIDNT_MEET_YET
var OxFate = OxFates.DIDNT_MEET_YET
var FishermanIIFate = FishermanIIFates.DIDNT_MEET_YET
var HunterFate = HunterFates.DIDNT_MEET_YET
var FieldNPCFate = FieldNPCFates.DIDNT_MEET_YET
var FarmerFate = FarmerFates.DIDNT_MEET_YET

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(0.5))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(0.5))
	GooseFate = GooseFates.DIDNT_MEET_YET
	LumberjackAxeFate = LumberjackAxeFates.DIDNT_MEET_YET
	FishermanFate = FishermanFates.DIDNT_MEET_YET
	DeerFate = DeerFates.DIDNT_MEET_YET
	OxFate = OxFates.DIDNT_MEET_YET
	FishermanIIFate = FishermanIIFates.DIDNT_MEET_YET
	HunterFate = HunterFates.DIDNT_MEET_YET
	FieldNPCFate = FieldNPCFates.DIDNT_MEET_YET
	FarmerFate = FarmerFates.DIDNT_MEET_YET

#func _process(delta):
#	if Input.is_action_just_pressed("ui_home"):
#		EndCycle(true)


func EndCycle(loopCycleToStart = false, cycleCountChange = 1):
	PlayerStateManager.cycleNum += cycleCountChange
	if PlayerStateManager.cycleNum > MAXCYCLE and loopCycleToStart:
		resetfates()
	elif PlayerStateManager.cycleNum > MAXCYCLE+1:
		#The way this is structured, the end scene triggers after this has all run, SO
		#for now there's an extra maxcycle+1 cycle state that tells the end screen that you've finished all three cycles
		#so it can show you the thanks for playing variant
		cycleNum = MAXCYCLE
	get_tree().change_scene_to_packed(endScene)

func printfates():
	if(DEBUG):
		print("Cyclenumber: " + str(cycleNum))
		print("GooseFate: " + GooseFates.find_key(GooseFate))
		print("LumberjackAxeFate: " + LumberjackAxeFates.find_key(LumberjackAxeFate))
		print("FishermanFate: " + FishermanFates.find_key(FishermanFate))
		print("DeerFate: " + DeerFates.find_key(DeerFate))
		print("OxFate: " + OxFates.find_key(OxFate))
		print("FishermanIIFate: " + FishermanIIFates.find_key(FishermanIIFate))
		print("HunterFate: " + HunterFates.find_key(HunterFate))
		print("FieldNPCFate: " + FieldNPCFates.find_key(FieldNPCFate))
		print("FarmerFate: " + FarmerFates.find_key(FarmerFate))

func resetfates():
	cycleNum = 1
	GooseFate = GooseFates.DIDNT_MEET_YET
	LumberjackAxeFate = LumberjackAxeFates.DIDNT_MEET_YET
	FishermanFate = FishermanFates.DIDNT_MEET_YET
	DeerFate = DeerFates.DIDNT_MEET_YET
	OxFate = OxFates.DIDNT_MEET_YET
	FishermanIIFate = FishermanIIFates.DIDNT_MEET_YET
	HunterFate = HunterFates.DIDNT_MEET_YET
	FieldNPCFate = FieldNPCFates.DIDNT_MEET_YET
	FarmerFate = FarmerFates.DIDNT_MEET_YET
