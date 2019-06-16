file_path='E:\desktop\CFD\Raceway_pond_and_Peers_PBR_03132016--\06252017\42\data\'
figure;
set(gcf,'outerposition',get(0,'screensize'));
value_s=zeros(400,400);
files = dir([file_path 'save*']);
pause();
for i=1:length(files)
    i
    filenam=[file_path 'save' num2str(i)];
    load(filenam) ;
    load( 'empty')
    value_s(empty)=nan;
%     value_s=x;
    value_s=(value_s+x);
    N=400;
    x_mesh=linspace(-1.6,1.6,N);
    y_mesh=linspace(-0.6,0.6,N);
    z_mesh=linspace(0.03,0.17,5);
    [x1,y1]=meshgrid(x_mesh,y_mesh);
    pcolor(x1,y1,value_s);
    shading interp;
    axis equal
    colormap jet
    colorbar
    view(180,-90)
    pause(0.3)
end