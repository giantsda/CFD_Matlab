 path='C:\CFD_second_HHD\racewayOpenfoam\04162019\20\data\';
 files=dir([path 'export*']);
 
 for i=1:10:length(files)
     filename=[path files(i).name]
     movefile(filename,['C:\CFD_second_HHD\racewayOpenfoam\04162019\20\data2\' files(i).name] );
 end
 