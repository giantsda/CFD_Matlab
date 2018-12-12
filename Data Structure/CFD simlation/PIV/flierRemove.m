%% this file generate figs of all frame

function flierRemove(path,criticalDistance)
filePattern='*_A.*';
files=dir([path filePattern]);
for i=1:length(files)
    fileA=files(i).name;
    fileB=strrep(fileA,'_A','_B');
    if (~exist([path fileB]))
        error([fileA ' exists but ' fileB ' does not exist! \n']);
    end
end
fprintf('Checked: file A-B pattern OK. \n');
fprintf('Removing filer. \n');

%%
parfor_progress(length(files)); % Set the total number of iterations
for i=1:length(files)
    fileA=files(i).name;
    fileB=strrep(fileA,'_A','_B');
    I1 =imread([path fileA]);
    I2=imread([path fileB]);
    I1=logical(I1);   % convert to binary figure
    I2=logical(I2);
    re1 = regionprops(I1,'centroid');
    re2 = regionprops(I2,'centroid');
    c1=zeros(length(re1),2);
    c2=zeros(length(re2),2);
    for j=1:length(re1)
        c1(j,:)=re1(j).Centroid;
    end
    for j=1:length(re2)
        c2(j,:)=re2(j).Centroid;
    end
    %% Now, c1 and c2 contains the position of all particles, ready for filter
    rowC1=[];
    rowC2=[];
    for j=1:length(c1)  % loop over all points of c1
        dMin=100000;
        for k=1:length(c2)
            d=norm(c1(j,1:2)-c2(k,1:2));
            if d<dMin
                dMin=d;
                kMin=k;
            end
        end
        if dMin<criticalDistance
            rowC1=[rowC1;j];
            rowC2=[rowC2;kMin];
        end
    end
    c1=c1(rowC1,:);
    c2=c2(rowC2,:);
    I1(:)=0;
    I2(:)=0;
    
    partleSize=1;  % 2*partleSize+1 will be the diameter.
    for j=1:length(c1)
        x=round(c1(j,1));
        y=round(c1(j,2));
        I1(y-partleSize:y+partleSize,x-partleSize:x+partleSize)=1;
    end
    for j=1:length(c2)
        x=round(c2(j,1));
        y=round(c2(j,2));
        I2(y-partleSize:y+partleSize,x-partleSize:x+partleSize)=1;
    end
    I1= uint8(255 * I1);  % Convert back to gray scale.
    I2= uint8(255 * I2);  % Convert back to gray scale.
        
    correlation=length(rowC1)/length(re1)
  
    if correlation<=0.8
        fprintf(['Pair' fileA ' Correlation is smaller than 0.8. Check it. Press any button to continue\n' ]);
%         pause();
    end
    imwrite(I1,[path fileA]);
    imwrite(I2,[path fileB]);
%     parfor_progress;
end
parfor_progress(0);