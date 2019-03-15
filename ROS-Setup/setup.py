from sys import argv
from std_msgs.msg import String
from sensor_msgs.msg import Image
from rospy import Subscriber, Publisher, init_node, spin
from time import sleep

class cameraControl():
	def __init__(self, identifier):
		#Setup
		self.id = identifier
		
		nodeName = str("Camera_"+str(self.id))
		print(nodeName)
		init_node(nodeName, anonymous=True)
		#Topic connections
		self.snapshot = Subscriber("/camera_group/snapshot", String, self.take_image)
		print("Subscribing to: /camera_group/snapshot")
		self.imagepublisher = Publisher(str("/camera_group/image_store/"), String, queue_size=2)
		print("Publishing on: /camera_group/image_store/")
	






	def take_image(self, data):
		if data.data == self.id: #if the packet is for this node
			self.imagepublisher.publish("__TAKE_PIC__")
			print("Snapshot taken!")





class serverControl:
	def __init__(self):
		#Setup
		#this requires the roscore
		init_node("ServerCore")

		self.image_requester = Publisher("/camera_group/snapshot", String, queue_size=2)
		print("Subscribing to: /camera_group/snapshot")
		
		self.snapshot = Subscriber("/camera_group/image_store", String, self.store_image)
		print("Subscribing to: /camera_group/image_store")
		
		self.robot_publisher = Publisher("/instructions_group/instructions", String, queue_size=2)
		print("Publishing to: /instructions_group/instructions")
		
		self.main()
		
		
		
	def imgRequest(self, name):
		self.image_requester.publish(String(name))
	
	
	def store_image(self, data):
		print("Image Recieved")
		
	
	def pub_instructions(self, instructions):
		publishing = String(instructions)
		print("Attempting to publish: " + publishing.data)
		self.robot_publisher.publish(publishing)
		
	
	def main(self):
		while True:
			self.imgRequest("c1")
			# { do calculation to find instruction set }
			self.pub_instructions("1-1A-lrffrllrlfffffffs")

			sleep(1)

			self.imgRequest("c2")
			# { do calculation to find instruction set }
			self.pub_instructions("1-1B-llrlrlrlllfffffffffs")

			sleep(1)

			self.imgRequest("c3")
			# { do calculation to find instruction set }
			self.pub_instructions("2-2A-lllllfffffffrrs")

			sleep(1)

class robotHandler:
	
	def __init__(self, identifier):
		self.id = identifier

		nodeName = str("RobotHandler_"+str(self.id))
		print(nodeName)
		init_node(nodeName, anonymous=True)

		#Topic connections
		self.a = Subscriber("/instructions_group/instructions/", String, self.forwardInstructions)

	def forwardInstructions(self, data):
		if data.data[0] == self.id:
			
			robotName = str("/handler_" + str(self.id) + "/robot_" + data.data[2:4])
			print("Publishing to: " + robotName)
			robotPublisher = Publisher(robotName, String, queue_size=2)

			robotPublisher.publish(String(data.data[2:]))
		
		


class robotControl:
	
	def __init__(self, identifier, host):
		self.id = identifier
		self.host = host

		nodeName = str("Robot_" + str(self.host) + "_" + str(self.id))		
		print(nodeName)
		init_node(nodeName, anonymous=True)
		
		#Topic connections
		topicName = str("handler_"+ self.id + "/robot_" + self.host)
		print("Subscribing to: " + topicName)
		self.b = Subscriber(topicName, String, self.excecuteMove)
		
	
	def excecuteMove(self, data):
		print(data)
		
		#extract command char list using "-" splitting
		
		#run functions associated with each command (switch like system)
		
			
		

#if roscore does not exists
	#create roscore

if len(argv) == 1:
	sc = serverControl()
elif argv[1] == "cam":
	cc = cameraControl(argv[2])
elif argv[1] == "han":
	rh = robotHandler(argv[2])
elif argv[1] == "rob":
	rc = robotControl(argv[2], argv[3])

	

spin()

#init_node(nodeName, anonymous=True) #anonymous=True adds the random numbers on the end




