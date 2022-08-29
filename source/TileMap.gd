extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var t=0
var tt=0
var ttt=0
var f
var love=false
var maxrank=10
var turn=0
var breakup=-1
var trashchance=1.5
var backchance=1.5
var failure=false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	t=int(rand_range(0,16))
	while a[t]!=0: t=int(rand_range(0,16))
	a[t]=1
	t=int(rand_range(0,16))
	while a[t]!=0: t=int(rand_range(0,16))
	a[t]=1
	for i in range(len(a)):
		self.set_cell(int(floor(i/4))*3,(i%4)*3,a[i])


func isdead():
	var flag=false
	for i in range(4):
		for j in range(4):
			if (i*4+j+1 in range(16)) and a[i*4+j]==a[i*4+j+1]: flag=true
			if (i*4+j-1 in range(16)) and a[i*4+j]==a[i*4+j-1]: flag=true
			if ((i+1)*4+j in range(16)) and a[i*4+j]==a[(i+1)*4+j]: flag=true
			if ((i-1)*4+j in range(16)) and a[i*4+j]==a[(i-1)*4+j]: flag=true
	if a.find(0)!=-1: flag=true
	return not flag

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	f=false
	var toxy= Vector2.ZERO
	var newtexs=[$Spritenew1.texture,0,$Spritenew3.texture]
	
	
	if Input.is_action_just_pressed("down") and not failure:
		f=true
		for i in range(4):
			for j in range(3):
				if a[i*4+j+1]==0:
					for k in range(j+1):
						a[i*4+j+1-k]=a[i*4+j-k]
					a[i*4]=0
			for j in range(3):
				if a[i*4+3-j]==a[i*4+2-j] and a[i*4+3-j]!=0:
					if (a[i*4+3-j]==maxrank) or (a[i*4+3-j]==4):
						a[i*4+3-j]=0
					elif a[i*4+3-j]==7:
						t=rand_range(0,10)
						if t>10-backchance: a[i*4+3-j]=5
						else: a[i*4+3-j]+=1
					elif a[i*4+3-j]==3:
						t=rand_range(0,10)
						if t>trashchance: a[i*4+3-j]+=2
						else: a[i*4+3-j]+=1
					else:	a[i*4+3-j]+=1
					a[i*4+2-j]=0
			for j in range(3):
				if a[i*4+j+1]==0:
					for k in range(j+1):
						a[i*4+j+1-k]=a[i*4+j-k]
					a[i*4]=0
					
	if Input.is_action_just_pressed("right") and not failure:
		f=true
		for i in range(4):
			for j in range(3):
				if a[i+(j+1)*4]==0:
					for k in range(j+1):
						a[i+(j+1-k)*4]=a[i+(j-k)*4]
					a[i]=0
			for j in range(3):
				if a[i+(3-j)*4]==a[i+(2-j)*4] and a[i+(3-j)*4]!=0:
					if (a[i+(3-j)*4]==maxrank) or (a[i+(3-j)*4]==4):
						a[i+(3-j)*4]=0
					elif a[i+(3-j)*4]==7:
						t=rand_range(0,10)
						if t>10-backchance: a[i+(3-j)*4]=5
						else: a[i+(3-j)*4]+=1
					elif a[i+(3-j)*4]==3:
						t=rand_range(0,10)
						if t>trashchance: a[i+(3-j)*4]+=2
						else: a[i+(3-j)*4]+=1
					else:	a[i+(3-j)*4]+=1
					a[i+(2-j)*4]=0
			for j in range(3):
				if a[i+(j+1)*4]==0:
					for k in range(j+1):
						a[i+(j+1-k)*4]=a[i+(j-k)*4]
					a[i]=0
					
	if Input.is_action_just_pressed("left") and not failure:
		f=true
		for i in range(4):
			for j in range(3):
				if a[i+(2-j)*4]==0:
					for k in range(j+1):
						a[i+(k+2-j)*4]=a[i+(k+3-j)*4]
					a[i+12]=0
			for j in range(3):
				if a[i+j*4]==a[i+(j+1)*4] and a[i+j*4]!=0:
					if (a[i+j*4]==maxrank) or (a[i+j*4]==4):
						a[i+j*4]=0
					elif a[i+j*4]==7:
						t=rand_range(0,10)
						if t>10-backchance: a[i+j*4]=5
						else: a[i+j*4]+=1
					elif a[i+j*4]==3:
						t=rand_range(0,10)
						if t>trashchance: a[i+j*4]+=2
						else: a[i+j*4]+=1
					else:	a[i+j*4]+=1
					a[i+(j+1)*4]=0
			for j in range(3):
				if a[i+(2-j)*4]==0:
					for k in range(j+1):
						a[i+(k+2-j)*4]=a[i+(k+3-j)*4]
					a[i+12]=0
					
	if Input.is_action_just_pressed("up") and not failure:
		f=true
		for i in range(4):
			for j in range(3):
				if a[i*4+2-j]==0:
					for k in range(j+1):
						a[i*4+2-j+k]=a[i*4+2-j+k+1]
					a[i*4+3]=0
			for j in range(3):
				if a[i*4+j]==a[i*4+j+1] and a[i*4+j]!=0:
					if (a[i*4+j]==maxrank) or (a[i*4+j]==4):
						a[i*4+j]=0
					elif a[i*4+j]==7:
						t=rand_range(0,10)
						if t>10-backchance: a[i*4+j]=5
						else: a[i*4+j]+=1
					elif a[i*4+j]==3:
						t=rand_range(0,10)
						if t>trashchance: a[i*4+j]+=2
						else: a[i*4+j]+=1
					else:	a[i*4+j]+=1
					a[i*4+j+1]=0
			for j in range(3):
				if a[i*4+2-j]==0:
					for k in range(j+1):
						a[i*4+2-j+k]=a[i*4+2-j+k+1]
					a[i*4+3]=0
					
	if f:
		turn+=1
		var newlove=false
		
		for i in range(len(a)):
			if a[i]!=-1 and a[i]!=-2:
				self.set_cell(int(floor(i/4))*3,(i%4)*3,a[i])
			elif a[i]==-1:
				toxy.x=101+int(floor(i/4))*191
				toxy.y=101+(i%4)*191
				$Spriteheart.translate(toxy-$Spriteheart.position)
			else:
				toxy.x=101+int(floor(i/4))*191
				toxy.y=101+(i%4)*191
				$Spritebreak.translate(toxy-$Spritebreak.position)
				
				
		t=int(rand_range(0,16))
		while a[t]!=0: t=int(rand_range(0,16))
		if love: a[t]=3
		else: a[t]=1
		$Spritenew.texture=newtexs[a[t]-1]
		
		
		if not love:
			if breakup==-1:
				tt=rand_range(0,10)
				if tt>9.7:
					love=true
					a[t]=-1
					toxy.x=101+int(floor(t/4))*191
					toxy.y=101+(t%4)*191
					$Spriteheart.translate(toxy-$Spriteheart.position)
					$Spriteheart/AnimationPlayer.play("newsprite")
					newlove=true
		else:
			tt=rand_range(0,10)
			if tt>9.8:
				love=false
				ttt=a.find(-1)
				a[ttt]=-2
				breakup=turn
				toxy.x=-500
				$Spriteheart.translate(toxy-$Spriteheart.position)
				toxy.x=101+int(floor(ttt/4))*191
				toxy.y=101+(ttt%4)*191
				$Spritebreak.translate(toxy-$Spritebreak.position)
				$Spritebreak/AnimationPlayer.play("newsprite")
		
		if not newlove:
			toxy.x=101+int(floor(t/4))*191
			toxy.y=101+(t%4)*191
			$Spritenew.translate(toxy-$Spritenew.position)
			$Spritenew/AnimationPlayer.play("newsprite")


		if breakup!=-1 and turn-breakup<9:
			trashchance=7
			backchance=7
		elif breakup!=-1 and turn-breakup==9:
			trashchance=1.5
			backchance=1.5
			breakup=-1
			ttt=a.find(-2)
			a[ttt]=0
			$Spritebreak/AnimationPlayer.play("disappear")
			#toxy.x=-500
			#$Spritebreak.translate(toxy-$Spritebreak.position)

		$Label.text="%d weeks left to graduate" %[208-turn]
		if isdead() or turn==208:
			$Label.text="failed"
			failure=true
		


func _on_retry_pressed():
	$Label.text="Can you graduate in 4 years?"
	a=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	breakup=-1
	turn=0
	love=false
	failure=false	
	self.clear()
	var toxy=Vector2.ZERO
	toxy.x=-500
	$Spriteheart.translate(toxy-$Spriteheart.position)
	$Spritebreak.translate(toxy-$Spritebreak.position)
	$Spritenew.translate(toxy-$Spritenew.position)
	t=int(rand_range(0,16))
	while a[t]!=0: t=int(rand_range(0,16))
	a[t]=1
	t=int(rand_range(0,16))
	while a[t]!=0: t=int(rand_range(0,16))
	a[t]=1
	for i in range(len(a)):
		self.set_cell(int(floor(i/4))*3,(i%4)*3,a[i])
