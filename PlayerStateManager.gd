extends Node2D

enum GooseFates {DIDNT_MEET_YET, HELPED, ATE, IGNORED}
enum LumberjackAxeFates {DIDNT_MEET_YET, GAVE, STOLE, LEFT}
enum FishermanFates {DIDNT_MEET_YET, BUCKET_KNOCKED, FISHERMAN_KNOCKED, ASKED_FOR_FISH}
enum DeerFates {DIDNT_MEET_YET, HELPED, SCARED, IGNORED}
enum OxFates {DIDNT_MEET_YET, RELEASED, PLOWED}
enum FishermanIIFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELSE}
enum HunterFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELSE}
enum FieldNPCFates {DIDNT_MEET_YET, SOMETHING, SOMETHINGELESE}
enum FarmerFates {DIDNT_MEET_YET, SNEAKED_IN, DID_SOMETHING_CUTE}

var cycleNum = 1

var GooseFate = GooseFates.DIDNT_MEET_YET
var LumberjackAxeFate = LumberjackAxeFates.DIDNT_MEET_YET
var FishermanFate = FishermanFates.DIDNT_MEET_YET
var DeerFate = DeerFates.DIDNT_MEET_YET
var OxFate = OxFates.DIDNT_MEET_YET
var FishermanIIFate = FishermanIIFates.DIDNT_MEET_YET
var HunterFate = HunterFates.DIDNT_MEET_YET
var FieldNPCFate = FieldNPCFates.DIDNT_MEET_YET
var FarmerFate = FarmerFates.DIDNT_MEET_YET


func _process(delta):
	if Input.is_action_just_pressed("ui_home"):
		PlayerStateManager.cycleNum += 1
		if PlayerStateManager.cycleNum > 3:
			resetfates()
		get_tree().reload_current_scene()


func printfates():
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
