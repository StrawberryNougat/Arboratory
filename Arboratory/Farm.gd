extends TileMap



signal plot_clicked
signal plant
signal new_farm
signal tree_removed

var tile_size = get_cell_size()
var farm_size = Vector2(7,7)
var farm = []
var spot
var remove_tree
var planting_ready
var clearing_time

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(farm_size.x):
		farm.append([])
		for y in range(farm_size.y):
			farm[x].append(false)
	planting_ready = false
	remove_tree = false
	clearing_time = false

#user is ready to plant a tree
func _ready_to_plant():
	planting_ready = true
	
#clears all farm plots
func _clear_plots():
	for x in range(farm_size.x):
		for y in range(farm_size.y):
			farm[x][y] = false
	get_tree().call_group("trees","queue_free")
	emit_signal("new_farm","New Farm")

#clears single plot
func _clear_single_plot():
	remove_tree = true

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#handles mouse-click
func _input(event):
	if Input.is_action_pressed("ui_click"):
		
		#checks if you clicked in the grid
		if event.position.x <896:
				
			#checks your ready to alter the farm
			if planting_ready == true:
				var plot_x = int((event.position.x)/(64*2))
				var plot_y = int((event.position.y)/(64*2))
				var tree_placement_x = ((plot_x+1)*64)+plot_x*64
				var tree_placement_y = (plot_y-32)+plot_y*128
				
				#checks if you want to clear
				if clearing_time == true:
					emit_signal("plant",tree_placement_x,tree_placement_y,plot_x,plot_y)
				
					if remove_tree == true:
						#remove single tree
						farm[plot_x][plot_y] = false
						emit_signal("tree_removed","Tree Removed")
						remove_tree = false
						
				elif farm[plot_x][plot_y] == false:
					#plant a new tree
					spot = "Tree planted in plot: " + str(plot_x) + "," + str(plot_y)
					farm[plot_x][plot_y] = true
					emit_signal("plot_clicked",spot)
					emit_signal("plant",tree_placement_x,tree_placement_y,plot_x,plot_y)
			
				else:
				#a tree is already in this plot
					spot = "A tree is already here"
					emit_signal("plot_clicked",spot)
		
		