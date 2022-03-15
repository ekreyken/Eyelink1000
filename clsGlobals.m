classdef clsGlobals
   %CLSGLOBALS Summary of this class goes here
   %   Contains all global variables
   
   properties
    %% global variables:
        %EL= clsTracker; % create eyelink tracker object
        Scr=ClsPTBScreen; % create psychtoolbox object
        %paths:
        InstructionPath;
        MotionAMPath;
        DataPath;
        
        scrnCenterPixHeight;
        scrnCenterPixWidth;
      %% trials and blocks configuration:
      % Experimental Trials:
        numBlocks = 4; 
        TotalNumTrialsPerBlock;
        
        numTrialsPerConditionPerBlock = 7; %7 of each per TrialType (cue x target locations); [16*7 = 112 per block; 448 total]
        numCatchTrialsPerConditionPerBlock=2; %3 of each per TrialType (4 cue locations); [2*4 = 8 per block; 48 total]
        %The above puts the experiment at just over 51 minutes (496 trials) if they don't respond on any trials
        numPracticeTrialsPerCondition=2; %2 of each per block
        numPracticeCatchTrialsPerCondition=1; %1 of each per block
        
        CueLocations = [1 2 3 4]; %1=top, 2=right, 3=bottom, 4=left (Clockwise from top)
        TargetLocations = [1 2 3 4]; %1=top, 2=right, 3=bottom, 4=left (Clockwise from top)
        % Cue and Target locations (starting points):
        %            1
        %         4  o  2
        %            3
        numPlaceholders = 4;
        
      %% Instructions:
        TargetMessage = 'What was the colour of the target box?' 
        TargetMessage2 = 'z = blue, x = green, n = purple, m = red'
    
      %% timing:
        InitialStimDuration = .256; %500; %ms - How long Default screen is on before Cue is presented
        CueDuration = .256; %250; %ms - Time Cue is on screen
        ISICueToFixation = .256; %250; %ms - Time between Cue and fixation stimulus
        FixationDuration = .200; %250; %ms - Time the return to fixation stimulus is presented
        ISIFixToAnimate = .300; %250; %ms - Time between Fixation presentation and target presentation
        RunAnimateBoxes = 1.500; %1500 ms - Time boxes move around the screen
        TargetDuration = .500; %500 ms - Time target remains on screen
        AnswerDuration = 2.000; %2000 ms - Time the participant gets to answer
        ITI = .500; %Intertrial interval
        BeepTime = .385; %350s - how long the error beep lasts

     %% Colour Codes:
        %
        AllowedKeys = ['Z' 'X' 'N' 'M']; %Z(cyan),X(green),N(Purple),M(Red)
        ColourAssign = [1 2 3 4]; %The number of colours that are allowed for trials; 1=C (Blue),2=G,3=P,4=R
        CyanKeyLower = 'z';
        CyanKeyUpper = 'Z';
        GreenKeyLower = 'x';
        GreenKeyUpper = 'X';
        PurpleKeyLower = 'n';
        PurpleKeyUpper = 'N';
        RedKeyLower = 'm';
        RedKeyUpper = 'M';
        
        %Used as placeholder colours:
        Cyan = [0 120 120]; % 35.7 lum %1 = Cyan (it's called blue)
        Green = [0 120 0]; % 33.4 lum %2 = Green
        Magenta = [200 0 200]; % 35.3 lum %3 = Magenta (it's called purple)
        Red = [255 0 0]; % 32.3 lum %4 = Red
        clrBlack = [0 0 0];
        clrWhite = [255 255 255];
        
        %Not used as placeholder colours
        Yellow = [255 255 0]; %
        Blue = [0 0 255]; %too dark, find another if increasing to 6 placeholders
       
       
    %% Box velocity
        Velocity = 4;
        
    %% Thickness of all lines
        LineThickness = 4; %
    
    %% Info needed for calculating visual angle for the placeholders, cues, and targets
        CMinPixHeight; %Number of pixels in a CM for height of monitor
        CMofVAHeight; %Visual angle * number of pixels in a centimeter: THIS ONLY WORKS IF THEY SIT ~54cm AWAY FROM THE SCREEN!

        CMinPixWidth; %Number of pixels in a CM for width of monitor
        CMofVAWidth; %Visual angle * number of pixels in a centimeter: THIS ONLY WORKS IF THEY SIT ~54cm AWAY FROM THE SCREEN!

    %% Ovals (cues):
        VAOvalSize = .8; %Visual angle of cue
        OvalSize % diameter of circle after using VAOvalSize to convert
        
        %Cue coordinates
        TopCue;
        RightCue;
        BottomCue;
        LeftCue;
        FixationCue;
        
     %% Filled Squares (targets)
        VARectTargetSize = .7; %Visual angle of target 
        TargetRectSize;% length of sides in pixels after using VARectTargetSize to convert
        
     %% Placeholders 
        VARectSize = 1.3; %All sides = square     
        RectSize; % length of sides in pixels after using VARectSize to convert
    
        %Locations: For Cross shape:
        VABOXDistFromCenter = 6.2; %Initial Visual Angle for boxes from central fixation
        
        %Square placeholder starting coordinates
        TopRect;
        RightRect;
        BottomRect;
        LeftRect;
        
        %Fixation Diamond coordinates
        VADIAMONDDistFromCenter = .4;
        DiaSize;
        XCoordsFixDiamond;
        YCoordsFixDiamond;
        DiaCoords;
        
        %Bounds of allowed bouncing
        VABounds = 20; %visual angle of large box
        PixBounds; %Length of large box in pixe3ls after using VABounds to convert
        
        xMinBounceSize;
        xMaxBounceSize;
        yMinBounceSize;
        yMaxBounceSize;
        FrameBounds;
   end
   
   methods
      function obj=clsGlobals()
         
            obj.MotionAMPath = [pwd,'\'];
            obj.InstructionPath= [obj.MotionAMPath,'Instructions','\'];    
            obj.DataPath = [obj.MotionAMPath,'Data','\'];   
            
            % Get monitor height and width
            set(0,'units','centimeters');
            MonitorDimensions = get(0,'screensize');
            obj.Scr.monitorWidth = MonitorDimensions(3);
            obj.Scr.monitorHeight = MonitorDimensions(4);
             
            obj.TotalNumTrialsPerBlock = obj.numTrialsPerConditionPerBlock*(length(obj.CueLocations)*length(obj.TargetLocations))+obj.numCatchTrialsPerConditionPerBlock*(length(obj.CueLocations));          
            % Locations for Cross shape
            obj.scrnCenterPixHeight= obj.Scr.WinHeight/2; %center of screen (height)
            obj.scrnCenterPixWidth= obj.Scr.WinWidth/2; %center of screen (width) 
            
            obj.CMinPixHeight = obj.Scr.WinHeight/obj.Scr.monitorHeight;
            obj.CMofVAHeight = obj.VABOXDistFromCenter*obj.CMinPixHeight;
            
            obj.CMinPixWidth = obj.Scr.WinWidth/obj.Scr.monitorWidth;
            obj.CMofVAWidth = obj.VABOXDistFromCenter*obj.CMinPixWidth;
            
            % In Brackets are positions of [left, top, right, bottom] of the rectangles: 
            obj.RectSize = obj.VARectSize * ((obj.CMinPixWidth+obj.CMinPixHeight)/2);
            obj.TopRect = [(obj.scrnCenterPixWidth - obj.RectSize/2) ((obj.scrnCenterPixHeight - obj.CMofVAHeight) - obj.RectSize/2) (obj.scrnCenterPixWidth + obj.RectSize/2) ((obj.scrnCenterPixHeight - obj.CMofVAHeight) + obj.RectSize/2)];
            obj.RightRect = [((obj.scrnCenterPixWidth + obj.CMofVAWidth) - obj.RectSize/2) (obj.scrnCenterPixHeight -  obj.RectSize/2) ((obj.scrnCenterPixWidth + obj.CMofVAWidth) + obj.RectSize/2) (obj.scrnCenterPixHeight + obj.RectSize/2)];
            obj.BottomRect = [(obj.scrnCenterPixWidth - obj.RectSize/2) ((obj.scrnCenterPixHeight + obj.CMofVAHeight) - obj.RectSize/2) (obj.scrnCenterPixWidth + obj.RectSize/2) ((obj.scrnCenterPixHeight + obj.CMofVAHeight) + obj.RectSize/2)];
            obj.LeftRect = [((obj.scrnCenterPixWidth - obj.CMofVAWidth) - obj.RectSize/2) (obj.scrnCenterPixHeight -  obj.RectSize/2) ((obj.scrnCenterPixWidth - obj.CMofVAWidth) + obj.RectSize/2) (obj.scrnCenterPixHeight + obj.RectSize/2)];
            
            % Cue positions:
            obj.OvalSize = obj.VAOvalSize * ((obj.CMinPixWidth+obj.CMinPixHeight)/2);
            obj.TopCue = [(obj.scrnCenterPixWidth - obj.OvalSize/2) ((obj.scrnCenterPixHeight - obj.CMofVAHeight) - obj.OvalSize/2) (obj.scrnCenterPixWidth + obj.OvalSize/2) ((obj.scrnCenterPixHeight - obj.CMofVAHeight) + obj.OvalSize/2)];
            obj.RightCue = [((obj.scrnCenterPixWidth + obj.CMofVAWidth) - obj.OvalSize/2) (obj.scrnCenterPixHeight -  obj.OvalSize/2) ((obj.scrnCenterPixWidth + obj.CMofVAWidth) + obj.OvalSize/2) (obj.scrnCenterPixHeight + obj.OvalSize/2)];
            obj.BottomCue = [(obj.scrnCenterPixWidth - obj.OvalSize/2) ((obj.scrnCenterPixHeight + obj.CMofVAHeight) - obj.OvalSize/2) (obj.scrnCenterPixWidth + obj.OvalSize/2) ((obj.scrnCenterPixHeight + obj.CMofVAHeight) + obj.OvalSize/2)];
            obj.LeftCue = [((obj.scrnCenterPixWidth - obj.CMofVAWidth) - obj.OvalSize/2) (obj.scrnCenterPixHeight -  obj.OvalSize/2) ((obj.scrnCenterPixWidth - obj.CMofVAWidth) + obj.OvalSize/2) (obj.scrnCenterPixHeight + obj.OvalSize/2)];
            obj.FixationCue = [(obj.scrnCenterPixWidth - obj.OvalSize/2) (obj.scrnCenterPixHeight -  obj.OvalSize/2) (obj.scrnCenterPixWidth + obj.OvalSize/2) (obj.scrnCenterPixHeight +  obj.OvalSize/2)];
            
            % Target positions
            obj.TargetRectSize = obj.VARectTargetSize * ((obj.CMinPixWidth+obj.CMinPixHeight)/2);
            
            % Fixation diamond:
            obj.DiaSize = obj.VADIAMONDDistFromCenter * ((obj.CMinPixWidth+obj.CMinPixHeight)/2);
            obj.XCoordsFixDiamond = [obj.scrnCenterPixWidth, (obj.scrnCenterPixWidth-(obj.DiaSize/2)), obj.scrnCenterPixWidth, (obj.scrnCenterPixWidth+(obj.DiaSize/2))]';
            obj.YCoordsFixDiamond = [(obj.scrnCenterPixHeight-(obj.DiaSize/2)), obj.scrnCenterPixHeight, (obj.scrnCenterPixHeight+(obj.DiaSize/2)), obj.scrnCenterPixHeight]';
            obj.DiaCoords = [obj.XCoordsFixDiamond obj.YCoordsFixDiamond];
            
            % Large boundary box
            obj.PixBounds = obj.VABounds *((obj.CMinPixWidth+obj.CMinPixHeight)/2);
            obj.xMinBounceSize = obj.scrnCenterPixWidth - obj.PixBounds/2;
            obj.xMaxBounceSize = obj.scrnCenterPixWidth + obj.PixBounds/2;
            obj.yMinBounceSize = obj.scrnCenterPixHeight - obj.PixBounds/2;
            obj.yMaxBounceSize = obj.scrnCenterPixHeight + obj.PixBounds/2;
            obj.FrameBounds = [obj.xMinBounceSize obj.yMinBounceSize obj.xMaxBounceSize obj.yMaxBounceSize];
         end
   end
   
end

