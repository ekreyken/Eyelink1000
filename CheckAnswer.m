function [ output_args ] = CheckAnswer( obj, GivenAnswer, CorrectAnswer )
%CHECKANSWER Check participants answer: 0 = incorrect, 1 = correct

if isempty(GivenAnswer) && isempty(CorrectAnswer)
    output_args = 1;
elseif isempty(GivenAnswer) && ~isempty(CorrectAnswer)
    output_args = 0;
elseif CorrectAnswer == 1 && GivenAnswer == obj.globs.CyanKeyLower || CorrectAnswer == 1 && GivenAnswer == obj.globs.CyanKeyUpper
    output_args = 1;
elseif CorrectAnswer == 2 && GivenAnswer == obj.globs.GreenKeyLower ||CorrectAnswer == 2 && GivenAnswer == obj.globs.GreenKeyUpper
    output_args = 1;
elseif CorrectAnswer == 3 && GivenAnswer == obj.globs.PurpleKeyLower || CorrectAnswer == 3 && GivenAnswer == obj.globs.PurpleKeyUpper
    output_args = 1;
elseif CorrectAnswer == 4 && GivenAnswer == obj.globs.RedKeyLower || CorrectAnswer == 4 && GivenAnswer == obj.globs.RedKeyUpper
    output_args = 1;
else
    output_args = 0;
end
