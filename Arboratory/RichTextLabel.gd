extends RichTextLabel

var dialogue = [
	"This is Arboratory",
	"We're making a lot of cool trees",
	"More filler text",
	"End"
]

var dialogue_index = 0
onready var dex = get_tree().get_root().find_node("treeDex", true, false)
signal showSprite
signal hideSprite



signal showSprite2
signal hideSprite2

signal showSprite3
signal hideSprite3

var interactable = false
var win = false
var choices = 0
#var base = []
var numOptions = []
var optionIndex = 0
var numPressed = 0
var good = true
var numChars = 0
#var charDialogue = []
var order = []
var orderIndex = 0
#var knowledgeIndex = 0
#var loveIndex = 0

var info = {}

func select_dialogue():
	get_tree().get_root().find_node("Dialogue Sound Effect",true,false).play()
	
	match Leveling.level:
		1:
			print('successfully did the thing')
			dialogue = ["I’m a scientist who has devoted their life to studying solutions to the impending energy crisis, but one day, while I was slacking off, I discovered I could splice the DNA of a tree with the molecular structure of my sample tree.",
			"Since that is infinitely more interesting, my new goal is to create as many new trees as possible and possibly learn something along the way! My search started with consulting the Tree of Knowledge on the project.",
			"Tree of Knowledge: \"Greetings seeker of trees. Would you like some guidance before you embark on this great endeavor? My being holds eons of information that could be useful to your research. Let us begin with the basics\"",
			"\"This is referred to as the merge area. It is here where you can access your TreeDex. As you create new trees, they will be unlocked here, allowing you to learn about their various properties and personalities.\"",
			"\"To create a sapling, drag a seed to the middle of the merge area and provide it with water.\"",
			"\"Saplings are planted in the farm area of the arboretum. Click or tap on an inventory slot and then click or tap on the plot in which you wish to plant your sapling. By clicking on a tree, you can view its status. Return to hide this information.\"",
			"\"Like all living beings, your trees have biological needs. If you fail to provide for your creations, they will wither and die. To prevent this fate, make sure you water your trees regularly.",
			"\"You can do this by pressing the watering button and then pressing the tree you desire to water.\"",
			"\"Each type of tree has its own special talents and abilities, so take these into account when creating your farm. You can learn more about this in your TreeDex.\"",
			"\"You can harvest a single tree by selecting clear single plot followed by the desired tree. If you wish to harvest all your trees at once, select clear all plots.\"",
			"\"A dead tree will only produce one seed upon harvest; however, a healthy, mature tree will yield two seeds. Turn your attention back to the merge area. To splice two different trees, you will need two seeds of each type.\"",
			"\"To splice the DNA of two seeds, simply drag them together in the merge area. Keep in mind, not all combinations produce a tree. An incompatible combination will still consume both seeds, so be cautious.\"",
			"\"That’s all I have for you for now. I could impart so much more, but it can be overwhelming to intake too much information at once.\"",
			"\"I wish you the best of luck in your quest for knowledge, and I will be here to support you should you require any more assistance.\"",
			"\"Continue creating trees!\""]
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0, 
			"numOptions": [], "dialogue": [[]]
			}}
			emit_signal("showSprite")
			emit_signal("hideSprite2") 
			emit_signal("hideSprite3")
		3:
			set_process_input(true)
			show()
			dialogue = ["\"It seems you’ve discovered a new technique for creating trees. You can now combine the molecular structure of an item with the DNA of a tree. Allow me to introduce you to the process.\"",
			"\"To attempt to merge an item with a tree, simply drag together a seed and the item you wish to combine it with. Not all items and seeds are compatible, so you will have to attempt different combinations before you find one that works.\"",
			"\"Continue your quest for knowledge! Your progress thus far has been outstanding. I predict a great future for you.\""]
			
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0, 
			"numOptions": [], "dialogue": [[]]
			}}
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")

		5:
			show()
			set_process_input(true)
			dialogue = ["Uh oh", "Looks like there's a new tree on the block",
			"I wonder what she wants now..."]
			info = {0: {"char": "knowledge", "dialogue index": 0, "choices": 0,
				"numOptions": [],
				"dialogue": [["You know that's not my name, why are you here?"], 
				["And how, pray tell, are you going to do that?"],
				["Goodness"]]},
				1: {"char": "love", "dialogue index": 0, "choices": 0, "numOptions": [],
				"dialogue": [["Hello darling", "I'm the Love Tree.", 
				"Owly, baby, it's been a while"], 
				["I noticed the lovely work the professor is doing and thought I would lend a hand"],
				["By showing the professor how to love trees, of course!", 
				"What?", "I thought you were all about gaining new knowledge"],
				["Some trees might talk to you now", 
				"All you have to do is pick a response from the options that pop up on the screen", 
				"Try it now with my little bird friend here"]]},
				2: {"char": "yoon", "dialogue index": 0, "choices": 4, "numOptions": [2, 0, 2, 1],
				"dialogue": [["Oh, hello!", "I didn't see you there.", 
				"Do you need my help with something?"], 
				["My name is Yoon, but lately people have been calling me Mother Hen Yoon.",
				"You're welcome to call me whatever you like, really"]]}}

			numChars = 3
			order = [0, 1, 0, 1, 0, 1, 0, 1, 2]

			#"Do you need my help with something?"]
			#base = ["My name is Yoon, but lately people have been calling me Mother Hen Yoon.",
			#"You're welcome to call me whatever you like, really"]
			#numOptions = [2, 0, 2, 1]
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")
			emit_signal("hideSprite4")
			
			#choices = 4

			
		_:
			hide()
			emit_signal("hideSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")
			emit_signal("hideSprite4")
			set_process_input(false)

signal releaseTheButtons(duration, numButtons, good)
signal hideButtons()
signal hideBox()
signal showBox()
signal showSprite4()
signal hideSprite4()
var final = false

func _ready():
	
	dex.connect("win",self,"_on_Win")
	select_dialogue()
	emit_signal("showBox")
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	
var waiting = false
	
func _input(event):
	#print('waiting: ' + str(waiting))
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton) && !waiting:
		var character = 0
		if order.size() > 0:
			character = order[orderIndex]
		numOptions = info[character]["numOptions"]
		choices = info[character]["choices"]
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				get_tree().get_root().find_node("Dialogue Sound Effect",true,false).play()
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
				#emit_signal("hideButtons")
			elif numChars > 0:
				#knowledge tree is 0, love tree 1, yoon 2
				if character == 2:
					numChars = 0
				else:
					orderIndex += 1
					character = order[orderIndex]
					set_sprite(character)
					load_dialogue(character)
					
				
			elif optionIndex < numOptions.size() and choices > 0:
				if good:
					emit_signal("showSprite3")
					emit_signal("hideSprite4")
				else:
					emit_signal("hideSprite3")
					emit_signal("showSprite4")
				emit_signal("releaseTheButtons", 1, numOptions[optionIndex], good)
				print("choices: " + str(choices))
				choices -= 1
				if numOptions[optionIndex] != 0:
					waiting = true
				optionIndex += 1
			else:
				print("ok but")
				emit_signal("hideSprite")
				emit_signal("hideSprite2")
				emit_signal("hideSprite3")
				emit_signal("hideSprite4")
				emit_signal("hideBox")
				hide()
				get_tree().get_root().find_node("BaseFarmGrid",true,false)._exit_farm()
				set_process_input(false)
				#set_process_input(false)
				if win:
					get_tree().change_scene("res://Credits.tscn")
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)

func load_dialogue(character):
	var index = info[character]["dialogue index"]
	dialogue = info[character]["dialogue"][index]
	info[character]["dialogue index"] += 1
	dialogue_index = -1
	set_process_input(true)

func set_sprite(character):
	print("info[character]: " + str(info[character]))
	match info[character]["char"]:
		"knowledge":
			emit_signal("showSprite")
			emit_signal("hideSprite2")
			emit_signal("hideSprite3")
		"love":
			emit_signal("showSprite2")
			emit_signal("hideSprite")
			emit_signal("hideSprite3")
		"yoon":
			emit_signal("showSprite3")
			emit_signal("hideSprite")
			emit_signal("hideSprite2")

func _on_Button_pressed():
	good = true
	waiting = false
	numPressed += 1
	print("numPressed: " + str(numPressed))
	emit_signal("hideButtons")

	match (numPressed):
		1:
			set_bbcode("Aww well aren't you sweet?")
			set_visible_characters(0)
			dialogue = info[2]["dialogue"][1]
			dialogue_index = -1
			set_process_input(true)
		2:
			dialogue = ["O-oh goodness!", "Are you flirting with me?", "I-I...",
			"I don't know how to respond"]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
		3:
			dialogue = ["Hehe, well aren't you a charmer?", 
			"Well... I suppose it's alright.", "Just make sure to water the trees before we leave!"]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
			


func _on_Button2_pressed():
	good = false
	waiting = false
	numPressed += 1
	print("numPressed: " + str(numPressed))
	emit_signal("hideButtons")

	match (numPressed):
		1:
			set_bbcode("Oh! I guess I haven't introduced myself yet.")
			set_visible_characters(0)
			dialogue = info[2]["dialogue"][1]
			dialogue_index = -1
			set_process_input(true)
		2:
			dialogue = ["I'd rather you not."]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
		3:
			dialogue = ["*inhales*", "YOU CANT.", "KEEP.", "DOING THIS.",
			"*sighs*", "You know what? I've gotta run.", "Important hen business.",
			"Goodbye, my child."]
			dialogue_index = 0
			set_bbcode(dialogue[dialogue_index])
			set_visible_characters(0)
			set_process_input(true)
			
func _on_Win():
	dialogue = ["YAY"]
	dialogue_index = 0
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	for member in get_tree().get_nodes_in_group("seedGroup"):
			member.set_position(member.seed_pos)
	emit_signal("showSprite")
	emit_signal("showBox")
	emit_signal("hideSprite2")
	emit_signal("hideSprite3")
	show()
	win = true
	

