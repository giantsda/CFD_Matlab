x =linspace(0,1,100);
y=x;
[X,Y] = meshgrid(x,y);
Z=(1-X).*(1-Y);
surf(X,Y,Z)
hold on;
y=linspace(-1,0,100);
[X,Y] = meshgrid(x,y);
Z=(1-X).*(1+Y);
surf(X,Y,Z)
x=linspace(-1,0,100);
[X,Y] = meshgrid(x,y);
Z=(1+X).*(1+Y);
surf(X,Y,Z)
y=linspace(0,1,100);
[X,Y] = meshgrid(x,y);
Z=(1+X).*(1-Y);
surf(X,Y,Z)