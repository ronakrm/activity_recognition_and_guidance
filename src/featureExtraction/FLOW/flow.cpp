#include "flow.h"

int num_actions = 8;
int show_track = 0;
int fps = 20;
int trajectory_length = fps/4;


string inttostring(int num) {
	string result;          // string which will contain the result
	ostringstream convert;   // stream used for the conversion
	convert << num;      // insert the textual representation of 'Number' in the characters in the stream
	result = convert.str(); // set 'Result' to the contents of the stream
	return result;
}

void outputOpticalFlow(string outdir, string vidname, string segname) {
		
	ifstream segments;
	segments.open(segname.c_str());

	int start_frame;
	segments >> start_frame;
	start_frame *= fps;
	if (start_frame == 0) {
		start_frame = 1;
	}

	int end_frame;
	segments >> end_frame;
	end_frame *= fps;

	VideoCapture capture;
	capture.open(vidname.c_str());

	if(!capture.isOpened()) {
		fprintf(stderr, "Could not initialize capturing..\n");
		return;
	}
	
	int frame_num = 1;
	Mat image, prev_grey, grey;
	vector<Point2f> features_prev, features_next;

	vector<uchar> status;
	vector<float> err;
	vector<Point2f> flow;

	int action = 1;
	string makedircmd = "mkdir " + outdir + inttostring(action);
	system(makedircmd.c_str());
	int file_num = 1;

	cerr << "\t" + vidname << ", starting action: " << action << " in dir " << outdir << action << endl;

	while (frame_num <= end_frame) {
		//cout << frame_num << endl;
		// move to next action segment
		if (frame_num == end_frame) {
			if (segments.eof()) {
				break;
			}
			action++;
			cerr << "\t" + vidname << ", starting action: " << action << " in dir " << outdir << action << endl;
			string makedircmd = "mkdir " + outdir + inttostring(action);
			system(makedircmd.c_str());
			file_num = 1;
			start_frame = end_frame;
			segments >> end_frame;
			end_frame *= fps;
			continue;
		}

		Mat aframe;
		capture >> aframe;
		Mat frame = aframe(Rect(0,0,1280,480));

		if(frame_num == start_frame) {
			image.create(frame.size(), CV_8UC3);
			grey.create(frame.size(), CV_8UC1);
			prev_grey.create(frame.size(), CV_8UC1);

			frame.copyTo(image);
			cvtColor(image, prev_grey, CV_BGR2GRAY);
			
			goodFeaturesToTrack(prev_grey, features_prev, max_corners, quality, min_distance);
			cornerSubPix(prev_grey, features_prev, subPixWinSize, Size(-1,-1), criteria);

			cerr << "\t\tfirst frame of action " << action << endl;
			frame_num++;
			continue;
		}



		// do nothing for dead time before start of first action
		// do nothing for middle frames
		if ((frame_num) % trajectory_length != 0
					|| frame_num < start_frame) {
			if(frame.empty())
				break;		
			//cout << "skipping frame " << frame_num << endl;
			frame_num++;
			continue;
		}

		frame.copyTo(image);
		cvtColor(image, grey, CV_BGR2GRAY);

		calcOpticalFlowPyrLK(prev_grey, grey, features_prev, flow, status, err, windSize, maxLevel, criteria, flags, minEigThreshold);			
		
       	size_t i;
        for( i = 0; i < flow.size(); i++ )
        {
            circle( image, flow[i], 3, Scalar(0,255,0), -1, 8);
        }		

		if( show_track == 1 ) {
			imshow( "DenseTrack", image);
			char c = cvWaitKey(3);
			if((char)c == 27) break;
		}

		cerr << "\t\tWriting flow features " << file_num << endl;

		string fnum = inttostring(file_num);
		string offilename = outdir + inttostring(action) + "/f" + fnum + ".csv";
		ofstream ofout;
		ofout.open(offilename.c_str());

        for(int i = 0; i < status.size(); i++ )
        {
        	if (status[i] == 1) {
        		ofout << flow[i].x-features_prev[i].x << "," << flow[i].y-features_prev[i].y << endl;
        	}
        }
		
        ofout.close();
        file_num++;

		goodFeaturesToTrack(grey, features_prev, max_corners, quality, min_distance);
		cornerSubPix(grey, features_prev, subPixWinSize, Size(-1,-1), criteria);
		grey.copyTo(prev_grey);
		frame_num++;
	}

	if( show_track == 1 )
		destroyWindow("DenseTrack");

	segments.close();
}

int main(int argc, char** argv)
{	

	string prefixfolder = "../../../data/";
	// Half a second if fps = 20

	char* vids_to_process = argv[1];
	ifstream vids;
	vids.open(vids_to_process);

	if (vids.is_open()) {
		while (!vids.eof()) {
			int vidnum;
			vids >> vidnum;
			string vidname = prefixfolder + inttostring(vidnum) + ".mp4";
			string segname = prefixfolder + inttostring(vidnum) + ".txt";
			string outdir = prefixfolder + "v" + inttostring(vidnum) + "/f";

			string makedircmd = "mkdir " + prefixfolder + "v" + inttostring(vidnum);
			system(makedircmd.c_str());

			cerr << "Beginning Flow Calculation and Output for Video " << vidnum << endl;
			outputOpticalFlow(outdir, vidname, segname);
		}
	}

	return 0;
}