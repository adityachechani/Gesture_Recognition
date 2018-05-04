# Gesture_Recognition
### Shape Recognition using Leap Motion Controller

#### This document describes the various modules created in the project for virtual shape recognition using Leap Motion and also details the procedure to run it.

leap_motion_data.py : Python file for raw data acquisition of index finger 
		      coordinates of either hand using the leap motion controller.
		      Coordinates saved in a json file.
		      To run it, Leap dependencies(files in the folder "Leap_dependencies")
		      have to be put in the same folder as this python file and the 
		      location has to be added as PATH variable.

lsf.m : Matlab code to extract the 3D coordinates from the json file. Finds the best fit 
	plane using least square fitting and rotates the 3D points on a plane parallel 
	to the XY plane. Returns the new x and y coordinates.

AxelRot.m : Used by lsf.m to calculate the rotation matrix for 3D point transformation.

leap_knn_150.m : K-Nearest neighbor algorithm for shape classification

leap_svm_ova_150.m : Support vector machine implementation using one vs all method
		     for shape classification

leap_svm_ovo_150.m : Support vector machine implementation using one vs one method
		     for shape classification.

Folders: 
Leap_dependencies : Leap motion SDK dependencies and binaries
Circle, Triangle, Rectangle : Sample .json files consisting of 3D data points of virtual shapes

Procedure : Once acquired enough data for training and testing in the corressponding folders of the shapes,
directly run one of the classification algorithms for output.
