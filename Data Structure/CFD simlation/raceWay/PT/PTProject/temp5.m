
close all;
a=[  3 4 5 6 1 7  ];
% index=[a a+8 a+8*2 a+8*3 a+8*4 a+8*5 a+8*6];
plot(lamda(a),maxS(a),'*-')
hold on;
plot(lamda(a+8),maxS(a+8),'*-')
plot(lamda(a+16),maxS(a+16),'*-')
plot(lamda(a+24),maxS(a+24),'*-')
plot(lamda(a+32),maxS(a+32),'*-')
plot(lamda(a+40),maxS(a+40),'*-')
plot(lamda(a+48),maxS(a+48),'*-')
legend('1','2','3','4','5','6','7')
fileName="C:\Users\chenshen.ETS01297\Desktop\temp\plot\PT\fig7.csv";
write=[lamda.' maxS.'];

csvwrite(fileName,write);


