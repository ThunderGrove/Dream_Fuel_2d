extends Area2D

var tile_size=60
var moveLock=true#used to lock player movment when GUI is showed.
var speed=4#determens camera movement.
var inputs={"ui_right":Vector2.RIGHT,"ui_left":Vector2.LEFT,"ui_up":Vector2.UP,"ui_down":Vector2.DOWN}
onready var tween=get_node("Tween")
#normaly you can access all child nodes with $childnodename but for somereason the var tween
#is null when _process call tween.is_active() when using $Tween but it works with get_node("Tween")
#Can see two possible reason for this.
#First possibility is a bug in the Linux version of Godot.
#Second possibility is the speed nodes gets loaded and using $Tween could be alot slower than get_node("Tween").
onready var ray=$RayCast2D


func _ready():
	#the two lines below makes a snapping rule so tween knows where to stop movment
	position=position.snapped(Vector2.ONE * tile_size)
	position+=Vector2.ONE*tile_size/2

func _process(delta):
	if !moveLock:
		if tween.is_active():
			return
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				move(dir)
	

func move(dir):
    ray.cast_to=inputs[dir]*tile_size#simulates tilemovement to detect collition with tiles in tilemaps with collition turn on
    ray.force_raycast_update()#only needed on first simulation, but recomended on each simulation when one raycast2d is used for multipel directions
    if !ray.is_colliding():
        move_tween(dir)

func move_tween(dir):
	#the two lines below prepares movment and start movment
	tween.interpolate_property(self, "position",position, position + inputs[dir] * tile_size,1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()