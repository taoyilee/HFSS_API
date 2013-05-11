function run_hfss(dir,N, DESIGN_NAME, varargin)        
    addpath('..');    
    narginchk(3,4);
    path = [dir '/*.hfss'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles
            cur_file = [dir '\' file(i,:)];                                                  
            if(nargin ==3)
                disp(['*** ' datestr(now) ' *** Running HFSS at local machine']);                
                run_em(cur_file, N, DESIGN_NAME, dir)         
            else
                disp(['*** ' datestr(now) ' *** Sending  ' cur_file ' to ' varargin{1} '........']);
                run_em(cur_file, N, DESIGN_NAME, dir, varargin{1})         
            end
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
end