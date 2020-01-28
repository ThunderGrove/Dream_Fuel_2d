extends Area2D

var tile_size=60#needs to be same af tile_pixel_size*scale.
var rng=RandomNumberGenerator.new()#use to create random numbers.
var moveLock=true#used to lock player movment when GUI is showed.
var in_combat=false#used to detect if first frame after movment starts a battle.
var speed=3#determens camera movement.
var inputs={"ui_right":Vector2.RIGHT,"ui_left":Vector2.LEFT,"ui_up":Vector2.UP,"ui_down":Vector2.DOWN}
var map=[#list of tile ids that is not solid but can trigger random battles.
	0,
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12,
	13,
	14,
	15,
	16,
	17,
	18,
	19,
	20,
	21,
	22,
	23,
	24,
	25,
	26,
	27,
	28,
	29,
	30,
	31,
	32,
	33,
	34,
	35,
	36,
	37,
	38,
	39,
	40,
	41,
	42,
	43,
	44,
	45,
	46,
	47,
	48,
	49,
	50,
	51,
	52,
	53,
	54,
	55,
	56,
	57,
	58,
	59,
	60,
	61,
	62,
	63,
	64,
	65,
	66,
	67,
	68,
	69,
	70,
	71,
	72,
	73
]
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
		elif in_combat:
			moveLock=true
			$Combat.visible=true
		$animatedSprite.pause_mode=true
		$animatedSprite.frame=0
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				move(dir)
			elif Input.is_action_just_pressed("ui_accept"):
				moveLock=true
				get_node("GameMenu").visible=true

func move(dir):
	ray.cast_to=inputs[dir]*tile_size#simulates tilemovement to detect collition with tiles in tilemaps with collition turn on
	ray.force_raycast_update()#only needed on first simulation, but recomended on each simulation when one raycast2d is used for multipel directions
	if !ray.is_colliding():
		move_tween(dir)
	else:
		if map.find(ray.get_collider_shape())!=-1:
			rng.randomize()
			if rng.randf_range(0,25)>20:
				in_combat=true
			move_tween(dir)
		else:
			print(ray.get_collider_shape())

func move_tween(dir):
	#the two lines below prepares movment and start movment
	tween.interpolate_property(self, "position",position, position + inputs[dir] * tile_size,1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	if dir=="ui_down":
		$animatedSprite.play("default",false)
	elif dir=="ui_up":
		$animatedSprite.play("male_up",false)
	elif dir=="ui_left":
		$animatedSprite.play("male_left",false)
	elif dir=="ui_right":
		$animatedSprite.play("male_right",false)