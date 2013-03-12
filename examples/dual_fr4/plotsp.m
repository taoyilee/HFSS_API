function pathstr = plotsp(sp, f, title1,fn,color)
        figure
        [pathstr, name, ~] = fileparts(fn);	
        plot(f/1e+9, sp,'color',color, 'LineWidth', 2);			            
        grid on 
        title([title1 ' of ' pathstr name], 'interpreter', 'none')
        xlabel('Frequency (GHz)', 'interpreter', 'none')
        ylabel('S-parameter (dB)', 'interpreter', 'none')
        figpath = [pathstr '\' title1 '-' name '.png'];
        disp(['Figure saved to ' figpath])
        print(gcf, '-dpng', figpath);
        close
end