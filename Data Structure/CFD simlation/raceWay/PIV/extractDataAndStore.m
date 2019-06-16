path='E:\desktop\temp\PIV\333\';
if (exist('stored','var')==0)   % prevent running this block twice
    u=cell( size(u_filtered));  % initialize
    v=cell( size(u_filtered));
    for i=1:length(u_filtered)
        u{i,1}=flip(u_filtered{i,1},1);   %this is how PIVlab data is stored
        v{i,1}=-flip(v_filtered{i,1},1);
    end
    stored=1;
    
    disp('writting all data to PIVData.............. \n');
    clearvars -except u v path frameStore x y stored
    save([path 'PIVData.mat'], '-v7.3');
    disp('store all data to PIVData.............. \n');
end

%% plot
figure;
for i=1:length(u)
    quiver(x{i,1},y{i,1},u{i,1},v{i,1});
    axis tight;
    pause()
end
