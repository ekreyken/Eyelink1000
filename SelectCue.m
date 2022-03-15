function [ output_args ] = SelectCue( obj, t )
%SELECTCUE Select which cue location to use based on the trial
switch obj.Trials(t).CueLocation
   case 1
      CueLocation = obj.globs.TopCue;
   case 2
      CueLocation = obj.globs.RightCue;
   case 3
      CueLocation = obj.globs.BottomCue;
   case 4
      CueLocation = obj.globs.LeftCue;
end

output_args = CueLocation;
end

