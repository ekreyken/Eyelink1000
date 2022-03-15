%%
clc 
clear
tic
%%

%Setup global vars
Globals = clsGlobals;

%Get participant num using Matlab created figure (Welcome.m, Welcome.fig)
WelcomeInstructions = 'Please input the Participant ID into the box below.';
Researcher = 'Researcher:';
ParID = 'Participant ID:';
ParticipantID=[];
Welcome;
movegui(Welcome, 'center' );
%Wait until Welcome is done
uiwait(Welcome);
if isempty(ParticipantID)
   return
end
clear ParID Researcher WelcomeInstructions; %clear unwanted vars

HideCursor; 

clear tmptrial b cl tl t ct 
%% init screen
numscreens=Screen('Screens'); %
if size(numscreens,2)>1 % more than one screen, display on primary (for testing at home with multiple monitors only)
   ScreenNumber=2; 
   Windowed=1; %
else  % just one screen, display on desktop
   ScreenNumber=0;
   Windowed=0; %0 = run full screen; 1 = run in a window : run as 0 always in experimental mode (only 1 monitor attached)
end
Globals.Scr=ClsPTBScreen;
SkipSyncTests=0;

Globals.Scr.init(ScreenNumber,SkipSyncTests,Windowed);
Globals.Scr.cls;

% % Setup Trials 
InitBlocksAndTrials

% Practice trials
%Display practice instructions: 
Globals.Scr.displaypic(imread([Globals.InstructionPath,'PracticeInstructions.bmp']),-1);
WaitKeyTimeOut(180,' ');
PracticeBlock = PracticeBlock.runMotionTrials; 

%% experimental trials
for b=1:length(Blocks)
       %Take a break between blocks
    if b>1
        Globals.Scr.displaypic(imread([Globals.MotionAMPath,'TakeBreak.bmp']),-1);
        WaitKeyTimeOut(55,' ') 
        Globals.Scr.displaypic(imread([Globals.InstructionPath,'5.bmp']),1000); 
        Globals.Scr.displaypic(imread([Globals.InstructionPath,'4.bmp']),1000);
        Globals.Scr.displaypic(imread([Globals.InstructionPath,'3.bmp']),1000);
        Globals.Scr.displaypic(imread([Globals.InstructionPath,'2.bmp']),1000);
        Globals.Scr.displaypic(imread([Globals.InstructionPath,'1.bmp']),1000);
    end
    Globals.Scr.displaypic(imread([Globals.InstructionPath,'Instructions.bmp']),-1)
    WaitKeyTimeOut(180,' ');
    Blocks(b)=Blocks(b).runMotionTrials;
end

ShowCursor;
TrialFileName = strcat(datestr(date), ' - ', ParticipantID, ' - ', 'Globals&Blocks');
save([Globals.DataPath,TrialFileName]);

Globals.Scr.close

%% Initialize Demographics questions & gui
clearvars -except ParticipantID Globals
txtDemoInstructions = 'Please answer all of the following questions:';
a = '1. How old are you?';
b = '2. Are you male or female? (M/F)';
c = '3. Are you right or left handed? (R/L)';
d = '4. Do you wear prescriptive lenses? (Y/N)';
e = '5. If yes, did you wear them today? (Y/N)';
f = '6. What did you think the study was about?';
Demographics;
uiwait(Demographics);

DemoFileName=strcat(datestr(date), '-', ParticipantID, '-', 'Demographics');
clear txtDemoInstructions
save([Globals.DataPath, DemoFileName]);


%% debrief
filename = 'Debrief.txt';
Debrief = importdata([Globals.MotionAMPath filename]);
waitfor(msgbox(Debrief));

%% close and exit
toc
clear all;
exit