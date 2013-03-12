function plotz1p(file)
    close all
    [f data]=SXPParse(file);
    S11=data(1,1,:);   
    [s11max indexmax]=max(10*log10(abs(S11)));
    [s11min indexmin]=min(10*log10(abs(S11)));
    display(['Minimum S11 = ' num2str(s11min) ' at f = ' num2str(f(indexmin))]);
    display(['Maximum S11 = ' num2str(s11max) ' at f = ' num2str(f(indexmax))]);
    plot(f, 10*log10(abs(S11(:))),'color','blue', 'LineWidth', 3);
    hold on
    grid on
    text(f(indexmin),s11min,...
         ['\leftarrow S11 = ' num2str(s11min) ' @' num2str(f(indexmin)/1e+6) 'MHz'],...
         'FontSize',16)
    %text(f(indexmax),s11max,...
    %     ['\leftarrow S11 = ' num2str(s11max) ' @' num2str(f(indexmax)/1e+6) 'MHz'],...
    %     'FontSize',16)
    set(gca,'YLim',[round(s11min)-1, 0]);
    set(gca,'YTick',round(s11min)-1:1:0);
    legend('S11','Location','NorthWest');
    ylabel('SP (db10)');
    xlabel('Frequency (Hz)');   
    title('S-parameters');
    print(gcf,'-dpng', ['sp-' file '.png']);
    S11=reshape(S11,1,size(S11,3));
    smithchart(S11);
    print(gcf,'-dpng', ['smith-' file '.png']);
    M = [f', 20*log(abs(S11(:)))];
    csvwrite(fout, M );
end