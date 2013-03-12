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
        % Create a new HFSS Project and insert a new design.
        hfssNewProject(fid);
        hfssInsertDesign(fid, 'without_balun');

        % Create the Dipole.
        hfssIMD(fid, '', './t40imd.csv', W ,L ,0);

        
        % add a substrate
        substrate = 300; % um
        hfssBox(fid, 'Substrate', [-AirX, -AirY, 0]/2, [AirX, AirY, -substrate], ...
                'um');
        hfssAssignMaterial(fid, 'Substrate','silicon');
        hfssSetColor(fid, 'Substrate', [0 0 255]);      
        % Add an AirBox.
        hfssBox(fid, 'AirBox', [-AirX/2, -AirY/2, -substrate], [AirX, AirY, AirZ+substrate], ...
                'um');
        hfssAssignMaterial(fid, 'AirBox','air');
        hfssAssignRadiation(fid, 'ABC', 'AirBox');
        
        hfssSetUnit(fid, 'um');
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