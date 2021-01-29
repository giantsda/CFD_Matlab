%% Read mesh, do not need if only interested in data files.


pointsFile = ["constant/polyMesh/points"];
facesFile = ['constant/polyMesh/faces'];
ownerFile = ['constant/polyMesh/owner'];
neighbourFile = ['constant/polyMesh/neighbour'];
boundaryFile = ['constant/polyMesh/boundary'];

%
%readPoints
%
fpid = fopen(pointsFile, 'r');
for i=1:18
    fgetl(fpid);
end
numberOfPoints = fscanf(fpid, '%d',1);
fgetl(fpid);
fgetl(fpid);
for n = 1:numberOfPoints
    fscanf(fpid, '%c',1);
    x=fscanf(fpid, '%f',1);
    y=fscanf(fpid, '%f',1);
    z=fscanf(fpid, '%f',1);
    fscanf(fpid, '%c',1);
    fscanf(fpid, '%c',1);
    nodes(n).centroid = [x y z]';
    nodes(n).index = n;
    nodes(n).iFaces=[];
    nodes(n).iElements=[];
end
fclose(fpid);
%
%read Faces
%
ffid = fopen(facesFile, 'r');
%header = textscan(fpid,'%s',18,'EndOfLine','\n')
numberOfFaces = textscan(ffid,'%d',1,'HeaderLines',18);
numberOfFaces = numberOfFaces{1};
header = fscanf(ffid, '%s', 1);

% read each set of measurements
for n = 1:numberOfFaces
    theNumberOfPoints = fscanf(ffid, '%d', 1);
    header = fscanf(ffid, '%c', 1);
    faces(n).iNodes=fscanf(ffid, '%d', theNumberOfPoints)'+1;
    header = fscanf(ffid, '%c', 1);
    faces(n).index=n;
    faces(n).iOwner = -1;
    faces(n).iNeighbour = -1;
end
fclose(ffid);

%
%read owners
%
foid = fopen(ownerFile, 'r');
%header = textscan(fpid,'%s',18,'EndOfLine','\n')
numberOfOwners = textscan(foid,'%d',1,'HeaderLines',18);
numberOfOwners = numberOfOwners{1};
header = fscanf(foid, '%s', 1);
for n=1:numberOfOwners
    faces(n).iOwner = fscanf(foid,'%d',1)+1;
    faces(n).iNeighbour=-1;
end
numberOfElements = max([faces.iOwner]);
fclose(foid);
%
%read neighbours
%
fnid = fopen(neighbourFile, 'r');
%header = textscan(fpid,'%s',18,'EndOfLine','\n')
numberOfNeighbours = textscan(fnid,'%d',1,'HeaderLines',18);
numberOfNeighbours = numberOfNeighbours{1};
header = fscanf(fnid, '%s', 1);
for n=1:numberOfNeighbours
    faces(n).iNeighbour = fscanf(fnid,'%d',1)+1;
end
fclose(fnid);

numberOfInteriorFaces = numberOfNeighbours;
%
% construct elements
%
elements= [];
for iElement=1:numberOfElements;
    elements(iElement).index = iElement;
    elements(iElement).iNeighbours = [];
    elements(iElement).iFaces=[];
    elements(iElement).iNodes=[];
    elements(iElement).volume = 0.;
    elements(iElement).faceSign=[];
    
end

for iFace=1:numberOfInteriorFaces
    iOwner = faces(iFace).iOwner;
    iNeighbour = faces(iFace).iNeighbour;
    %
    elements(iOwner).iFaces = [elements(iOwner).iFaces iFace];
    elements(iOwner).faceSign=[elements(iOwner).faceSign 1];
    elements(iOwner).iNeighbours = [elements(iOwner).iNeighbours iNeighbour];
    %
    elements(iNeighbour).iFaces = [elements(iNeighbour).iFaces iFace];
    elements(iNeighbour).faceSign=[elements(iNeighbour).faceSign -1];
    elements(iNeighbour).iNeighbours = [elements(iNeighbour).iNeighbours iOwner];
end

for iBFace=numberOfInteriorFaces+1:numberOfFaces
    iOwner = faces(iBFace).iOwner;
    %
    elements(iOwner).iFaces = [elements(iOwner).iFaces iBFace];
    elements(iOwner).faceSign=[elements(iOwner).faceSign 1];
end


for iElement=1:numberOfElements;
    elements(iElement).numberOfNeighbours = length(elements(iElement).iNeighbours);
end


numberOfBElements = numberOfFaces - numberOfInteriorFaces;
numberOfBFaces = numberOfFaces - numberOfInteriorFaces;

%
% setup Node connectivities
%
for iFace=1:numberOfFaces
    
    iNodes = faces(iFace).iNodes;
    for iNode=iNodes
        nodes(iNode).iFaces = [ nodes(iNode).iFaces iFace];
    end
    
end

%
% setup Node connectivities
%
for iElement=1:numberOfElements
    
    iFaces = elements(iElement).iFaces;
    for iFace=iFaces
        iNodes = faces(iFace).iNodes;
        for iNode=iNodes
            if(sum(elements(iElement).iNodes == iNode)==0) % if iNode is not included in iNodes, then add it.
                elements(iElement).iNodes = [elements(iElement).iNodes iNode];
                nodes(iNode).iElements = [nodes(iNode).iElements iElement];
            end
        end
    end
    
end
% calculate cell centroids
for i=1:numberOfElements
    sum=[0;0;0];
    points=elements(i).iNodes;
    for j=1:length(points)
        sum=sum+nodes(points(j)).centroid;
    end
    centroid(i,:)=sum.'/length(points);
end


%% read data files
files=dir(".");
times=[];
for i=4:length(files)
    file=files(i).name;
    if (regexp(file(1) ,'[0-9]'))
        times=[times convertCharsToStrings(file)];
    end
end


for n=1:length(times)
    %% reading U Field
    U=[];
    time=char(times(n));
    fpid = fopen([time '/U'], 'r');
    for i=1:20
        fgetl(fpid);
    end
    numberOfPoints = fscanf(fpid, '%d',1);
    fgetl(fpid);
    fgetl(fpid);
    for i = 1:numberOfPoints
        fscanf(fpid, '%c',1);
        Ux=fscanf(fpid, '%f',1);
        Uy=fscanf(fpid, '%f',1);
        Uz=fscanf(fpid, '%f',1);
        fscanf(fpid, '%c',1);
        fscanf(fpid, '%c',1);
        U(i,:) = [Ux Uy Uz]';
    end
    fclose(fpid);
    %% reading VOF Field
    fpid = fopen([time '/alpha.water'], 'r');
    for i=1:20
        fgetl(fpid);
    end
    numberOfPoints = fscanf(fpid, '%d',1);
    fgetl(fpid);
    fgetl(fpid);
    vof= (fscanf(fpid, '%f\n',numberOfPoints));
    fclose(fpid);
    Data{n}.time=time;
    Data{n}.U=U;
    Data{n}.vof=vof;
end



 