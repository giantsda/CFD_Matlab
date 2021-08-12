close all;

Index=[18 19 20 21 22 17 23 24, 10 11  12 13 14 9 15 16, 26 27 28 29 30 25 31 32, 34 35 36 37 38 33 39 40, 2 3 4 5 6 1 7 8, 42 43 44 45 46 41 47 48, 50 51 52 53 54 49 55 56];
U=[0.49266 0.049266 0.098532 0.197064 0.29559255 0.394128 0.591192 0.73899 0.772744031 0.077274403 0.154548806 0.309097612 0.463646418 0.618195225 0.927292837 1.159116046 0.742183211 0.074218321 0.148436642 0.296873284 0.445309927 0.593746569 0.890619853 1.113274816 0.618506754 0.061850675 0.123701351 0.247402702 0.371104052 0.494805403 0.742208105 0.927760131 0.523785507 0.052378551 0.104757101 0.209514194 0.314271292 0.419028389 0.628542583 0.785678229 0.475001175 0.047500118 0.095000235 0.19000047 0.285000705 0.38000094 0.57000141 0.712501763 0.470112776 0.047011278 0.094022555 0.18804511 0.282067665 0.376090221 0.564135331 0.705169164];
UCritical3=[0.1816593 0.023507537 0.034792595 0.079004932 0.10267047 0.15041758 0.19840291 0.22514294 0.24308228 0.048582751 0.075647742 0.17412852 0.17726409 0.19807421 0.28164992 0.3137331 0.255678 0.056178596 0.081783243 0.16730054 0.23381835 0.28817981 0.27205729 0.32537937 0.23483938 0.035331476 0.067042403 0.09507446 0.16233659 0.20358914 0.24572572 0.26188564 0.22999389 0.024630338 0.054041471 0.10148294 0.14328393 0.19293411 0.26490715 0.29514256 0.17817686 0.013400591 0.037786718 0.076904207 0.11522955 0.15227365 0.20500094 0.20169224 0.15163258 0.009178328 0.024383787 0.062817246 0.098247379 0.14252599 0.16204987 0.17774601];
criticalLength=[4.7352 8.0119 4.7752 4.6953 5.034 4.955 4.5354 5.3746 5.4132 1.5381 4.0748 4.6541 4.9937 5.7727 5.513 4.1148 5.4707 5.9499 4.732 3.3543 4.0931 6.5489 5.5706 5.1912 4.4558 2.7175 4.7755 4.6756 4.0962 5.1352 4.8155 5.1951 4.2571 1.9986 3.2178 4.7367 5.6161 4.7387 4.297 5.2764 4.7163 2.518 2.7379 3.9769 4.0368 4.3166 4.1767 5.1 3.5968 5.2753 2.9773 2.9973 3.2571 3.4369 3.417 3.9365];
Re=[155094.0617 18235.10093 32984.57603 65813.10284 97337.92661 130714.8176 167006.8443 194231.8321 88848.82659 18563.9001 29664.02421 56225.89588 68546.68628 74324.14441 103246.362 107251.8183 90496.40077 14892.19572 26048.75591 51726.4918 74758.06033 93205.40053 100654.2592 109968.1565 116985.3511 20091.36443 28354.39832 52270.28036 79554.76242 101699.4953 125447.5828 139645.2958 144216.4609 18027.56264 30851.16718 60777.56129 90240.33507 119809.2283 168932.3859 190640.8998 207672.3985 22634.27546 51766.72966 89114.62695 130440.7851 176063.3952 231246.1216 264384.2758 222026.4875 22760.47791 49538.99049 97147.53382 142055.5118 194444.6709 252904.0233 290972.1554];
De=[100867.5849 11859.45207 21451.97879 42802.4688 63305.07736 85012.20368 108615.2291 126321.3794 68822.00514 14379.53519 22977.65435 43552.39168 53096.03488 57571.2347 79974.28813 83076.90119 78197.82767 12868.32785 22508.69768 44696.79741 64598.34721 80538.671 86975.2205 95023.34764 88306.55094 15165.99369 21403.35602 39456.29201 60052.0203 76768.00192 94694.27797 105411.4409 103592.2525 12949.39433 22160.72895 43657.18335 64820.61423 86060.27182 121345.9703 136939.4319 109911.8887 11979.3289 27397.85869 47164.46205 69036.58432 93182.63014 122388.426 139926.9971 103690.2356 10629.53949 23135.57113 45369.58983 66342.39749 90809.04699 118110.5825 135889.063 ];
Dh=[0.448351648 0.448351648 0.448351648 0.448351648 0.448351648 0.448351648 0.448351648 0.448351648 0.24 0.24 0.24 0.24 0.24 0.24 0.24 0.24 0.224 0.224 0.224 0.224 0.224 0.224 0.224 0.224 0.307692308 0.307692308 0.307692308 0.307692308 0.307692308 0.307692308 0.307692308 0.307692308 0.381818182 0.381818182 0.381818182 0.381818182 0.381818182 0.381818182 0.381818182 0.381818182 0.571428571 0.571428571 0.571428571 0.571428571 0.571428571 0.571428571 0.571428571 0.571428571 0.654315789 0.654315789 0.654315789 0.654315789 0.654315789 0.654315789 0.654315789 0.654315789];
AR=[0.392156863 0.392156863 0.392156863 0.392156863 0.392156863 0.392156863 0.392156863 0.392156863 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 0.8 0.8 0.8 0.8 0.8 0.8 0.8 0.8 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.6 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.2 0.141891892 0.141891892 0.141891892 0.141891892 0.141891892 0.141891892 0.141891892 0.141891892];
meanMagU=[0.307869314000000,0.0361975680000000,0.0654759880000000,0.130642238000000,0.193220549000000,0.259475329000000,0.341516730000000,0.385559716000000,0.320741425000000,0.0640177150000000,0.102815588000000,0.195613002000000,0.259670185000000,0.288479929000000,0.364110234000000,0.395202550000000,0.374561565000000,0.0591698820000000,0.103497279000000,0.205520431000000,0.297029780000000,0.340324944000000,0.399920893000000,0.436926992000000,0.338380191000000,0.0581142710000000,0.0820150910000000,0.151191790000000,0.220112147000000,0.284165831000000,0.362857166000000,0.403923962000000,0.336161723000000,0.0420213890000000,0.0719126100000000,0.141669603000000,0.210345933000000,0.279269608000000,0.393773330000000,0.444374816000000,0.323449772000000,0.0352528870000000,0.0695000000000000,0.138796045000000,0.203161493000000,0.274218722000000,0.360165850000000,0.411778535000000,0.302000319000000,0.0309587940000000,0.0673828970000000,0.132140041000000,0.193223861000000,0.264483554000000,0.343999937000000,0.395780106000000];
mea=[0.238247639 0.029983405 0.058122966 0.107913867 0.160121166 0.20525198 0.264712628 0.305415325 0.255081032 0.057456061 0.090723018 0.164712365 0.225893185 0.214732068 0.295830038 0.334145625 0.283825987 0.044662294 0.074591521 0.161463526 0.229573367 0.282611288 0.308547833 0.314748563 0.27828587 0.04964304 0.069022593 0.12461063 0.183038609 0.236358104 0.301206417 0.332359955 0.270901732 0.035291303 0.06377416 0.114035354 0.166735072 0.226190851 0.30737667 0.361968889 0.250694771 0.027249383 0.068281571 0.103875876 0.150348384 0.204071933 0.279312478 0.315128547 0.223871845 0.025362939 0.05026922 0.095665831 0.139913853 0.192418913 0.257767068 0.297812347];
Upoints=[0.531275223 0.076567709 0.118185238 0.236056429 0.344942191 0.455338436 0.598460902 0.691971462 0.485675255 0.102711559 0.170362006 0.318888607 0.409708661 0.393355111 0.520542183 0.578114325 0.568931544 0.098457694 0.167239628 0.322666045 0.460520587 0.563978982 0.625084488 0.623569879 0.532116739 0.10303005 0.127940949 0.235218612 0.3694383 0.452138919 0.593309646 0.667537713 0.561264362 0.074051249 0.11825378 0.233140751 0.345079807 0.465610923 0.635437992 0.748024984 0.568330829 0.066673547 0.12591398 0.241482543 0.375661654 0.491176435 0.667689814 0.764481539 0.556485505 0.058824726 0.123273992 0.2544612 0.360844335 0.48253498 0.642250495 0.728011751 ];
meanUx=[0.251135886 0.030959858 0.054238059 0.124207377 0.192117557 0.232125521 0.286593616 0.337852389 0.284682542 0.075104162 0.104323618 0.172986269 0.227484092 0.232617617 0.326621294 0.357801437 0.273528576 0.044977859 0.079685651 0.163649425 0.230171815 0.280658096 0.304466426 0.309143692 0.291665643 0.04917594 0.0702198 0.143430442 0.200897112 0.257664144 0.319807768 0.371405512 0.288362682 0.036988474 0.066038162 0.127724558 0.179661721 0.232735351 0.318655163 0.40350005 0.363807797 0.021172497 0.07091514 0.14504008 0.184326112 0.268047988 0.387241542 0.410324603 0.279887229 0.02639382 0.053177346 0.096992537 0.183373734 0.251027137 0.331561774 0.359811723];
A=[0.51 0.51 0.51 0.51 0.51 0.51 0.51 0.51 0.18 0.18 0.18 0.18 0.18 0.18 0.18 0.18 0.14 0.14 0.14 0.14 0.14 0.14 0.14 0.14 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.35 0.35 0.35 0.35 0.35 0.35 0.35 0.35 1 1 1 1 1 1 1 1 1.48 1.48 1.48 1.48 1.48 1.48 1.48 1.48];
UCritical3R=[0.245800781 0.028417969 0.043066406 0.106738281 0.174707031 0.212011719 0.273535156 0.316308594 0.330761719 0.041699219 0.092089844 0.182324219 0.256933594 0.253613281 0.349902344 0.387207031 0.370996094 0.071191406 0.103027344 0.212402344 0.304785156 0.383691406 0.435424805 0.483764648 0.325683594 0.033691406 0.058300781 0.139746094 0.203027344 0.273535156 0.349902344 0.350097656 0.318652344 0.031152344 0.049707031 0.116113281 0.179785156 0.299902344 0.37487793 0.387402344 0.21862793 0.006933594 0.099902344 0.088964844 0.143066406 0.156347656 0.231738281 0.252636719 0.158496094 0.003808594 0.028027344 0.061425781 0.101660156 0.131152344 0.199902344 0.187011719];
UCritical4R=[0.181916455318800,0.0225444787563000,0.0417157462437000,0.0862105368687000,0.123635499368700,0.156727560000000,0.206924091556200,0.226041960000000,0.267402344000000,0.0327148440000000,0.0749023440000000,0.144433594000000,0.199902344000000,0.221605469000000,0.293550781000000,0.334667969000000,0.312011719000000,0.0418554690000000,0.0819335940000000,0.174902344000000,0.246191406000000,0.284902344000000,0.347949219000000,0.385839844000000,0.243652344000000,0.0315429690000000,0.0547851560000000,0.114746094000000,0.155902344000000,0.192402344000000,0.266113281000000,0.278027344000000,0.216902344000000,0.0190429690000000,0.0405273440000000,0.0981445310000000,0.149902344000000,0.181152344000000,0.234863281000000,0.260000000000000,0.153808594000000,0.0128000000000000,0.0337000000000000,0.0592773440000000,0.0889648440000000,0.128402344000000,0.181152344000000,0.184277344000000,0.119902344000000,0.00380859400000000,0.0196000000000000,0.0456523440000000,0.0686523440000000,0.102441406000000,0.134863281000000,0.145214844000000];
De2=[161410.7738  16141.07738  32282.15475  64564.3095  96845.33392  129128.619  193692.9285  242116.1606  161410.7737  16141.07737  32282.15473  64564.30946  96846.4642  129128.6189  193692.9284  242116.1605  161410.7738  16141.07738  32282.15475  64564.3095  96846.46425  129128.619  193692.9285  242116.1606  161410.7734  16141.07734  32282.15468  64564.30935  96846.46403  129128.6187  193692.9281  242116.1601  161410.7734  16141.07734  32282.15448  64564.30682  96846.46024  129128.6136  193692.9205  242116.1506  161410.7742  16141.07742  32282.15484  64564.30967  96846.46451  129128.6193  193692.929  242116.1613  161410.7741  16141.07741  32282.15483  64564.30965  96846.46448  129128.6193  193692.929  242116.1612  ];
UCritical4RO=[0.188842773 0.028442383 0.040405273 0.089477539 0.13659668 0.157104492 0.21496582 0.252807617 0.284545898 0.032592773 0.07409668 0.14440918 0.20300293 0.195678711 0.289428711 0.334594727 0.311889648 0.051879883 0.08190918 0.16394043 0.24621582 0.32800293 0.34777832 0.385864258 0.24206543 0.03137207 0.05480957 0.115112305 0.147338867 0.18737793 0.265991211 0.277954102 0.24987793 0.019165039 0.040649414 0.098266602 0.14831543 0.181518555 0.234741211 0.284057617 0.153930664 0.006958008 0.043823242 0.059204102 0.088745117 0.137329102 0.18737793 0.18737793 0.24987793 0.00378418 0.003295898 0.04284668 0.068237305 0.102416992 0.132202148 0.14831543 ];

MeanCU3=[0.157630548 0.021866539 0.03488312 0.068092587 0.089963798 0.132324461 0.172164326 0.194994582 0.229036527 0.059941123 0.075893822 0.161279454 0.1798 0.181776447 0.268582439 0.300301804 0.220445527 0.054278195 0.090789269 0.177482506 0.246001444 0.297872328 0.243597465 0.308456387 0.206841712 0.042748828 0.066311295 0.085785975 0.146040037 0.18820329 0.2110754 0.232911981 0.212501464 0.026780328 0.05468242 0.092603145 0.130383502 0.182232202 0.252831826 0.266492484 0.181279178 0.0126932 0.041960049 0.070045622 0.106570489 0.143144341 0.184209093 0.170985805 0.143603117 0.008097734 0.02334262 0.062072625 0.094166454 0.134116393 0.149918473 0.165252502 0.127764022 0.222826721 0.188992102 0.20411827 0.159695136 0.146643468 ];



UCritical3= UCritical3(Index);
De=De(Index);
De2=De2(Index);
Re=Re(Index);
U=U(Index);
AR=AR(Index);
Dh=Dh(Index);
A=A(Index);
meanMagU=meanMagU(Index);
meanUx=meanUx(Index);
MeanCU3=MeanCU3(Index);
UCritical4R=UCritical4R(Index);
UCritical3R=UCritical3R(Index);
mea=mea(Index);
Upoints=Upoints(Index); % max velocity at x=R cross section. Because meanMagU is hard to get without doing simulations, we mesuew Upoints and multiply it by 60%.
UCritical4RO=UCritical4RO(Index);

% plot(UCritical4R);
% hold on;
% plot(UCritical4RO);

plot(criticalLength);


% plot(meanMagU./Upoints,'*-')
% UCritical3R([1,9,17,25,33,41,49]+0)=NaN;
% haha([1,9,17,25,33,41,49]+1)=NaN;
% UCritical3R([1,9,17,25,33,41,49]+7)=NaN;
% plot(UCritical3R,'*-')
% hold on;
% plot(UCritical4R,'o-')



% meanMagU([1 9 17 25 33 41 49]+0)=NaN;
% meanMagU([1 9 17 25 33 41 49]+7)=NaN;
% U([1 9 17 25 33 41 49]+7)=NaN;
% U([1 9 17 25 33 41 49]+7)=NaN;
% UCritical4R([1 9 17 25 33 41 49]+7)=NaN;
% UCritical4R([1 9 17 25 33 41 49]+7)=NaN;

plot(meanMagU,'*-');
hold on;
plot(U,'*-');
plot(UCritical4R,'.-');
plot(meanMagU./U,'*-');
plot(UCritical4R./U,'ko-');
plot(UCritical4R./meanMagU,'r^-');
legend('meanMagU','U','UCritical4R','meanMagU./U','UCritical4R./U','UCritical4R./meanMagU')

 
i=5;

% cftool( meanMagU([1:8]+8*i), UCritical4R([1:8]+8*i));

cftool( U([1:8]+8*i), UCritical4R([1:8]+8*i));
% cftool( U([1:8]+8*i)-U(4+8*i), UCritical4R([1:8]+8*i)-UCritical4R(4+8*i))

% figure;
% for i=0:6
%     plot( De([1:8]+8*i),UCritical4R([1:8]+8*i), '*-');
% %         plot( U([1:8]+8*i), mea([1:8]+8*i),'*-');
%     hold on;
% %     axis equal;
% end
% legend('2','1','0.8','0.6','0.4','0.2','0.14')
% i=6;
% cftool( U([1:8]+8*i), meanMagU([1:8]+8*i));

AR=[2,1,0.8,0.6,0.4,0.2,0.141891892];
Dh=[ 0.224 0.24 0.307692308 0.381818182 0.448351648 0.571428571 0.654315789];
Dh2R=2./(2+1./AR)
k=[ 0.8227 0.7609 0.7157 0.6598 0.619 0.4628 0.3846];
% plot(Dh,k,'*-');
hold on;
plot(De,k,'*-');
cftool(Dh2R,k)