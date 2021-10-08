x=linspace(0,10,10000)
y1=0;
y2=sin(x);

rmse=mean((y2-y1).^2)