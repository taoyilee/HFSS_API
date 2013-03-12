% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    init_hfssapi;
    runAndExit = false ;
    iconized = true ;
    nowait = true;
    % Antenna Parameters.
    fC = 150e6;		% Frequency of Interest.
    Wv = 3e14/fC;	% Wavelength.
    gapL = 5e-2;	% Antenna Gap.
    W = 100;
    L = 100;
    H = 100;
    aRad = 2e-2;    % Antenna Radius.
    % Simulation Parameters.
    fLow = 100e6;
    fHigh = 200e6;
    nPoints = 201;
    % AirBox Parameters.
    AirX = W; 
    AirY = L; 
    AirZ = H;
    % Plot Colors.
    pltCols = ['b', 'r', 'k', 'g', 'm', 'c', 'y'];
    nCols = length(pltCols);
    % Optimization stop conditions.
        disp(['Creating the Script File ...@ ' tmpScriptFile ]);
        % Create a new temporary HFSS script file.
        fid = fopen(tmpScriptFile, 'wt');
       
        % initialize process variables and draw a 1x1 substrate with diels
        hfssProcess(fid,'./t40me7X2Z.csv','./t40imd.csv' ,'7X2Z');
        hfssCreateVar(fid, 'OD', [num2str(100) ' um']);
        hfssCreateVar(fid, 'M11_W', [num2str(1.8) ' um']);
        hfssCreateVar(fid, 'M11_S', [num2str(1.8) ' um']);
        hfss_INDN(fid,0 ,0 , '$M11_Z', '$M11_W', '$M11_S', '$OD', 2, '$M11_T','T40_ME0d021');
        %hfssUDP(fid, 'inductor', 'L0', 11, {'Xpos', 'Ypos', 'S','NT', 'W','Thickness', 'maskGrid', 'DIV', 'OD', 'Zpos', 'lead'},...
        %    {'0um', '0um', '1.8um','2', '1.8um','1.45um', '0.005um', '3.2', '50um', '6.075um','1um'});
        % Add a Solution Setup.
        %hfssInsertSolution(fid, 'Setup150MHz', fC/1e9);
        %hfssInterpolatingSweep(fid, 'Sweep100to200MHz', 'Setup150MHz', ...
        %       fLow/1e9, fHigh/1e9, nPoints);
        % Save the project to a temporary file and solve it.
        projectname = ['./' mfilename(1) '.hfss'];
        disp(['Project saved to ' projectname]);
        hfssSaveProject(fid, projectname, true);
        %hfssSolveSetup(fid, 'Setup150MHz');
        % Export the Network data as an m-file.
        %hfssExportNetworkData(fid, tmpDataFile, 'Setup150MHz', 'Sweep100to200MHz');
        % Close the HFSS Script File.
        fclose(fid);
        % Execute the Script by starting HFSS.
        disp('Solving using HFSS ..');
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    % remove all the added paths.
    deinit_hfssapi;
catch exception
    disp('**** Error Caught **** Stack =');
    disp('Caller Stack =');
    err = struct2cell(exception.stack);
    % Show Caller Stack 
    disp(err(2:3,:));
    % Show the error thrown
    disp(exception.message);
    % Close file
    fclose(fid);
    % Deinitialize paths
    deinit_hfssapi;
end