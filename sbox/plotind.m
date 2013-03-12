function plotind()
    addpath('./sbox');
    s1plist = ls('*.s1p');
    for i=1:length(s1plist)
        try
        file = s1plist(i,:);
        disp(['Processing ' file])
        plotL(file);
        catch e
            disp(['Error caught when processing ' file])
            disp(e.message);
            disp(e.stack(1));
        end
    end
end