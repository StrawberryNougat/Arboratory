extends Control

export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path) #Acquires the Dropdown Node in the Scene
onready var seedData = ImportData.seed_data #Imports the Seed Data Database
onready var Water = get_tree().get_root().find_node("water", true, false) #Imports the water node from planting to here
var key = 1 #Creates the key variable and sets it to 1

func _ready():
	load_tree() # Runs tree function for start
	dropdown.connect("item_selected", self, "on_item_selected") #Makes the tree change on dropdown editing
	add_items() #Adds the options to the dropdown menu on ready.
	disable_items() #Calls the disable function
	dropdown.set_item_text(0, "Choose your Tree") #Changes the Template Text to something else
	Water.connect("unlocked",self,"unlock") #Connects the unlocked signal from water to the unlock function

# Function to add items into the dropdown menu
func add_items():
	for lock in seedData:
		dropdown.add_item(seedData[str(lock)]["treeName"])

#Disables all tree options
func disable_items():
	for item in seedData:
		dropdown.set_item_disabled(int(item), true)

#Unlocks the tree once it is planted
func unlock(id):
	print ("Signal Recieved")
	dropdown.set_item_disabled(int(id), false)

#Changes the Dex to represent the item selected
func on_item_selected(id):
	key = id
	if key != 0:
		load_tree()

#Closes the Dex and unpauses the main game
func _on_exit_button_pressed():
	self.visible = false
	get_tree().paused = false

#General Back Button function
func _on_back_button_pressed():
	if(key == 1):
		pass
	else:
		key -= 1
	#Tells the back button if the next id is disabled or not and to skip if is
	for n in range(key,seedData.size()):
		if !(key <= 0): 
			if dropdown.is_item_disabled(key):
				key -= 1
			else:
				dropdown.select(key)
				load_tree()
				return

#General Next Button function
func _on_next_button_pressed():
	if(key == 4):
		pass
	else:
		key += 1
	#Tells the next button if the next id is disabled or not and to skip if is
	for n in range(key,seedData.size()):
		if dropdown.is_item_disabled(key):
			key += 1
		else:
			dropdown.select(key)
			load_tree()
			return

#Generic loading tree function
func load_tree():
	$tree_id.text = str(key)
	$Tree_Art.texture = load(seedData[str(key)]["sapplingImage"])
	$tree_name.text = seedData[str(key)]["treeName"]
	$tree_description.text = seedData[str(key)]["Description"]
	$tree_properties.text = "Coming Soon"