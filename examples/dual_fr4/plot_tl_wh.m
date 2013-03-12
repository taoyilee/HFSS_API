function [f dbS11 dbS12 dbS21 dbS22] = plot_tl_wh(file,color)  	
	[pathstr, name, ~] = fileparts(file);	
	disp(['Processing ' file ' ....']);	
	[f data]= SXPParse(file);
	S11 = data(1,1,:);
	S11 = S11(:);
    [hlines, hsm] = smithchart(S11);
    set(hlines, 'Color',color,'LineWidth',2)
    axis([-0.5 0.5 -0.5 0.5])
    title(['S_{11} of ' pathstr '\' name], 'interpreter','none')
    print(gcf, '-dpng', [pathstr '\S11' name '-SMITH.png']);
    
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
    [hlines, hsm] = smithchart(S22);
    set(hlines, 'Color',color,'LineWidth',2) 
    axis([-0.5 0.5 -0.5 0.5])
    title(['S_{22} of ' pathstr '\' name], 'interpreter','none')
    print(gcf, '-dpng', [pathstr '\S22' name '-SMITH.png']);
end