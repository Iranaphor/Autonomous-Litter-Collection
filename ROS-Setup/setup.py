import rospy
from std_msgs.msg import String()
from sensor_msgs.msg import Image()

class cameraControl:
	def init(self)
		rospy.init_node("Camera")
		self.imagepublisher = Publisher("/camera_group/image_store", Image, queue_size=2)
		self.snapshot = Subscriber("/camera_group/snapshot", Bool, self.take_image)
	
	def take_image(self, data):
		self.imagepublisher("__TAKE_PIC__")




class serverControl:
	def init(self)
		rospy.init_node("Server")
	
	
	
	
%%
import rospy
rospy.init_node(Server)


%%
import rospy
rospy.init_node(Robot Handler)


%%
import rospy
rospy.init_node(Robot)

