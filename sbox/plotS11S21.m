function plotS11S21(file, W, S, L, GND_H, GND_F, replot)  
    close all
    [pathstr, name, ~] = fileparts(file);
    %disp([file '@path =' pathstr]);
    [f data]= SXPParse(file);
    S11 = data(1,1,:);
    S11 = S11(:);
    dbS11 = 10*log(abs(S11));    
    S21 = data(2,1,:);
    S21 = S21(:);
    dbS21 = 10*log(abs(S21));
    S12 = data(1,2,:);
    S12 = S12(:);
    dbS12 = 10*log(abs(S12));
    S22 = data(2,2,:);  
    S22 = S22(:);
    dbS22 = 10*log(abs(S22));
    
    if(replot)
        plot(f/1e+9, dbS11,'color','blue', 'LineWidth', 3);
        hold on
        plot(f/1e+9, dbS22,'r--', 'LineWidth', 3);
        grid on    
        %set(gca,'YLim',[0, 1]);
        %set(gca,'YTick',0:0.1:1);
        legend(['S11';'S22'],'Location','NorthWest');
        ylabel('Return Loss (dB)');
        xlabel('Frequency (GHz)');   
        title(['Return Loss of CPW-' name]);
        if(~exist([pathstr '\RL'],'dir'))
            mkdir([pathstr '\RL']);
        end
        print(gcf,'-dpng', [pathstr '\RL\CPW-' name '.png']);
        % set(gca,'YLim',[0, 1]);
        % set(gca,'YTick',0:0.05:1);
        
        figure % S11 smith        
        [lineseries,~] = smithchart(S11);
        set(lineseries, 'LineWidth',2)
        set(gca,'XLim',[-0.1, 0.1]);
        set(gca,'YLim',[-0.1, 0.1]);
        title(['S11-' name]);
        print(gcf,'-dpng', [pathstr '\RL\S11-' name '.png']);              
        
        figure % S22 smith
        [lineseries,~] = smithchart(S22);
        set(gca,'XLim',[-0.1, 0.1]);
        set(gca,'YLim',[-0.1, 0.1]);
        set(lineseries, 'LineWidth',2)
        title(['S22-' name]);
        print(gcf,'-dpng', [pathstr '\RL\S22-' name '.png']);                      
        
        figure  % insertion loss
        plot(f/1e+9, dbS21,'color','blue', 'LineWidth', 3);        
        hold on
        plot(f/1e+9, dbS12,'r--', 'LineWidth', 3);        
        grid on    
        legend(['S21';'S12'],'Location','NorthWest');
        % set(gca,'YLim',[0, 15]);
        % set(gca,'YTick',0:1:15);        
        ylabel('Insertion Loss (dB)');
        xlabel('Frequency (GHz)');   
        title(['Insertion Loss of CPW-' name]);
        if(~exist([pathstr '\IL'],'dir'))
            mkdir([pathstr '\IL']);
        end
        print(gcf,'-dpng', [pathstr '\IL\CPW-' name '.png']);        
        set(gca,'YLim',[-0.1, 0]);
        set(gca,'YTick',-0.1:0.01:0);     
        print(gcf,'-dpng', [pathstr '\IL\CPWN-' name '.png']);        
        SP = [f', dbS11, dbS21, dbS12, dbS22];  
        if(~exist([pathstr '\csv'],'dir'))
            mkdir([pathstr '\csv']);
        end
        csvwrite([pathstr '\csv\' name '.csv'], SP); 
        %delete([pathstr '\summary.csv']);
    else
        disp('Skipping plots, collecting values for summary only');
    end
    dbS115d8G = S11(99);
    dbS2110d6G = S21(272);
    dbS1124G = S11(409);
    dbS215d8G = S21(99);
    dbS1110d6G = S11(272);
    dbS2124G = S21(409);    
    array1 = [W,S, L, GND_H, GND_F, dbS115d8G, dbS215d8G, dbS1110d6G, dbS2110d6G, dbS1124G, dbS2124G];
    dlmwrite([pathstr '\summary.csv'], array1, '-append','delimiter',',');    
    close all
end