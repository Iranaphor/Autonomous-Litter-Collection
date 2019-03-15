import rospy
from sys import argv
from rospy import Subscriber, Publisher
from std_msgs.msg import String
from sensor_msgs.msg import Image


class robotHandler:
	
	def __init__(self, identifier):
		self.id = identifier

		nodeName = str("RobotHandler_"+str(self.id))
		print(nodeName)
		rospy.init_node(nodeName, anonymous=True)

		#Topic connections
		self.a = Subscriber("/instructions_group/instructions/", String, self.forwardInstructions)

	def forwardInstructions(self, data):
		if data.data[0] == self.id:
			
			robotName = str("/host_" + str(self.id) + "/robot_" + data.data[2:4])
			print("Publishing to: " + robotName)
			robotPublisher = Publisher(robotName, String, queue_size=2)

			robotPublisher.publish(String(data.data[2:]))
		
		


rh = robotHandler(argv[1])


rospy.spin()
