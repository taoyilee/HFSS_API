% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');        
    serial = 0;
    % Create a new temporary HFSS script file.	
    OD = 160:10:200;
    % M11_W = 5;  M11_S = 2;
    M9_WI = 4; 
    M9_WO = 3; 
    M9_S = 2;    
	iter = 1;
	total = length(OD)*length(M9_WI)*length(M9_WO)*length(M9_S);	
    for i=1:length(OD)
        for j=1:length(M9_WI)
            for k=1:length(M9_WO)
                for l=1:length(M9_S)
                % Read file as text
                x = fileread('xfm_highk.vbs');                
                % Remove commas from numbers
                fn = ['XFM-D' num2str(OD(i)) 'I' num2str(M9_WI(j))  'O' num2str(M9_WO(k)) 'S' num2str(M9_S(l)) ];
                x = regexprep(x, 'HFSS_FILENAME', fn);
                x = regexprep(x, '<OD>', num2str(OD(i)));
                x = regexprep(x, '<WI>', num2str(M9_WI(j)));
                x = regexprep(x, '<WO>', num2str(M9_WO(k)));
                x = regexprep(x, '<S>', num2str(M9_S(l)));
                file_out = fopen(['E:\HFSS_API_RUN\XFM_HIGHK\' fn '.vbs'],'w+') ;                                  
                fprintf(file_out,'%s',x);
                fclose all;
				iter = iter + 1;
                end
            end
        end
    end 
catch exception
    disp('**** Error Caught **** Stack =');
    disp('Caller Stack =');
    err = struct2cell(exception.stack);
    % Show Caller Stack 
    disp(err(2:3,:));
    % Show the error thrown
    disp(exception.message);
end