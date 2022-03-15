function [ FileNames ] = getfiles( FileSpec,title )
%% returns a cell array of filenames which include the path.
% (1 file per row)
   if nargin>1
      [fns, pn]=uigetfile(FileSpec,title,'MultiSelect', 'on');
   else
      [fns, pn]=uigetfile(FileSpec,'MultiSelect', 'on');
   end
   FileNames={};
   if iscell(fns) % more than 1 file was chosen
      for i=1:length(fns)
         FileNames(i)=cellstr([pn,fns{i}]);
      end
      FileNames=FileNames';
   else % only one file was chosen (or none)
      if fns==0 % no file was chosen
         return
      end
      FileNames=cellstr([pn,fns]);
   end
end

