# Eyelink1000MATLAB
Matlab project code using the Eyelink 1000 (1000htz) to collect eye tracker data

This project was designed to run an experiment that determined whether reaction times differed significantly (statistically) between a target presented in the same location, one of two adjacent locations, or opposite location to a cue. This presents with 16 "valid" trial combinations, plus another 4 "invalid" trial combinations in which a cue is present but a target is not.

Upon beginning the program, a participant would enter their participant ID and then read instructions relating to their experimental performance.
There are two versions of this experiment:
Version 1: Participants are required to hold their eyes on a central fixation diamond throughout the experimental trials.
Version 2: Participants are required to "follow" objects with their eyes as they appear and disapear on screen throughout the experimental trials.

Each trial shows 4 square placeholders (equidistant from center) around a diamond fixation point. These and all objects (cues, target) were created within Matlab using PsychToolBox (http://psychtoolbox.org/) (see the bottom of clsGlobals and ClsPTBScreen for construction).

Each experimental block (blocks of trials presented to a participant in one set, separated by a short break) is preceeded by instruction text.

Each trial is constructed within initializeBlocksAndTrials.m. Each relative position of Cue and Target is identified and created (including invalid trials), then multiplied by the number of required trials and blocks (varies per experiment). The trial order for each block is then randomized.

Each trial begins with the presentation of the 4 placeholders and central diamond. A fixed radius circle apears in one of the placeholders. After a fixed time, it is removed from the display. A fixed radius circle then appears on top of the central diamond, and disapears after a fixed time. Finally, either a square target appears in one of the placeholders and requires a response from the participant (else an error tone will sound after 1000ms and the program will move to the next trial), or nothing appears and requires the participant to withhold their response (else an error tone will sound after 1000ms and the program will move to the next trial).

Trials are recorded for experimental display, accuracy, participant timing, and eye position throughout the trial and exported as .mat files for later analysis.

Participant demographics are collected following the experiment via Matlab-created form and exported as .mat for later analysis.

Eye tracker data is saved as .edf files (note: eye tracker collection code will crash if you don't have an eyetracker attached and forget to set 'dummy tracker' properly). These files are converted to .asc via a roprietary conversion program supplied by sr-research (https://www.sr-research.com), makers of the Eyelink 1000. These .asc files are then converted to .mat files using a combination of Matlab-created import functions and custom code.

Analysis for this project includes:
a) Accurately connecting eye tracker trial information with reaction time trial information
b) Identifying valid and invalid eye data (i.e. blinks, presence/absence of eye movements -> experimental version dependent)
c) Identifying valid and invalid reaction time data (i.e. responding on invalid trials, failure to respond on valid trials)
d) Identifying the proportion of valid and invalid trials per participant and determining each participants' contribution to the final results
e) Computing reaction time medians, averages, and variances for each of 16 possible trial combinations.
f)
