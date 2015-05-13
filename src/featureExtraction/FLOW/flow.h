#ifndef FLOW_H_
#define FLOW_H_

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <opencv/cxcore.h>
#include <ctype.h>
#include <unistd.h>
#include <algorithm>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <fstream>
#include <iostream>
#include <vector>
#include <list>
#include <string>

using namespace cv;
using namespace std;

// hyperparameters for this specific project
int num_actions = 8;
int show_track = 0;
int fps = 20;
int trajectory_length = fps/4;

// parameters for tracking
double quality = 0.001;
int min_distance = 10;
int max_corners = 500;

Size windSize = Size(21,21);
Size subPixWinSize = Size(10, 10);
int maxLevel = 3;
TermCriteria criteria = TermCriteria(CV_TERMCRIT_ITER | CV_TERMCRIT_ITER, 20, 0.3);
int flags = 0;
double minEigThreshold = 0.0001;

#endif /*FLOW_H_*/
