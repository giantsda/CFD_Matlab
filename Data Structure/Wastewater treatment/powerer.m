%**************************************************************************
% Name : powerer
% Fu n c t i o n : for a given value of O2_requirement, calcuate the
% value of powe_reqire (Kw).
% Author : Chen.Shen 2015
%**************************************************************************
function powe_reqire=powerer(O2_requirement) % for any given value of O2_requirement
% calculate the power requirement 
O2_requirement=O2_requirement/0.001/1000000;% convert units to kg
SOTE=2.0;   %kg O2/ Kwhr
alpha=0.5; % for  diffused aeration
beta=0.95;
cg=0.8*0.21;
H_O2=10^(0.914-750/(10+273));
c_l_star=cg/H_O2;
c_l=2;
FOTE=SOTE*1.035^(10-20)*alpha*(beta*c_l_star-c_l)/9.2;
powe_reqire=O2_requirement/FOTE/24; % unit is kw 
% end
