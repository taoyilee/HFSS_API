prefix = '/..';
pathdir = pwd;
path = [prefix '/boundary/'];
rmpath([pathdir path]);
disp(['Path "' pathdir path '" removed'])
path = [prefix '/3dmodeler/'];
rmpath([pathdir path]);
disp(['Path "' pathdir path '" removed'])
path = [prefix '/general/'];
rmpath([pathdir path]);
disp(['Path "' pathdir path '" removed'])
path = [prefix '/analysis/'];
rmpath([pathdir path]);
disp(['Path "' pathdir path '" removed'])
