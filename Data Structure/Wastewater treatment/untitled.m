x3=sin(linspace(-4,4,20));
y3=sin(linspace(-4,4,20));
for i=1:20
    for j=1:20
      T3(i,j)=x3(i)*y3(j);  
    end
end
imagesc(x3,y3,T3)