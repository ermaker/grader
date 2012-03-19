from cs1robots import *

#You can change map by modifying "maze1.wld" to other map name
load_world("20080690.wld")

################### DO NOT TOUCH ##############################
hubo = Robot(avenue=10,street=1,orientation = 'N')
ami = Robot(color="yellow",orientation = 'N')
###############################################################



def hubo_go_up_and_check():
    while not hubo.on_beeper() and hubo.front_is_clear():
        hubo.move()

def hubo_turn():
    if not hubo.on_beeper():
        for i in range (2):        
            hubo.turn_left()
          
def hubo_go_down_and_find_window():
    if not hubo.on_beeper():        
        while not hubo.right_is_clear():
            hubo.move()
        for i in range (3):
            hubo.turn_left()
        hubo.move()

def hubo_come_back():
    if not hubo.on_beeper():
        hubo.turn_left()
        while hubo.front_is_clear():
            hubo.move()      
        for i in range (2):
            hubo.turn_left()     
    
def hubo_one_cycle():
    while not hubo.on_beeper():
        hubo_go_up_and_check()
        hubo_turn()
        hubo_go_down_and_find_window()
        hubo_come_back()        

def ami_go_up_and_check():
    while not ami.on_beeper() and ami.front_is_clear():
        ami.move()

def ami_turn():
    if not ami.on_beeper():
        for i in range (2):        
            ami.turn_left()
          
def ami_go_down_and_find_window():
    if not ami.on_beeper():        
        while not ami.right_is_clear():
            ami.move()
        for i in range (3):
            ami.turn_left()
        ami.move()

def ami_come_back():
    if not ami.on_beeper():
        ami.turn_left()
        while ami.front_is_clear():
            ami.move()      
        for i in range (2):
            ami.turn_left()     
   
def ami_one_cycle():
    while not ami.on_beeper():
        ami_go_up_and_check()
        ami_turn()
        ami_go_down_and_find_window()
        ami_come_back()        

def ami_whole_cycle():
    while ami.front_is_clear():
        ami.move()
    for i in range (2):
        ami.turn_left()  
    ami_one_cycle()

ami_whole_cycle()
hubo_one_cycle()
  

