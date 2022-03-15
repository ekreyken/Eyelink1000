function [MoveTRXY, MoveRRXY, MoveBRXY, MoveLRXY] = CheckWallBounce(globs, tmpTopRect, tmpRightRect, tmpBottomRect, tmpLeftRect, TRXY,RRXY,BRXY,LRXY)
%CHECKWALLBOUNCE Make sure the boxes aren't bouncing off the screen.

%globs = Globals
%(1) = Left, (2) = Top, (3) = Right, (4) = Bottom
%Code for the Top Rectangle (yes, it's a copy paste job).  
 if tmpTopRect(1) < globs.xMinBounceSize
    TRXY(1) = -TRXY(1); 
    TRXY(3) = -TRXY(3); 
 end
 if tmpTopRect(3) > globs.xMaxBounceSize
    TRXY(1) = -TRXY(1); 
    TRXY(3) = -TRXY(3); 
 end
 if tmpTopRect(2) < globs.yMinBounceSize
    TRXY(2) = -TRXY(2); 
    TRXY(4) = -TRXY(4); 
 end
 if tmpTopRect(4) > globs.yMaxBounceSize
    TRXY(2) = -TRXY(2); 
    TRXY(4) = -TRXY(4); 
 end
  %Code for the Right Rectangle (yes, it's a copy paste job).  
 if tmpRightRect(1) < globs.xMinBounceSize
     RRXY(1) = -RRXY(1); 
     RRXY(3) = -RRXY(3); 
 end
 if tmpRightRect(3) > globs.xMaxBounceSize
     RRXY(1) = -RRXY(1); 
     RRXY(3) = -RRXY(3); 
 end
 if tmpRightRect(2) < globs.yMinBounceSize
    RRXY(2) = -RRXY(2); 
    RRXY(4) = -RRXY(4); 
 end
 if tmpRightRect(4) > globs.yMaxBounceSize
    RRXY(2) = -RRXY(2); 
    RRXY(4) = -RRXY(4); 
 end

   %Code for the Bottom Rectangle (yes, it's a copy paste job).  
 if tmpBottomRect(1) < globs.xMinBounceSize
     BRXY(1) = -BRXY(1); 
     BRXY(3) = -BRXY(3); 
 end
 if tmpBottomRect(3) > globs.xMaxBounceSize
     BRXY(1) = -BRXY(1); 
     BRXY(3) = -BRXY(3); 
 end
 if tmpBottomRect(2) < globs.yMinBounceSize
    BRXY(2) = -BRXY(2); 
    BRXY(4) = -BRXY(4); 
 end
 if tmpBottomRect(4) > globs.yMaxBounceSize
    BRXY(2) = -BRXY(2); 
    BRXY(4) = -BRXY(4); 
 end
  %Code for the Left Rectangle (yes, it's a copy paste job).  
 if tmpLeftRect(1) < globs.xMinBounceSize
    LRXY(1) = -LRXY(1); 
    LRXY(3) = -LRXY(3); 
 end
 if tmpLeftRect(3) > globs.xMaxBounceSize
    LRXY(1) = -LRXY(1); 
    LRXY(3) = -LRXY(3); 
 end
 if tmpLeftRect(2) < globs.yMinBounceSize
    LRXY(2) = -LRXY(2); 
    LRXY(4) = -LRXY(4); 
 end
 if tmpLeftRect(4) > globs.yMaxBounceSize
    LRXY(2) = -LRXY(2); 
    LRXY(4) = -LRXY(4); 
 end

 MoveTRXY = TRXY;
 MoveRRXY = RRXY;
 MoveBRXY = BRXY;
 MoveLRXY = LRXY;
 
end

