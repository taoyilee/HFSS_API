
function hfssExecuteRemoteScript(hfssExePath, ScriptFile, iconMode, runAndExit,nowait, BatchSolve, server)

% arguments processor.
if (nargin < 2)
	error('Insufficient number of arguments !');
elseif (nargin < 6)
	iconMode = [];
    runAndExit = [];
    nowait = [];
    BatchSolve = [];
end;

% default arguments.
if isempty(iconMode)
	iconMode = true;
end;
if isempty(runAndExit)
    runAndExit = true;
end;

% Setup Iconic Mode.
if (iconMode == true)
	iconStr = '/Iconic';
else
	iconStr = '';
end;

% Setup Run and Exit Mode.
if (runAndExit)
    runStr = '/RunScriptAndExit';
else
    runStr = '/RunScript';
end;

% Setup Iconic Mode.
if isempty(BatchSolve)
	BatchSolveStr = '';
else
	BatchSolveStr = ['/BatchSolve ' BatchSolve];
end;

% Create the Command Path.
cmdHFSS = [hfssExePath, '/Remote /machinelist list="' server '" ', iconStr, ' ', runStr, ' ', BatchSolveStr, ' ',  ...
           ScriptFile];
if (nowait)
    cmdHFSS = [cmdHFSS ' &'];
end
% Execute the Command.
disp(['Running HFSS using ' cmdHFSS ' ...']);
[Status, ~] = system(cmdHFSS);
if (Status ~= 0)
	warning('HFSS Execution returned an error status !');
end;
