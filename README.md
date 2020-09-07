# run_analysis
peer-graded project
The program included in the run_analysis.R file assumes the files are unpacked and that the root directory is the
acual working directory.

First, it loads the  dplyr library, widely used along the code.

Afterwards, it reads the labels for features. 

It then selects the indexes for the features of interest, that is, means and std.


Afterwards, it reads the activity labelsand assigns an adequate label for each column of the data frame just read.


It then read the testset, first by subject, then by activity and then for each of the measurements.

It does the same for  the trainset, first by subject, then by activity and then for each of the measurements.

It then binds both sets and extract the desired variables for each subject, activity.

Finally, it extracts the required summary data per subject and activity building a frame which contains the means for each measurement and labels them properly.

In the end, it writes a .txt file containing the aforementioned summary.  The name of the resulting file should be tidy_data.txt and it should  be written in 
the current directory.
