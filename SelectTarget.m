function [ output_args ] = SelectTarget( TrialTargetLocation,tmpTopRect,tmpRightRect,tmpBottomRect,tmpLeftRect )
%SELECTTARGET Select which target location to use based on the trial
switch TrialTargetLocation
   case 0
      TargetLocation = [0 0 0 0];
   case 1
      TargetLocation = tmpTopRect;
   case 2
      TargetLocation  = tmpRightRect;
   case 3
      TargetLocation  = tmpBottomRect;
   case 4
      TargetLocation = tmpLeftRect;
end

output_args = TargetLocation ;

end

