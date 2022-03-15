classdef clsBlock
   %CLSBLOCK Summary of this class goes here
   %   Detailed explanation goes here
   
   properties
      BlockNumber=0; 
      BlockType;  %0 = practice, 1 = real trial
      TrialsPerBlock; %
      CatchTrialsPerBlock; %
      Trials; %
      %EyeLinkRecord; %Have eyetracker recording or not? 0 = no, 1 = record
      globs;
   end
   
   methods
      function obj=clsBlock(globals) %Pass this class the variables held in Globals
         obj.globs=globals;
      end
      
      %%      
      function [run]=runtrials(obj)
         if obj.globs.EL.Mode ~= 2
            Eyelink('Message', 'BLOCKID %d', obj.BlockNumber); 
         end
         for t=1:length(obj.Trials)
              % build imagestream:
  
            if obj.Trials(t).CatchTrial
               timing=obj.globs.TimingCatch;
               images=obj.globs.imgstream_Catch;
            else
               timing=obj.globs.TimingTrial;
               images=obj.globs.imgstream_Trials;
               images{obj.globs.STREAM_TARGETPOSITION}=obj.globs.ImageListTarget{obj.Trials(t).TargetLocation};
            end
            images{obj.globs.STREAM_CUEPOSITION}=obj.globs.ImageListCue{obj.Trials(t).CueLocation};
            % start tracking
             if obj.globs.EL.Mode ~= 2
                Eyelink('Message', 'TRIALID %d', t);  
             end
            WaitSecs(.1);
            obj.globs.EL.startrecording 
            % fire stimulus stream and get input
            res=obj.globs.Scr.displayimgstream(images,timing);
            if (obj.Trials(t).CatchTrial & ~isempty(res{2})) | (~obj.Trials(t).CatchTrial & isempty(res{2}))
               PlayTone(440,obj.globs.BeepTime);
            end
            obj.Trials(t).RT=res{1};
            obj.globs.Scr.cls;
            % stop tracking
            obj.globs.EL.stoprecording;
         end
         run=obj;  
      end
      
            %%
      function [run] = runMotionTrials(obj)
         for t=1:length(obj.Trials)
                       
           % Figure out what colours to put where:
            [colour1, colour2, colour3, colour4] = SortColours(obj,t); %colour1=top, colour2=right,colour3=bottom,colour4=left
           
           % Figure out what cue it is
            TrialCueLocation = SelectCue(obj,t);
                        
           % Figure out what target it is
            TrialTargetLocation = obj.Trials(t).TargetLocation;
           
           % Figure out what colour the target is:
            switch(obj.Trials(t).TargetLocation);
                case 1
                    obj.Trials(t).TargetColour = obj.Trials(t).TopColour;
                case 2
                    obj.Trials(t).TargetColour = obj.Trials(t).RightColour;
                case 3
                    obj.Trials(t).TargetColour = obj.Trials(t).BottomColour;
                case 4
                    obj.Trials(t).TargetColour = obj.Trials(t).LeftColour;
            end
           
           % fire stimulus stream and get input
            obj.globs.Scr.globs = obj.globs;
            [response, TFinal, RFinal, BFinal, LFinal,OverlapTop, OverlapRight, OverlapBottom, OverlapLeft] =obj.globs.Scr.displayMotion(obj.globs.Scr, colour1, colour2, colour3, colour4, TrialCueLocation, TrialTargetLocation, obj.Trials(t).TopTrajectory, obj.Trials(t).RightTrajectory, obj.Trials(t).BottomTrajectory, obj.Trials(t).LeftTrajectory);
            obj.Trials(t).TopFinalLocation = TFinal;
            obj.Trials(t).RightFinalLocation = RFinal;
            obj.Trials(t).BottomFinalLocation = BFinal;
            obj.Trials(t).LeftFinalLocation = LFinal;
            
            obj.Trials(t).TopOverlap = OverlapTop;
            obj.Trials(t).RightOverlap = OverlapRight;
            obj.Trials(t).BottomOverlap = OverlapBottom;
            obj.Trials(t).LeftOverlap = OverlapBottom;
            
            
            if (obj.Trials(t).CatchTrial && ~isempty(response{2})) || (~obj.Trials(t).CatchTrial && isempty(response{2}))
               PlayTone(440,obj.globs.BeepTime);
            end
            obj.Trials(t).RT = response{1};
            obj.Trials(t).ColourChoice=response{2};
           % Check their answer:
            if ~obj.Trials(t).CatchTrial %if it's not a catch trial, check their answer
                obj.Trials(t).CorrectColourChoice = CheckAnswer(obj, obj.Trials(t).ColourChoice, obj.Trials(t).TargetColour);
            elseif obj.Trials(t).CatchTrial
                if ~isempty(response{2})
                    obj.Trials(t).CorrectColourChoice = 0; %if they responded,it's wrong
                elseif isempty(response{2})
                    obj.Trials(t).CorrectColourChoice = 1; %if they didn't respond, it's right
                end
            end

            obj.globs.Scr.cls;
         end
         run=obj;
      end
      
   end %end Methods
   
end %End class

