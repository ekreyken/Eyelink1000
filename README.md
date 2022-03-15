# Moving Targets Code

To run:
1. Install Matlab (v2019a or up)
2. Install Psychtoolbox (https://psychtoolbox.org/)
3. Download all GitHub files to a directory called MotionTrackingAM (.../MotionTrackingAM)
4. Unzip the subfolder in MotionTrackingAM called Data and keep it in the MotionTrackingAM directory (.../MotionTrackingAM/Data)
5. Make sure you have a subfolder (downloaded from GitHub) called Instructions (.../MotionTracking/Instructions)
6. Open 'main.m' in Matlab.
7. If you have multiple monitors, the program will run in Windowed (debugging) mode (1920x1080 window, off-center). It will run and collect data but not accurately match the screen refresh rate with desired timing.
8. Press Run.
9. Enter 99 as a value for Participant ID (or any number between 1-200)
10. Please read the instructions onscreen before proceeding (also found in Instructions folder...).

This Matlab project code is designed to move 4 coloured (equiluminus on experimental display) placeholdors (empty boxes) within a central location on-screen.

This project was designed to run an experiment that determined whether reaction times differed significantly (statistically) between a target presented in the same location, one of two adjacent locations, or opposite location to a cue. This presents with 16 "valid" trial combinations, plus another 4 "invalid" trial combinations in which a cue is present but a target is not.

Upon beginning the program, a participant would enter their participant ID and then read instructions relating to their experimental performance.

Each experimental block (blocks of trials presented to a participant in one set, separated by a short break) is preceeded by instruction text.

Each trial shows 4 coloured square placeholders (equidistant from center) around a diamond fixation point. These and all objects (cues, target) were created within Matlab using PsychToolBox (http://psychtoolbox.org/) 


Each trial is constructed within initializeBlocksAndTrials.m. Each relative position of Cue and Target is identified and created (including invalid trials), then multiplied by the number of required trials and blocks (varies per experiment). The trial order for each block is then randomized.

Each trial begins with the presentation of the 4 placeholders and central diamond. A fixed radius circle apears in one of the placeholders. After a fixed time, it is removed from the display. 
The boxes then turn white, and are randomly flung around the screen. There are several versions of this experiment (fast movement, slow movement, random movement, non-random movement, etc.), but if you get this working on your computer it's hilarious.

Finally, either a square target appears in one of the placeholders and requires a response from the participant (else an error tone will sound after 1500ms and the program will move to the next trial), or nothing appears and requires the participant to withhold their response (else an error tone will sound after 1000ms and the program will move to the next trial). Participants will be prompted 

Trials are recorded for experimental display, accuracy, and participant timing throughout the trial and exported as .mat files for later analysis.

Participant demographics are collected following the experiment via Matlab-created form and exported as .mat for later analysis.

Programming Data Reduction for this project includes:
a) Identifying valid and invalid reaction time data (i.e. responding on invalid trials, failure to respond on valid trials)
b) Identifying the proportion of valid and invalid trials per participant and determining each participants' contribution to the final results
c) Computing reaction time medians, averages, and variances for each of 16 possible trial combinations.
