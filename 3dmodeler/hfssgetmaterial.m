function [string color solvin]= hfssgetmaterial(material)
    string = strcat('" & Chr(34) & "', material , '" & Chr(34) & "');
	switch material
          case 'T40_ME0d022'
            color = {'0','255','0'};
            solvin = 0;
          case 'T40_ME0d021'
            color = {'255','0','0'};
            solvin = 0;
          case 'T40_ME0d289'
            color = {'0','0','255'};
            solvin = 0;
          case 'ME0d041'
            color = {'0','0','255'};
            solvin = 0;
          case 'ME0d022'
            color = {'0','255','0'};
            solvin = 1;
          case 'ME0d1399'
            color = {'0','0','255'};
            solvin = 1; 
          case 'ME0d16'
            color = {'0','0','255'};
            solvin = 1;
          case 'VIA0d16'
            color = {'255','128','0'};
            solvin = 1;
          case 'VIA0d1399'
            color = {'255','128','0'};
            solvin = 1;
          case 'VIA0d022'
            color = {'255','128','0'};
            solvin = 1;
          case 'ME0d005'
            color = {'255','128','0'};
            solvin = 1;			
          otherwise
            color = {'128','128','128'};
            solvin = 1;
	end
end