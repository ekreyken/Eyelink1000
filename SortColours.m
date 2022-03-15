function [ colour1, colour2, colour3, colour4 ] = SortColours( obj, trialNum  )
%SORTCOLOURS Summary of this function goes here
%   Detailed explanation goes here
%obj = block; globs = globals
switch(obj.Trials(trialNum).TopColour)
   case 1
       colour1 = obj.globs.Cyan;
   case 2
       colour1 = obj.globs.Green;
   case 3
       colour1 = obj.globs.Magenta;
   case 4
       colour1 = obj.globs.Red;
end        
switch(obj.Trials(trialNum).RightColour)
   case 1
       colour2 = obj.globs.Cyan;
   case 2
       colour2 = obj.globs.Green;
   case 3
       colour2 = obj.globs.Magenta;
   case 4
       colour2 = obj.globs.Red;
end
switch(obj.Trials(trialNum).BottomColour)
   case 1
       colour3 = obj.globs.Cyan;
   case 2
       colour3 = obj.globs.Green;
   case 3
       colour3 = obj.globs.Magenta;
   case 4
       colour3 = obj.globs.Red;
end
switch(obj.Trials(trialNum).LeftColour)
   case 1
       colour4 = obj.globs.Cyan;
   case 2
       colour4 = obj.globs.Green;
   case 3
       colour4 = obj.globs.Magenta;
   case 4
       colour4 = obj.globs.Red;
end    

end

