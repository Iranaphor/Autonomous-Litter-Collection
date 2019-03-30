import rospy
from sys import argv
from rospy import Subscriber, Publisher
from std_msgs.msg import String
from sensor_msgs.msg import Image


class cameraControl():
	def __init__(self, identifier):
		#Setup
		self.id = identifier
		
		nodeName = str("Camera_"+str(self.id))
		print(nodeName)
		rospy.init_node(nodeName, anonymous=True)
		#Topic connections
		self.snapshot = Subscriber("/camera_group/snapshot", String, self.take_image)
		print("Subscribing to: /camera_group/snapshot")
		self.imagepublisher = Publisher(str("/camera_group/image_store/"), String, queue_size=2)
		print("Publishing on: /camera_group/image_store/")
	




	def take_image(self, data):
		if data.data == self.id: #id the name on the id is this one...
			self.imagepublisher.publish("__TAKE_PIC__")




cc1 = cameraControl(argv[1])
#cc2 = cameraControl("c2")


rospy.spin()









"""

	def init2(self, identifier):
		#Setup
		self.id = identifier
		
		nodeName = str("Camera_"+str(self.id))
		print(nodeName)
		rospy.init_node(nodeName, anonymous=True)

		#Topic connections
		topicName = str("/camera_group_"+ str(self.id) + "/snapshot/")
		print("Subscribing to: " + topicName)
		self.snapshot = Subscriber(topicName, UInt8, self.take_image)

		topicName = str("/camera_group_"+ str(self.id) + "/image_store/")
		print("Publishing on: " + topicName)
		self.imagepublisher = Publisher(topicName, Image, queue_size=2)


	

"""
