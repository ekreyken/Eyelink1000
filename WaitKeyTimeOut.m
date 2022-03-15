function [ output_args ] = WaitKeyTimeOut( TimeOutSecs, AllowedKeys )
ListenChar(2);
initTime = GetSecs;
response = [];
responseTime=-1;
while isempty(response)&(GetSecs - initTime) < TimeOutSecs
    [keyIsDown, KbTime, keyCode] = KbCheck;
    if keyIsDown
      response = find(keyCode);
      response = response(1);
      if length(strfind(AllowedKeys,upper(char(response))))>0
         responseTime = GetSecs-initTime;
      else
         response=[];
      end;
    end
end
output_args={responseTime char(response)};
ListenChar(0);
end

