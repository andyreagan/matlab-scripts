function outs=distributeComputation(numProcs,funct,varargin)
% outs=distributeComputation(numProcs,funct,varargin)
% by Morgan R. Frank
% Function for running code in parallel on local machine. Returns a
% cell-array with each entry representing the output from each of the
% processors.
% Input:
%   funct is a function that takes the input from varargin as input and
%       returns numOut many outputs. The first input of funct must be the
%       processor ID and the second input of funct must be the number of
%       processors to use for the computation. The rest of input is
%       whatever additional input is needed to perform the function.
%       Furthermore funct must return ONLY ONE OUTPUT (note that this can 
%       be a cell containing as many variables as you like).
%   varargin=input for funct excluding the processor ID and the number of 
%       processors.
%   numProcs=the number of processors to use.
% Output:
%   outs is a cell-array where each entry is the outputs from each of the
%   processors
%
% Example 1:
%   A simple example of distributing a simple computation.
%   distributeComputation(1,3,@(id,procs,x,y)[id+x+y,id],5,6)
%   ans = 
%    {[12,1]    [13,2]    [14,3]}
%
% Example 2:
%   In this example we distribute the construction of a possibly large 
%   matrix.
%   function M=matBuild(id,procs)
%       M=zeros(10);
%       for i=id:procs:10
%           M(:,i)=i*ones(10,1);
%       end;
%   end
%
%   out=distributeComputation(1,4,@matBuild);
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
C=parcluster('local');
outs=cell(1,numProcs);
try
    if numProcs>C.NumWorkers
        error(['You asked to use ',num2str(numProcs),...
            ' processors, but you only have ',...
            num2str(feature('numCores')),...
            ' available. If this error seems wrong, then configure the',...
            '''local'' parallel profile for matlab to avoid this issue',...
            ' in the future. You can do this by going to Parallel->',...
            'Manage Cluster Profiles and editing the settings for ',...
            '''local''.']);
    elseif numProcs==C.NumWorkers
        %if utilizing all processors, then run one job locally
        count=numProcs-1;
        workers=cell(1,numProcs-1);
        % distribute computation.
        for i=1:numProcs-1
            workers{i}=createJob(C);
            createTask(workers{i},funct,1,{i,numProcs,varargin{:}});
            submit(workers{i});
        end;
        disp('Jobs Submitted.');
        % run the last process locally.
        outs{numProcs}=funct(numProcs,numProcs,varargin{:});
        for i=1:numProcs-1
            wait(workers{i});
            outs{i}=fetchOutputs(workers{i});
            outs{i}=outs{i}{1};
        end;
    else
        count=numProcs;
        workers=cell(1,numProcs);
        % distribute computation.
        for i=1:numProcs
            workers{i}=createJob(C);
            createTask(workers{i},funct,1,{i,numProcs,varargin{:}});
            submit(workers{i});
        end;
        disp('Jobs Submitted.');
        % run the last process locally.
        for i=1:numProcs
            wait(workers{i});
            outs{i}=fetchOutputs(workers{i});
            outs{i}=outs{i}{1};
        end;
    end;
catch err
    disp('Error Processing Jobs:');
    for i=1:numProcs
        try delete(workers{i});
    end;
    throw(err);
end;
for i=1:count
    delete(workers{i});
end;
end