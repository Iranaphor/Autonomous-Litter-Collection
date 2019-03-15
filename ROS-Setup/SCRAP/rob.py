import rospy
from sys import argv
from rospy import Subscriber, Publisher
from std_msgs.msg import String
from sensor_msgs.msg import Image



class robotControl:
	
	def __init__(self, identifier, host):
		self.id = identifier
		self.host = host

		nodeName = str("Robot_" + str(self.host) + "_" + str(self.id))		
		print(nodeName)
		rospy.init_node(nodeName, anonymous=True)
		
		#Topic connections
		topicName = str("host_"+ self.id + "/robot_" + self.host)
		print("Subscribing to: " + topicName)
		self.b = Subscriber(topicName, String, self.excecuteMove)
		
	
	def excecuteMove(self, data):
		print(data)



rc = robotControl(argv[1], argv[2])


rospy.spin()
