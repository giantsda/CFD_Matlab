% %% Read mesh, do not need if only interested in data files.
% pointsFile = ["constant/polyMesh/points"];
% facesFile = ['constant/polyMesh/faces'];
% ownerFile = ['constant/polyMesh/owner'];
% neighbourFile = ['constant/polyMesh/neighbour'];
% boundaryFile = ['constant/polyMesh/boundary'];
%
% %
% %readPoints
% %
% fpid = fopen(pointsFile, 'r');
% for i=1:18
%     fgetl(fpid);
% end
% numberOfPoints = fscanf(fpid, '%d',1);
% A = fread(fpid,2);
% A =fread(fpid,numberOfPoints*3,'*double');
% A=reshape(A,3,[]).';
%
% for n = 1:numberOfPoints
%     nodes(n).centroid = A(n,:).';
%     nodes(n).index = n;
%     nodes(n).iFaces=[];
%     nodes(n).iElements=[];
% end
% fclose(fpid);
% %
% %read Faces
% %
% ffid = fopen(facesFile, 'r');
% for i=1:18
%     fgetl(ffid);
% end
% numberOfFaces  = fscanf(ffid, '%d',1);
% fread(ffid,2,'*int8');
% A =fread(ffid,numberOfFaces,'*int32');
% dec2hex(fread(ffid,2,'*int8'));
% numberOfFaces2  = fscanf(ffid, '%d',1);
% dec2hex(fread(ffid,2,'*int8'));
% B =fread(ffid,numberOfFaces2,'*int32');
%
% % read each set of measurements
% for n = 1:numberOfFaces-1
%     theNumberOfPoints = A(n+1)-A(n);
%     faces(n).iNodes=B(A(n)+1:A(n+1))'+1;
%     faces(n).index=n;
%     faces(n).iOwner = -1;
%     faces(n).iNeighbour = -1;
% end
% fclose(ffid);
%
% %
% %read owners
% %
% foid = fopen(ownerFile, 'r');
% %header = textscan(fpid,'%s',18,'EndOfLine','\n')
% numberOfOwners = textscan(foid,'%d',1,'HeaderLines',18);
% numberOfOwners = numberOfOwners{1};
% dec2hex(fread(foid,2,'*int8'))
% A =fread(foid,numberOfOwners,'*int32');
% for n=1:numberOfOwners
%     faces(n).iOwner = A(n)+1;
%     faces(n).iNeighbour=-1;
% end
% numberOfElements = max([faces.iOwner]);
% fclose(foid);
% %
% %read neighbours
% %
% fnid = fopen(neighbourFile, 'r');
% %header = textscan(fpid,'%s',18,'EndOfLine','\n')
% numberOfNeighbours = textscan(fnid,'%d',1,'HeaderLines',18);
% numberOfNeighbours = numberOfNeighbours{1};
% dec2hex(fread(fnid,2,'*int8'))
% A =fread(fnid,numberOfOwners,'*int32');
% for n=1:numberOfNeighbours
%     faces(n).iNeighbour = A(n)+1;
% end
% numberOfInteriorFaces = numberOfNeighbours;
% fclose(fnid);
% %
% % construct elements
% %
% elements= [];
% for iElement=1:numberOfElements;
%     elements(iElement).index = iElement;
%     elements(iElement).iNeighbours = [];
%     elements(iElement).iFaces=[];
%     elements(iElement).iNodes=[];
%     elements(iElement).volume = 0.;
%     elements(iElement).faceSign=[];
%
% end
%
% for iFace=1:numberOfInteriorFaces
%     iOwner = faces(iFace).iOwner;
%     iNeighbour = faces(iFace).iNeighbour;
%     %
%     elements(iOwner).iFaces = [elements(iOwner).iFaces iFace];
%     elements(iOwner).faceSign=[elements(iOwner).faceSign 1];
%     elements(iOwner).iNeighbours = [elements(iOwner).iNeighbours iNeighbour];
%     %
%     elements(iNeighbour).iFaces = [elements(iNeighbour).iFaces iFace];
%     elements(iNeighbour).faceSign=[elements(iNeighbour).faceSign -1];
%     elements(iNeighbour).iNeighbours = [elements(iNeighbour).iNeighbours iOwner];
% end
%
% for iBFace=numberOfInteriorFaces+1:numberOfFaces-1
%     iOwner = faces(iBFace).iOwner;
%     %
%     elements(iOwner).iFaces = [elements(iOwner).iFaces iBFace];
%     elements(iOwner).faceSign=[elements(iOwner).faceSign 1];
% end
%
%
% for iElement=1:numberOfElements;
%     elements(iElement).numberOfNeighbours = length(elements(iElement).iNeighbours);
% end
%
%
% numberOfBElements = numberOfFaces - numberOfInteriorFaces;
% numberOfBFaces = numberOfFaces - numberOfInteriorFaces;
%
% %
% % setup Node connectivities
% %
% for iFace=1:numberOfFaces-1
%
%     iNodes = faces(iFace).iNodes;
%     for iNode=iNodes
%         nodes(iNode).iFaces = [ nodes(iNode).iFaces iFace];
%     end
%
% end
%
% %
% % setup Node connectivities
% %
% for iElement=1:numberOfElements
%
%     iFaces = elements(iElement).iFaces;
%     for iFace=iFaces
%         iNodes = faces(iFace).iNodes;
%         for iNode=iNodes
%             if(sum(elements(iElement).iNodes == iNode)==0) % if iNode is not included in iNodes, then add it.
%                 elements(iElement).iNodes = [elements(iElement).iNodes iNode];
%                 nodes(iNode).iElements = [nodes(iNode).iElements iElement];
%             end
%         end
%     end
%
% end
%
% %calculate cell centroids
% for i=1:numberOfElements
%     sum=[0;0;0];
%     points=elements(i).iNodes;
%     for j=1:length(points)
%         sum=sum+nodes(points(j)).centroid;
%     end
%     centroid(i,:)=sum.'/length(points);
% end


%% readDataFiles


% pathFolder="D:\CFD_second_HHD\02212020\130\1\1";
% files=dir(pathFolder);
% cd (pathFolder);
% times=[];
% for i=4:length(files)
%     file=files(i).name;
%     if (regexp(file(1:2) ,'[0-9][0-9]'))
%         times=[times convertCharsToStrings(file)];
%     end
% end
% 
% for n=1:length(times)
%     %% reading U Field
%     U=[];
%     time=char(times(n));
%     fprintf("reading data %s\n",time);
%     fpid = fopen([time '/U'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     U =fread(fpid,numberOfPoints*3,'*double');
%     U=reshape(U,3,[]).';
%     U=abs(U(:,3));
%     fclose(fpid);
%     %% reading VOF Field
%     fpid = fopen([time '/alpha.water'], 'r');
%     for i=1:20
%         fgetl(fpid);
%     end
%     numberOfPoints = fscanf(fpid, '%d',1);
%     dec2hex(fread(fpid,2,'*int8'));
%     vof= fread(fpid,numberOfPoints,'*double');
%     U(find(vof<0.01),:)=[];
%     fclose(fpid);
%     Data{n}.time=time;
%     Data{n}.U=U;
% %     Data{n}.vof=vof;
% end
 
% fprintf("Done with reading data.\n");
% Ucritical=0.0065;
% Percentage=getP(Ucritical,Data)
% Un=linspace(0,0.2,10);
% Pn=[];
% for i=1:length(Un)
%    Pn(i)= getP(Un(i),Data);
% end
% plot(Un,Pn);

% x0 = 0.06;
% Solution = fsolve(@getP,x0,[],Data)
% function Percentage=getP(Ucritical,Data)
% Ucritical;
%  for n=1:length(Data)
%     U=Data{n}.U;
%     P(n)=length(find(U>Ucritical))/length(U);
%  end
% Percentage=(mean(P)-0.15) 
% end


