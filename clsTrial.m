classdef clsTrial
   %CLSTRIAL Summary of this class goes here
   %   Detailed explanation goes here
   
    properties
        PracticeTrial; %0=experimental trial, 1= practice trial
        BlockNumber;
        CatchTrial; % 0, or 1 if catch trial
        CueLocation; %1,2,3,4: top, right, bottom, left
        TargetLocation; %1,2,3,4: top, right, bottom, left
        TargetColour; %What colour was the target? 
        RT; % -1 for timeout, or rt in milliseconds
        ColourChoice; % which colour did they choose for the target
        CorrectColourChoice; % did they choose the correct colour? 0 = no, 1 = yes
        Velocity; %velocity of target object
        TopFinalLocation;
        TopTrajectory; %Trajectory of top object
        TopColour;
        TopOverlap;
        RightFinalLocation;
        RightTrajectory;
        RightColour;
        RightOverlap;
        BottomFinalLocation;
        BottomTrajectory;
        BottomColour; 
        BottomOverlap; %did it overlap with other objects?
        LeftFinalLocation;
        LeftTrajectory;
        LeftColour;
        LeftOverlap;
    end

    methods
    end
   
end

