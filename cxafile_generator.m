%% this filewill generate the xca file used by Fluent
fid=fopen(['C:\Users\dell\Desktop\'  '123.cxa'],'wt');
mm=500;
frame=1;
writeinfo{1,1}='AnimationSequence1.0';
writeinfo{2,1}='NAME: .\sequence-1';
writeinfo{3,1}='WINID: 0';
writeinfo{4,1}='STORAGE: 2';
writeinfo{5,1}=['FRAMES: ' num2str(mm)];
for i=1:3:mm*3
    if i<10
        ii=['000' num2str(i)];
    else if i>=10 && i<99
            ii=['00' num2str(i)];
             else if i>=99 && i<1000
                     ii=['0' num2str(i)];
                    else 
                            ii=['0' num2str(i-1+94)]  ;
                 end
        end
    end
writeinfo{frame+5,1}=['Frame ' num2str(frame-1) ' 2 sequence-1_' ii '.hmf 0'];
frame=frame+1;
end
for i=1:frame+4
writ=writeinfo{i};
fprintf(fid,'%s\n',writ);
end
fclose(fid);