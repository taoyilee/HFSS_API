function run_em(filename, N, DESIGN_NAME, hfss_path, varargin)
    narginchk(4,5)
    [path, name, ~] = fileparts(filename);           
    if(~exist([path '\' name '.s' num2str(N) 'p'],'file'))        
        disp(['Procssing -> ' filename  ' .....']);
        hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
        hfssPjtPath =  [' -batchsolve ' DESIGN_NAME '  "' path '\' name '.hfss"'];
        if(nargin == 4)            
            cmd = [hfssExePath ' -ng  -Local' hfssPjtPath];
        else           
            cmd = [hfssExePath ' -ng -Remote ' ...
                '-machinelist list="' machine '"  ' hfssPjtPath];            
        end
            disp(['***** COMMAND -> ' cmd]);
        try                                               
            [status, result] = system(cmd);
            disp([num2str(status) result]);
            export_snp(filename, N, DESIGN_NAME, hfss_path)  ;
        catch e
            disp(['*** Iteration failed->' filename]);
            disp(e.message)
            disp('Continuing ...');                       
        end
%     else
%         disp(['Skipping vbs -> ' filename  ' .....']);
    end      
end