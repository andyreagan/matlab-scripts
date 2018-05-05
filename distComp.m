function outs=distComp(numProcs,funct,varargin)
% outs=distComp(numProcs,funct,varargin)
% by Morgan R. Frank
% Function for running code in parallel on local machine. Returns a
% cell-array with each entry representing the output from each of the
% processors.
% Input:
%   funct is a function that takes the input from varargin as input. 
%       funct must return ONLY ONE OUTPUT (note that this can 
%       be a cell containing as many variables as you like).
%       Within the function funct, use the variable "labindex" to 
%       identify which processor is running the code, and use the 
%       variable "numlabs" to identify how many processors are in use.
%   varargin=input for funct excluding the processor ID and the number of 
%       processors.
%   numProcs=the number of processors to use.
% Output:
%   outs is a cell-array where each entry is the outputs from each of the
%   processors
%
% Example 1:
%   A simple example of distributing a simple computation.
%   distComp(3,@(x,y)[labindex+x+y,labindex],5,6)
%   ans = 
%    {[12,1]    [13,2]    [14,3]}
%
% Example 2:
%   In this example we distribute the construction of a possibly large 
%   matrix.
%   function M=matBuild()
%       M=zeros(10);
%       for i=labindex:numlabs:10
%           M(:,i)=i*ones(10,1);
%       end;
%   end
%
%   out=distComp(4,@matBuild);
%   M=out{1}
%   for i=2:4
%       M=M+out{i};
%   end;
%
%   M =
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%      1     2     3     4     5     6     7     8     9    10
%
matlabpool(numProcs);
outs=cell(1,numProcs);

try
    spmd
        out=funct(varargin{:});
    end;
    for i=1:numProcs
        outs{i}=out{i};
    end;
catch err
    disp(err);
    disp('Error Processing Jobs:');
    matlabpool close;
    throw(err);
end;
matlabpool close;
end
