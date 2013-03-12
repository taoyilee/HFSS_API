function plot_tl(dir)  
    close all
	addpath('..');
    init_hfssapi;	
    path = [dir '/*.s2p'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);    
	color = {'blue', 'red', 'green','black', 'yellow', 'green','cyan', 'magenta'};        
    if(nfiles >= 1)         
        for i=1:nfiles
            cur_file{i} = [dir '\' file(i,:)];
            disp(['Procssing s2p -> ' cur_file{i}  ' .....']);
            [f dbS11{i} dbS12{i} dbS21{i} dbS22{i}] = plot_tl_wh(cur_file{i},color{mod(i,8)+1});			
            [pathstr, name{i}, ~] = fileparts(cur_file{i});	
            
        end        
        figure(1) 
        hold on
      
        for i=1:nfiles            
%             plotsp(dbS11{i}, f,  'S11', cur_file{i} ,color{mod(i,8)+1});            
%             plotsp(dbS12{i}, f,  'S12',cur_file{i} ,color{mod(i,8)+1});            
%             plotsp(dbS21{i}, f,  'S21',cur_file{i} ,color{mod(i,8)+1});            
%             plotsp(dbS22{i}, f,  'S22',cur_file{i} ,color{mod(i,8)+1});
            
            figure(2)   % S11
            plot(f/1e+9, dbS11{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);			
                     
            hold on
            grid on
            title('S_{11} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            figure(3)   % S12
            plot(f/1e+9, dbS12{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);			

            hold on
            grid on
            title('S_{12} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            figure(4)   % S21
            plot(f/1e+9, dbS21{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);			

            hold on
            grid on
            title('S_{21} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            figure(5)   % S22
            plot(f/1e+9, dbS22{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);			
    
            hold on
            grid on
            title('S_{22} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            figure(1)
            subplot(2,2,1)            
           	plot(f/1e+9, dbS11{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);			
            hold on
            grid on
            title('S_{11} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
        
            subplot(2,2,2)
            plot(f/1e+9, dbS12{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);
            hold on
            grid on
            title('S_{12} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            subplot(2,2,3)
            plot(f/1e+9, dbS21{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);
            hold on
            grid on
            title('S_{21} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')
            
            subplot(2,2,4)
            plot(f/1e+9, dbS22{i},'color',color{mod(i,8)+1}, 'LineWidth', 2);
            hold on
            grid on
            title('S_{22} (dB10)')
            xlabel('Frequency (GHz)', 'interpreter', 'none')
            ylabel('S-parameter (dB)', 'interpreter', 'none')            
        end		
        figure(1)
        print(gcf, '-dpng', [pathstr '\S-parameters of Transmission Line.png']);
        figure(2)
           legend(name,'Location','EastOutside');
        print(gcf, '-dpng', [pathstr '\S11 of Transmission Line.png']);
        figure(3)
           legend(name,'Location','EastOutside');
        print(gcf, '-dpng', [pathstr '\S12-parameters of Transmission Line.png']);
        figure(4)
           legend(name,'Location','EastOutside');
        print(gcf, '-dpng', [pathstr '\S21-parameters of Transmission Line.png']);
        figure(5)
           legend(name,'Location','EastOutside');
        print(gcf, '-dpng', [pathstr '\S22-parameters of Transmission Line.png']);
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
end
