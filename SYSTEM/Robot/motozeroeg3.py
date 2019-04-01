import RPi.GPIO as GPIO
from time import sleep
from sys import argv

# Set the GPIO mode
GPIO.setmode(GPIO.BCM)

############################################################################


# Define GPIO pins
Motor1A = 24
Motor1B = 27
Motor1Enable = 5

Motor2A = 6
Motor2B = 22
Motor2Enable = 17 

Motor3A = 23
Motor3B = 16
Motor3Enable = 12 

Motor4A = 13
Motor4B = 18
Motor4Enable = 25






class motor:
    def __init__(self, A, B, En):
        self.a = A
        self.b = B
        self.en = En
        
    def setup(self):  
        a = GPIO.setup(self.a, GPIO.OUT)
        b = GPIO.setup(self.b, GPIO.OUT)
        en = GPIO.setup(self.en, GPIO.OUT)

########################################################################################################################

def stopmove(motor1, motor2):
    GPIO.output(motor1.en,GPIO.LOW) # GPIO high to enable this motor
    GPIO.output(motor2.en,GPIO.LOW) # GPIO high to enable this motor



def leftturn(delay, motor1, motor2):
    #print("left")
    
    # Turn motor 1 forward
    GPIO.output(motor1.a, GPIO.LOW) # GPIO high to send power to the + terminal
    GPIO.output(motor1.b, GPIO.HIGH) # GPIO low to ground the - terminal
    GPIO.output(motor1.en, GPIO.HIGH) # GPIO high to enable this motor

    # Turn motor 2 forward
    GPIO.output(motor2.a, GPIO.HIGH) # GPIO high to send power to the + terminal
    GPIO.output(motor2.b, GPIO.LOW) # GPIO low to ground the - terminal
    GPIO.output(motor2.en, GPIO.HIGH) # GPIO high to enable this motor

    sleep(delay)

def rightturn(delay, motor1, motor2):
    #print("right")
    
    # Turn motor 1 forward
    GPIO.output(motor1.a, GPIO.HIGH) # GPIO high to send power to the + terminal
    GPIO.output(motor1.b, GPIO.LOW) # GPIO low to ground the - terminal
    GPIO.output(motor1.en, GPIO.HIGH) # GPIO high to enable this motor

    # Turn motor 2 forward
    GPIO.output(motor2.a, GPIO.LOW) # GPIO high to send power to the + terminal
    GPIO.output(motor2.b, GPIO.HIGH) # GPIO low to ground the - terminal
    GPIO.output(motor2.en, GPIO.HIGH) # GPIO high to enable this motor

    sleep(delay)

def forward(delay, motor1, motor2):
    #print("forward")
    
    # Turn motor 1 forward
    GPIO.output(motor1.a, GPIO.HIGH) # GPIO high to send power to the + terminal
    GPIO.output(motor1.b, GPIO.LOW) # GPIO low to ground the - terminal
    GPIO.output(motor1.en, GPIO.HIGH) # GPIO high to enable this motor

    # Turn motor 2 forward
    GPIO.output(motor2.a, GPIO.HIGH) # GPIO high to send power to the + terminal
    GPIO.output(motor2.b, GPIO.LOW) # GPIO low to ground the - terminal
    GPIO.output(motor2.en, GPIO.HIGH) # GPIO high to enable this motor

    sleep(delay)


def backward(delay, motor1, motor2):
    #print("backward")
    
    # Turn motor 1 forward
    GPIO.output(motor1.a, GPIO.LOW) # GPIO high to send power to the + terminal
    GPIO.output(motor1.b, GPIO.HIGH) # GPIO low to ground the - terminal
    GPIO.output(motor1.en, GPIO.HIGH) # GPIO high to enable this motor

    # Turn motor 2 forward
    GPIO.output(motor2.a, GPIO.LOW) # GPIO high to send power to the + terminal
    GPIO.output(motor2.b, GPIO.HIGH) # GPIO low to ground the - terminal
    GPIO.output(motor2.en, GPIO.HIGH) # GPIO high to enable this motor

    sleep(delay)


def move(mtype, delay, motor1, motor2):
    print(mtype[0] + "|" + str(delay))
    
    if mtype[0] == "l":
        leftturn(delay, motor1, motor2)
    elif mtype[0] == "r":
        rightturn(delay, motor1, motor2)
    elif mtype[0] == "f":
        forward(delay, motor1, motor2)
    elif mtype[0] == "b":
        backward(delay, motor1, motor2)
    stopmove(motor1, motor2)
    sleep(1)
    
    
########################################################################################################################
    
#Setup motors
m1 = motor(24, 27, 5); m1.setup()
m2 = motor(13, 18, 25); m2.setup()


#Send commands
command = argv[1]

for i in range(len(command)):
	if(i%2==0):
		move(command[i], int(command[i+1]), m1, m2)


# Always end this script by cleaning the GPIO
GPIO.cleanup() 
