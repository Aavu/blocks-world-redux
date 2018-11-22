# Blocks World Redux
The project I was working on under Prof. Sass from architectural department when I went to MIT during Fall 2014

Some of the technical challenges I overcame:
- Color distinction in RGB values for all the shapes.
- Shape distinction with self-correlation of areas.
- Make the robot understand the shape correctly in spite of perspective changes.
- To find the centroid of the shape.
- To find the vertices of the shapes if not elliptical in nature.
- Avoid discontinuous edges and holes.
- Moving the arm with PWM signals applied to the Servos synchronously with precision.
- Check for corrections after each step is completed through a feedback loop.
- Connecting to the robot controller to Kuka toolbox.
- Knowing the processor which is going to be used

The algorithm
1 Capture instance of the video (a snapshot).
2 Separate the color channels (If necessary).
3 Convert them to a binary image with the threshold set by the average of the brightest and the darkest point in the image.
4	Remove imperfections with black if in background or in white if in foreground.
5	Fill any holes if present.
6	Get the centroids, boundaries, perimeters and areas of each object in the image.
7	For each point in the boundary of an object, find the distance between that point and centroid of that object.
8	Find the minimum and maximum of these values.
9	Using this information, calculate the area of the object and compare it with the acquired area.
10	By correlation classify it to different shapes.
11	Label/Mark the centroids with its corresponding shapes.
12	Run KCT giving these values as the final positions.
13	The initial position is pre-defined as the robot takes object from a pile.
14	If copying, the final values are just the offset which is determined by the position of the center line from the left most frame of the sensor.
15	If mirroring, the final values are the result of subtracting these values from the right most frame of the sensor.
