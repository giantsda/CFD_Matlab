TipVelocity=[0.0523785510000000	0.104757101000000	0.209514194000000	0.314271292000000	0.419028389000000	0.523785507000000	0.628542583000000	0.785678229000000];
AveragedVelocity=[0.0420213890000000	0.0719126100000000	0.141669603000000	0.210345933000000	0.279269608000000	0.336161723000000	0.393773330000000	0.444374816000000];
CriticalVelocity=[0.0190429690000000	0.0405273440000000	0.0981445310000000	0.149902344000000	0.181152344000000	0.216902344000000	0.234863281000000	0.260159643000000];



% plot(TipVelocity);
% hold on;
% plot(AveragedVelocity);
% plot(CriticalVelocity);
% cftool(TipVelocity,AveragedVelocity)
plot(TipVelocity,AveragedVelocity,'*-')