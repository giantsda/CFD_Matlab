orginalH=1e-7;
orginalOH=1e-7;
for i=1:7
Hconsumption=0.0317;
a=1;
b=orginalOH+orginalH-Hconsumption;
c=-1e-14+orginalOH*(orginalH-Hconsumption);
delta=sqrt(b*b-4*a*c);
x1=(-b+delta)/2/a;
x2=(-b-delta)/2/a;
nowH=orginalH-Hconsumption+x1;
nowOH=orginalOH+x1;
i
nowPH=-log10(nowH)
orginalH=nowH;
orginalOH=nowOH;
end



