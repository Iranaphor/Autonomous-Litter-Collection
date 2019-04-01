import rospy
from std_msgs.msg import String
import os

class robot:
	def __init__(self):
		print("setup begun")
		rospy.init_node('robot1A', anonymous = False)
		rospy.Subscriber('/instructions/robot1A', String, self.msgIn, queue_size=1)
		print("setup complete")
		
	
	def msgIn(self, data):
		print(data.data)
		os.system('python motozeroeg3.py '+ data.data)
 
		
		
		
robot()
rospy.spin()
