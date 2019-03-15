import rospy
from sys import argv
from rospy import Subscriber, Publisher, init_node, spin
from std_msgs.msg import String
from sensor_msgs.msg import Image


class serverControl:
	def __init__(self):
		#Setup
		#this requires the roscore
		init_node("ServerCore", anonymous=True)

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
		print(publishing)
		self.robot_publisher.publish()
		
	
	def main(self):
		self.imgRequest("c1")
		self.pub_instructions("1-1A-lrffrllrlfffffffs")


		
		




# Run "roscore" to start the setup
sc = serverControl()



spin()
