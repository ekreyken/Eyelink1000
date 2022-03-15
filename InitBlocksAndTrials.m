%InitBlocksAndTrials
Blocks=clsBlock(Globals);
PracticeBlock=clsBlock(Globals);

%Direction of Rectangles
MotionDirections = MotionDirection4Box(Globals, Globals.TotalNumTrialsPerBlock);

for b=1:Globals.numBlocks
   TrialMotionDirectionCounter = 0; %Motion direction counter
   PracticeMotionDirectionCounter = 0; %Motion direction counter
   
   Blocks(b)=clsBlock(Globals);
   Blocks(b).BlockNumber=b;
   Blocks(b).BlockType=1;
   Blocks(b).Trials=[];
   
   for cl=1:length(Globals.CueLocations)
      for tl=1:length(Globals.TargetLocations);
         for j=1:Globals.numTrialsPerConditionPerBlock;
                TrialMotionDirectionCounter = TrialMotionDirectionCounter+1;
                
                tmptrial=clsTrial;
                tmptrial.BlockNumber=b;
                tmptrial.PracticeTrial=0;
                tmptrial.CatchTrial = 0;
                tmptrial.CueLocation=Globals.CueLocations(cl);
                tmptrial.TargetLocation=Globals.TargetLocations(tl);
                
                tmptrial.Velocity = Globals.Velocity;
                tmptrial.TopTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingTRXY;
                tmptrial.RightTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingRRXY;
                tmptrial.BottomTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingBRXY;
                tmptrial.LeftTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingLRXY;
                
                ColourAssign = datasample(unique(Globals.ColourAssign),4,'Replace',false);
                tmptrial.TopColour=ColourAssign(1);
                tmptrial.RightColour=ColourAssign(2);
                tmptrial.BottomColour=ColourAssign(3);
                tmptrial.LeftColour=ColourAssign(4);
                
                Blocks(b).Trials = [Blocks(b).Trials, tmptrial];
         end
         if b<=1
            for j=1:Globals.numPracticeTrialsPerCondition;
                PracticeMotionDirectionCounter = PracticeMotionDirectionCounter+1;

                tmptrial=clsTrial;
                tmptrial.PracticeTrial=1;
                tmptrial.CatchTrial = 0;
                tmptrial.CueLocation=Globals.CueLocations(cl);
                tmptrial.TargetLocation=Globals.TargetLocations(tl);
                
                tmptrial.Velocity = Globals.Velocity;
                tmptrial.TopTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingTRXY;
                tmptrial.RightTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingRRXY;
                tmptrial.BottomTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingBRXY;
                tmptrial.LeftTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingLRXY;
                
                ColourAssign = datasample(unique(Globals.ColourAssign),4,'Replace',false);
                tmptrial.TopColour=ColourAssign(1);
                tmptrial.RightColour=ColourAssign(2);
                tmptrial.BottomColour=ColourAssign(3);
                tmptrial.LeftColour=ColourAssign(4);
                
                PracticeBlock.Trials = [PracticeBlock.Trials, tmptrial];
            end
         end
      end
      for ct=1:Globals.numCatchTrialsPerConditionPerBlock;
          TrialMotionDirectionCounter = TrialMotionDirectionCounter+1;

            tmptrial=clsTrial;
            tmptrial.BlockNumber=b;
            tmptrial.PracticeTrial=0;
            tmptrial.CatchTrial=1;
            tmptrial.CueLocation=Globals.CueLocations(cl);
            tmptrial.TargetLocation=0;
            
             tmptrial.Velocity = Globals.Velocity;
             tmptrial.TopTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingTRXY;
             tmptrial.RightTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingRRXY;
             tmptrial.BottomTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingBRXY;
             tmptrial.LeftTrajectory = MotionDirections(TrialMotionDirectionCounter).MovingLRXY;

             ColourAssign = datasample(unique(Globals.ColourAssign),4,'Replace',false);
             tmptrial.TopColour=ColourAssign(1);
             tmptrial.RightColour=ColourAssign(2);
             tmptrial.BottomColour=ColourAssign(3);
             tmptrial.LeftColour=ColourAssign(4);           
            
            Blocks(b).Trials=[Blocks(b).Trials,tmptrial];
        end
      if b<=1
         for ct=1:Globals.numPracticeCatchTrialsPerCondition;
            PracticeMotionDirectionCounter = PracticeMotionDirectionCounter+1;
            
            tmptrial=clsTrial;
            tmptrial.PracticeTrial=1;
            tmptrial.CatchTrial=1;
            tmptrial.CueLocation=Globals.CueLocations(cl);
            tmptrial.TargetLocation=0;
            
            tmptrial.Velocity = Globals.Velocity;
            tmptrial.TopTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingTRXY;
            tmptrial.RightTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingRRXY;
            tmptrial.BottomTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingBRXY;
            tmptrial.LeftTrajectory = MotionDirections(PracticeMotionDirectionCounter).MovingLRXY;

            ColourAssign = datasample(unique(Globals.ColourAssign),4,'Replace',false);
            tmptrial.TopColour=ColourAssign(1);
            tmptrial.RightColour=ColourAssign(2);
            tmptrial.BottomColour=ColourAssign(3);
            tmptrial.LeftColour=ColourAssign(4);
            
            PracticeBlock.Trials=[PracticeBlock.Trials,tmptrial];
        end
      end
   end
      
      %Randomize TrialOrder
      PracticeBlock.Trials = datasample(PracticeBlock.Trials,length(PracticeBlock.Trials), 'Replace', false);
      Blocks(b).Trials = datasample(Blocks(b).Trials, length(Blocks(b).Trials), 'Replace', false);
   
end

clear TrialMotionDirections TrialMotionDirectionCounter tmptrial tl PracticeMotionDirectionCounter MotionDirections j ct ColourAssign cl b