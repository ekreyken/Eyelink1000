classdef ClsPTBScreen < handle
	%PTBSCREEN Summary of this class goes here
	%   Detailed explanation goes here
	properties
      SkipSyncTests=1; % default to be able to use on multimonitor computers
      ScreenNumber=1; % Main Screen
      BackColor=0;    % black
      MultiLineText;  % 19 line array to store the text that is to be centered on screen
      TextColour=[255,0,0];
      FontSize
      WinTop=50;
      WinLeft=50;
      WinWidth=1920;
      WinHeight=1080;
      WinPtr;
      Rect;
      RefreshRate;
      FlipInterval;
      %%Benq 24 screen-specific:
      monitorHeight % = 28.575; %cm
      monitorWidth %= 50.800;
      globs;
	end
	methods
              
		function init(obj,ScreenNo, SkipTests, Windowed)
			if exist('ScreenNo', 'var');
				obj.ScreenNumber=ScreenNo;
			else 
				obj.ScreenNumber=0;
			end;
			if exist('SkipTests', 'var');
				obj.SkipSyncTests=SkipTests;
			else
				obj.SkipSyncTests=0;
			end;

			% check for Opengl compatibility, abort otherwise:
			AssertOpenGL;
			% make startup screen black:  
			Screen('Preference', 'VisualDebugLevel', 1);
			Screen('Preference','SkipSyncTests',obj.SkipSyncTests);
			% open window:
			if exist('Windowed', 'var');
				if Windowed~=0;
				  [obj.WinPtr, obj.Rect]=Screen('OpenWindow',obj.ScreenNumber,obj.BackColor,[obj.WinLeft obj.WinTop obj.WinWidth obj.WinHeight]);
				else
				  [obj.WinPtr, obj.Rect]=Screen('OpenWindow',obj.ScreenNumber,obj.BackColor);
				end;
            else
				 [obj.WinPtr, obj.Rect]=Screen('OpenWindow',obj.ScreenNumber,obj.BackColor);
			end;
        
         %% Get refresh rate
			[ monitorFlipInterval nrValidSamples stddev ] =Screen('GetFlipInterval', obj.WinPtr, 25);
			obj.FlipInterval=monitorFlipInterval;
           Hz_measured = 1/monitorFlipInterval;            
			obj.RefreshRate=Hz_measured;
			
            % Make sure keyboard mapping is the same on all supported operating systems
			% Apple MacOS/X, MS-Windo ws and GNU/Linux:
			KbName('UnifyKeyNames');
         
             % Set priority:
             topPriorityLevel = MaxPriority(obj.WinPtr);
             Priority(topPriorityLevel);

			% Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
			% they are loaded and ready when we need them - without delays
			% in the wrong moment:
			KbCheck;
			WaitSecs(0.1);
			GetSecs;    
		end;
	  %%	
        function close(obj)
			Screen('CloseAll');
         Priority(0);
		end;
	  %%	
        function cls(obj)
			% draw a filled rectangle of backcolor on screen
			Screen('FillRect', obj.WinPtr,obj.BackColor );
			Screen('Flip', obj.WinPtr);
		end;
	  %%
        function displaypic(obj, picvar , duration, HiContrast)
			%% duration 0 will keep it on screen. duration >0 will keep onscreen for duration milliseconds; duration<0 will wait for keypress
			% make texture image out of image matrix
			tmppic=picvar;
			if exist('HiContrast', 'var');
				if HiContrast;
				  tmppic=imadjust(picvar);
				end
			end
			tex=Screen('MakeTexture', obj.WinPtr, tmppic);
			% Draw texture image to backbuffer. It will be automatically
			% centered in the middle of the display if you don't specify a
			% different destination:     
			Screen('DrawTexture', obj.WinPtr, tex);
			% Flip it onscreen
			[VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos]=Screen(obj.WinPtr,'Flip');
			if duration>0;
				WaitSecs(duration/1000);
				obj.cls; 
			elseif duration<0
            % just keep it on screen; the caller will deal with it:
% 			    KbWait;
% 				obj.cls
			end;
         Screen('Close',tex);
		end;   
	  %%
        function wait(obj, ms)
			WaitSecs(ms/1000);
		end;
	  %%	
      function displaytext(obj, Text, XY, Colour)
         if exist('Colour', 'var');
            obj.TextColour=Colour;
         else
            obj.TextColour = [255 255 255];
         end;
         if exist('XY', 'var');
            x=XY(1);y=XY(2);
            Screen('DrawText', obj.WinPtr, Text, x, y, obj.TextColor);
         else
            rect = OffsetRect(CenterRect(Screen('TextBounds', obj.WinPtr, Text), Screen('Rect', obj.WinPtr)), 0, 0);
            Screen('DrawText', obj.WinPtr, Text, rect(RectLeft), rect(RectTop), obj.TextColour, [], 0);
         end;
      Screen('Flip', obj.WinPtr);
      end;
      %%  
        function displaymultilinetext(obj,Text,Color)
			% todo!
		end;
      %%
        function [ output_args ] = displayimgstream(obj, images, times)
          % displays images for times durations
          % returns {rt,keypressed}
             fliptimes=[];
             fliptimes(1)=GetSecs+.005; % plus five milliseconds to allow for code execution
             for i=2:length(times)
                fliptimes(i)=fliptimes(i-1)+times(i-1);
             end
             %%
             for i=1:length(images)
                %Scr.displaypic(images{i},times(i),0)
                %TODO get event codes in here? if i=1 Globals.EL.eventCode = 1...
                tex=Screen('MakeTexture', obj.WinPtr, images{i});
                Screen('DrawTexture', obj.WinPtr, tex);
                Screen('DrawingFinished', obj.WinPtr);
                [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen('Flip', obj.WinPtr, fliptimes(i),0,0);
                %Waitsecs(times(i));
                Screen('Close',tex);
             end
             % wait for last one:
             output_args=WaitKeyTimeOut(times(length(images)),' ');
        end;
      
        %%
        function [ response, TopFinalLocation, RightFinalLocation, BottomFinalLocation, LeftFinalLocation, OverlapTop, OverlapRight, OverlapBottom, OverlapLeft] =displayMotion(obj, dummy, colour1, colour2, colour3, colour4,TrialCueLocation,TrialTargetLocation, MoveTRXY, MoveRRXY, MoveBRXY, MoveLRXY)
          % dummy is in the above because otherwise it asigns 'colour1' to be a ClsPTBScreen
           
          %Display Boundary Box:
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            Screen('Flip',obj.WinPtr);
            
           WaitSecs(obj.globs.ITI);
            
          % Display Rectangles: 
            %Screen(RectangleType,WinPtr,Colour,RectangleSizeAndLocation,LineThickness)
            %Prep screen
            Screen('FrameRect', obj.WinPtr, colour1, obj.globs.TopRect, obj.globs.LineThickness); % 
            Screen('FrameRect', obj.WinPtr, colour2, obj.globs.RightRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour3, obj.globs.BottomRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour4, obj.globs.LeftRect, obj.globs.LineThickness); %
            Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords ,obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            %Put screen on
            Screen('Flip',obj.WinPtr);

            WaitSecs(obj.globs.InitialStimDuration); 

          % Peripheral Cuing:
            Screen('FrameRect', obj.WinPtr, colour1, obj.globs.TopRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour2, obj.globs.RightRect, obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, colour3, obj.globs.BottomRect, obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, colour4, obj.globs.LeftRect, obj.globs.LineThickness); 
            Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords ,obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            %Cue in this location:
            Screen('FillOval', obj.WinPtr, obj.globs.clrWhite, TrialCueLocation, obj.globs.OvalSize);
            
            Screen('Flip',obj.WinPtr);
            WaitSecs(obj.globs.CueDuration);
            
          %Between Peripheral and Fixation Cues
            Screen('FrameRect', obj.WinPtr, colour1, obj.globs.TopRect, obj.globs.LineThickness); % 
            Screen('FrameRect', obj.WinPtr, colour2, obj.globs.RightRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour3, obj.globs.BottomRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour4, obj.globs.LeftRect, obj.globs.LineThickness); %
            Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords ,obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            Screen('Flip',obj.WinPtr);

            WaitSecs(obj.globs.ISICueToFixation);    
            
          %Fixation Cuing
            Screen('FrameRect', obj.WinPtr, colour1, obj.globs.TopRect, obj.globs.LineThickness); % 
            Screen('FrameRect', obj.WinPtr, colour2, obj.globs.RightRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour3, obj.globs.BottomRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour4, obj.globs.LeftRect, obj.globs.LineThickness); %
            Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords ,obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            %Fixation Cue in this location
            Screen('FillOval', obj.WinPtr, obj.globs.clrWhite, obj.globs.FixationCue, obj.globs.OvalSize);
            Screen('Flip',obj.WinPtr);
            
            WaitSecs(obj.globs.FixationDuration);
            
          %Between Fixation Cue and Animation
            Screen('FrameRect', obj.WinPtr, colour1, obj.globs.TopRect, obj.globs.LineThickness); % 
            Screen('FrameRect', obj.WinPtr, colour2, obj.globs.RightRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour3, obj.globs.BottomRect, obj.globs.LineThickness); %
            Screen('FrameRect', obj.WinPtr, colour4, obj.globs.LeftRect, obj.globs.LineThickness); %
            Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords ,obj.globs.LineThickness); 
            Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
            Screen('Flip',obj.WinPtr);

            WaitSecs(obj.globs.ISIFixToAnimate);
                        
          % set up for movement:
            tmpTopRect = obj.globs.TopRect;
            tmpRightRect = obj.globs.RightRect;
            tmpBottomRect = obj.globs.BottomRect;
            tmpLeftRect = obj.globs.LeftRect;
            OTop = 0;
            ORight = 0;
            OBottom = 0;
            OLeft = 0;
            
            tmrNow = GetSecs;
          %Move things:
            while GetSecs < (tmrNow + (obj.globs.RunAnimateBoxes/2))
              %Move Rectangles
                %new Rectangle position:
                Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpTopRect,obj.globs.LineThickness); % 
                Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpRightRect,obj.globs.LineThickness); %
                Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpBottomRect,obj.globs.LineThickness); %
                Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpLeftRect,obj.globs.LineThickness); %
                Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords,obj.globs.LineThickness); 
                Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
                %New positions: Flip them on:
                Screen('Flip',obj.WinPtr);


                %Bounce off screen borders: Code is long and a copy-paste job, so it's in file 'CheckBounce'
                [MoveTRXY, MoveRRXY, MoveBRXY, MoveLRXY] = CheckWallBounce(obj.globs, tmpTopRect, tmpRightRect, tmpBottomRect, tmpLeftRect, MoveTRXY,MoveRRXY,MoveBRXY,MoveLRXY);
                [tmpOverlapTop, tmpOverlapRight, tmpOverlapBottom, tmpOverlapLeft] = CheckOverlap(obj.globs, tmpTopRect, tmpRightRect, tmpBottomRect, tmpLeftRect);                
                OTop = OTop+ tmpOverlapTop;
                ORight= ORight+ tmpOverlapRight;
                OBottom = OBottom + tmpOverlapBottom;
                OLeft = OLeft + tmpOverlapLeft;
                
                %Set new positions:
                tmpTopRect = tmpTopRect + MoveTRXY;
                tmpRightRect = tmpRightRect + MoveRRXY;
                tmpBottomRect = tmpBottomRect + MoveBRXY;
                tmpLeftRect = tmpLeftRect + MoveLRXY;
            end
            
        % Display Target:
           %Figure out where to put the target:
             TargetLocation = SelectTarget(TrialTargetLocation,tmpTopRect,tmpRightRect,tmpBottomRect,tmpLeftRect);

           % Display target choices
             Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpTopRect,obj.globs.LineThickness); % 
             Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpRightRect,obj.globs.LineThickness); %
             Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpBottomRect,obj.globs.LineThickness); %
             Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, tmpLeftRect,obj.globs.LineThickness); %
             Screen('FramePoly', obj.WinPtr, obj.globs.clrWhite, obj.globs.DiaCoords,obj.globs.LineThickness); 
             Screen('FrameRect', obj.WinPtr, obj.globs.clrWhite, obj.globs.FrameBounds, obj.globs.LineThickness);
             %Leave target on screen when asking about colour
             Screen('FillRect', obj.WinPtr, obj.globs.clrWhite, TargetLocation); %
             
             if TargetLocation ~=0 %If it's not a catch trial:
                 Screen('FillRect', obj.WinPtr, obj.globs.clrWhite, TargetLocation); %
                 TextSize =  Screen('TextBounds', obj.WinPtr, obj.globs.TargetMessage);
                 Screen('DrawText', obj.WinPtr, obj.globs.TargetMessage, (obj.WinWidth/2 - TextSize(3)/2), (obj.WinHeight - (obj.WinHeight/7)), obj.globs.clrWhite);
                 Screen('DrawText', obj.WinPtr, obj.globs.TargetMessage2, (obj.WinWidth/2 - TextSize(3)/2), (obj.WinHeight - (obj.WinHeight/7)+TextSize(4)), obj.globs.clrWhite);
             end
             Screen('Flip',obj.WinPtr);
             
             % How many times did placeholders overlap?
              OverlapTop = OTop;
              OverlapRight = ORight;
              OverlapBottom = OBottom;
              OverlapLeft = OLeft;
             % Final resting place for rectangles:
              TopFinalLocation = tmpTopRect;
              RightFinalLocation = tmpRightRect;
              BottomFinalLocation = tmpBottomRect;
              LeftFinalLocation = tmpLeftRect;
             
            if TargetLocation ~=0 %If it's not a catch trial, wait longer:
                response=WaitKeyTimeOut(obj.globs.AnswerDuration,obj.globs.AllowedKeys);
            else
                response=WaitKeyTimeOut(obj.globs.TargetDuration,obj.globs.AllowedKeys);
            end
                
        end
	end

end

