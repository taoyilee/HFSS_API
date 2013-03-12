pathdir = pwd;
path = '/../../sbox/';
addpath([pathdir path]);
disp(['Path "' pathdir path '" appended'])
path = '/../../boundary/';
addpath([pathdir path]);
disp(['Path "' pathdir path '" appended'])
path = '/../../3dmodeler/';
addpath([pathdir path]);
disp(['Path "' pathdir path '" appended'])
path = '/../../analysis/';
addpath([pathdir path]);
disp(['Path "' pathdir path '" appended'])
path = '/../../general/';
addpath([pathdir path]);
disp(['Path "' pathdir path '" appended'])

% Temporary Files. These files can be deleted after the optimization
% is complete. We have to specify the complete path for all of them.
tmpPrjFile = 'G:\temp\tmpDipole.hfss';
tmpDataFile = 'G:\temp\tmpData.m';

% HFSS Executable Path.
%"C:\Program Files (x86)\Ansoft\HFSS13.0\hfss.exe"
hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';