import Leap, sys, thread, time
from Leap  import CircleGesture, KeyTapGesture, ScreenTapGesture, SwipeGesture

class LeapMotionListener(Leap.Listener):
	finger_names = ['Thumb', 'Index', 'Middle', 'Ring', 'Pinky']
	bone_name = ['Metacarpal', 'Proximal', 'Intermediate', 'Distal']
	state_names = ['STATE_INVALID', 'STATE_START', 'STATE_UPDATE', 'STATE_END']

	def on_init(self, controller):
		print("Initialized")

	def on_connect(self, controller):
		print("Motion Sensor Connected!")

		controller.enable_gesture(Leap.Gesture.TYPE_CIRCLE);
		controller.enable_gesture(Leap.Gesture.TYPE_KEY_TAP);
		controller.enable_gesture(Leap.Gesture.TYPE_SCREEN_TAP);
		controller.enable_gesture(Leap.Gesture.TYPE_SWIPE);

	def on_disconnect(self, controller):
		print("Motion Sensor Disconnected!")

	def on_exit(self, controller):
		print("Exited")

	def on_frame(self, controller):
		frame = controller.frame()

		# print("Frame ID: " + str(frame.id) \
		# 	  + " Timestamp: " + str(frame.timestamp) \
		# 	  + " # of Hands: " + str(len(frame.hands)) \
		# 	  + " # of finger: " + str(len(frame.fingers)) \
		# 	  + " # of tools: " + str(len(frame.tools)) \
		# 	  + " # of gestures: "+ str(len(frame.gestures())))
		for hand in frame.hands:
			# handType = "Left Hand" if hand.is_left else "Right Hand"

			# print(handType + " Hand ID: " + str(hand.id) + " Palm Position: " + str(hand.palm_position))

			# normal = hand.palm_normal
			# direction = hand.direction

			# print("Pitch: " + str(direction.pitch * Leap.RAD_TO_DEG) + " Roll: " + str(normal.roll * Leap.RAD_TO_DEG) + " Yaw: " + str(direction.yaw * Leap.RAD_TO_DEG))

			# arm = hand.arm
			# print("Arm Direction:  " + str(arm.direction) + " Wrist position: " + str(arm.wrist_position) + " Elbow Position" + str(arm.elbow_position))

			for finger in hand.fingers:
				if finger.type == 1:

					# print("Finger Type: " + self.finger_names[finger.type])
					# print("Type: " + self.finger_names[finger.type] + " ID: " + str(finger.id) + " Length (mm) " + str(finger.length) + " Width (mm): " + str(finger.width))
					print("Finger Position: x: " + str(finger.tip_position[0]) + " y: " + str(finger.tip_position[1]) + " z: " + str(finger.tip_position[2]))

def main():
	listener = LeapMotionListener()
	print("LML")
	controller = Leap.Controller()
	print("L.C")
	controller.add_listener(listener)

	print("Press enter to quit")

	try:
		sys.stdin.readline()
	except KeyboardInterrupt:
		pass
	finally:
		controller.remove_listener(listener)

if __name__ == "__main__":
	main()

