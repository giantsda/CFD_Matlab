MainPath='C:\Users\chenshen.ETS01297\Desktop\Linux\a';
cd(MainPath);
cases=dir('.')
for i=3:length(cases)
    
    caseName=cases(i).name
    cd (caseName);
    files=dir('.');
    cd (files(3).name)
    if exist('alphaPhi0.water', 'file')==2
        delete('alphaPhi0.water');
        delete('phi');
        delete('rAU');
        delete('Uf');
        delete('meshPhi');
    end
 
    cd(MainPath);
end