function [ TopOverlap, RightOverlap, BottomOverlap, LeftOverlap] = CheckOverlap( globs, tmpTopRect, tmpRightRect, tmpBottomRect, tmpLeftRect)
%CHECKOVERLAP Check if any of the placeholders overlap
%globs = Globals
TopOverlap = 0;
RightOverlap = 0;
BottomOverlap = 0;
LeftOverlap = 0;

% Find the middle of each rectangle (x,y) and state the width and height of each
MiddleTop = [(tmpTopRect(3) - globs.RectSize/2), (tmpTopRect(4) - globs.RectSize/2)];
MiddleTop = [MiddleTop, globs.RectSize, globs.RectSize];
MiddleRight = [(tmpRightRect(3) - globs.RectSize/2), (tmpRightRect(4) - globs.RectSize/2)];
MiddleRight = [MiddleRight, globs.RectSize, globs.RectSize];
MiddleBottom = [(tmpBottomRect(3) - globs.RectSize/2), (tmpBottomRect(4) - globs.RectSize/2)];
MiddleBottom = [MiddleBottom, globs.RectSize, globs.RectSize];
MiddleLeft = [(tmpLeftRect(3) - globs.RectSize/2), (tmpLeftRect(4) - globs.RectSize/2)];
MiddleLeft = [MiddleLeft, globs.RectSize, globs.RectSize];

testTopRight = rectint(MiddleTop,MiddleRight);
testTopBottom = rectint(MiddleTop,MiddleBottom);
testTopLeft = rectint(MiddleTop,MiddleLeft);

testRightBottom = rectint(MiddleRight,MiddleBottom);
testRightLeft = rectint(MiddleRight,MiddleLeft);

testBottomLeft = rectint(MiddleBottom,MiddleLeft);

% See if any rectangles intersect
if testTopRight > 0
    TopOverlap = 1;
    RightOverlap = 1;
end
if testTopBottom > 0
    TopOverlap = 1;
    BottomOverlap = 1;
end
if testTopLeft >0
    TopOverlap = 1;
    LeftOverlap = 1;
end
if testRightBottom>0
    RightOverlap = 1;
    BottomOverlap = 1;
end
if testRightLeft>0
    RightOverlap = 1;
    LeftOverlap = 1;
end
if testBottomLeft > 0
    BottomOverlap = 1;
    LeftOverlap = 1;
end

end



