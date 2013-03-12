function plotC(file)  
    [pathstr, name, ext] = fileparts(file);
    %disp([file '@path =' pathstr]);
    [f data]=SXPParse(file);       
    Y11 = s2y(data,59);    
    imY11 = imag(Y11(1,1,:));
    imY11 = imY11(:);  
    w = 2*pi*f';
    C = (imY11./w)*1e+15;    

        plot(f/1e+9, C,'color','blue', 'LineWidth', 3);        
        grid on    
        %set(gca,'YLim',[0, 1]);
        %set(gca,'YTick',0:0.1:1);
        legend('C(fF)','Location','NorthWest');
        ylabel('Capacitance (fF)');
        xlabel('Frequency (GHz)');   
        title('Bondpad Capacitance');
        print(gcf,'-dpng', [pathstr  name '.png']);
    end