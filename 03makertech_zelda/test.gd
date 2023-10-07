extends Node  # Replace 'Node' with the appropriate base class for your script
#
# Define a function to check nodes on a specific layer
func checkNodesOnLayer(layer_name):
	var layer = get_tree().get_root().get_node_or_null(layer_name)

	# Check if the layer exists
	if layer != null:
		# Iterate through all nodes on the layer
		for child in layer.get_children():
			print(child.get_name())  # Output the name of each node
	else:
		print("Layer does not exist:", layer_name)

# 检查层是否存在
func checkLayerExists(layer_name):
	var layer_bit = get_collision_layer_value(layer_name)
	
	if layer_bit != -1:
		print("Layer exists:", layer_name)
	else:
		print("Layer does not exist:", layer_name)



func _ready():
	checkNodesOnLayer("enemy")
	# 在你的代码中调用该函数
	checkLayerExists("enemy")  # 替换为你要检查的层的名称

