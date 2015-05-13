FLOW FEATURE EXTRACTION README

Build:	cmake CMakeLists.txt
		make

Usage:	./flow vids.txt

vids.txt is a whitespace/return separated list of videos to be processed. Videos should be placed in the root of the /data/ folder in the top level of the project directory. Videos should have the naming convention *.mp4, where * is a unique number to identify that video. vids.txt contains the list of * to be processed.

Example:
	data/
		1.mp4
		2.mp4
		3.mp4
		4.mp4
		8.mp4
		10.mp4

To process only videos 2, 4, and 10, vids.txt should contain:
2
4
10

A text file should accompany each video to be processed, containing the times of the segmented actions. For 2.mp4, a file called 2.txt:
7
12
28
45
50
76
103
123
135


Running ./flow vids.txt will generate features for each of the listed videos and place them in folders within the data/ directory, in the following format.

data/
	v2/
	v4/
	v8/
		f1/
		f2/
		f3/
