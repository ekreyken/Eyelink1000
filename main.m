function  [OutputArgs] = MotionDirection4Box(globs, numTrials )
%MOTIONDIRECTION4BOX Summary of this function goes here
%   Detailed explanation goes here

for i=1:numTrials
%Direction of Rectangles
tmpInitialDirections = 2*pi*rand(1,globs.numPlaceholders); %Initial trajectories for all squares

tmpVelocityX = globs.Velocity*cos(tmpInitialDirections); %Velocity & direction for all squares on X axis
tmpVelocityY = globs.Velocity*sin(tmpInitialDirections); %Velocity & direction for all squares on Y axis
%Seperate out each box's velocity
tmpMovingTRXY = [tmpVelocityX(1) tmpVelocityY(1) tmpVelocityX(1) tmpVelocityY(1)]; %XYXY coordinates for newTopRect
tmpMovingRRXY = [tmpVelocityX(2) tmpVelocityY(2) tmpVelocityX(2) tmpVelocityY(2)]; %XYXY coordinates for newRightRect
tmpMovingBRXY = [tmpVelocityX(3) tmpVelocityY(3) tmpVelocityX(3) tmpVelocityY(3)]; %XYXY coordinates for newBottomRect
tmpMovingLRXY = [tmpVelocityX(4) tmpVelocityY(4) tmpVelocityX(4) tmpVelocityY(4)]; %XYXY coordinates for newLeftRect

clsMovementDirection(i).MovingTRXY = tmpMovingTRXY;%[aMovingTRXY; tmpaMovingTRXY];
clsMovementDirection(i).MovingRRXY = tmpMovingRRXY; %[aMovingRRXY;tmpaMovingRRXY];
clsMovementDirection(i).MovingBRXY= tmpMovingBRXY; %[aMovingBRXY; tmpaMovingBRXY];
clsMovementDirection(i).MovingLRXY = tmpMovingLRXY; %[aMovingLRXY; tmpaMovingLRXY];

clear InitialDirections tmpVelocityX tmpVelocityY tmpaMovingTRXY tmpaMovingBRXY tmpaMovingLRXY tmpaMovingRRXY
end

OutputArgs = clsMovementDirection;
end

