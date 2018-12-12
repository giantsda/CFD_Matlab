%**************************************************************************
% Name : run_ca_ni_rea
% Fu n c t i o n :  run all the system for different value
% of sita_C and sita_nit in order to study the impact on the performance
% Author : Chen.Shen 2015
%**************************************************************************
function run_ca_ni_rea (lll)
clear
clc
plot_number=1;
     res=[]; 
    i=1 ; 
            for sitax_C=2.5 :2.5:15
                j=1;
                    for sitax_nit=3:0.01:60
                        [res]=ca_ni_rea(sitax_C,sitax_nit );
                            sitax_C=res(1,:);
                            R1=res(2,:);
                            Xv=res(3,:);
                            O2_requirement_C=res(4,:);
                            S_C=res(5,:);
                            S_NH4=res(6,:);
                            S_NO2=res(7,:);
                            Rw_C=res(8,:);
                            R2=res(11,:);
                            Xv_nit=res(12,:);
                            O2_requirement_nit=res(13,:);
                            Total_effluent_TIN=res(14,:);
                            Rw_nit=res(15,:);                 
                        result_R1(i,j)=R1;
                        result_Xv(i,j)=Xv;
                        result_O2_requirement_C(i,j)=O2_requirement_C;
                        result_S_C(i,j)=S_C;
                        result_S_NH4(i,j)=S_NH4;
                        result_S_NO2(i,j)=S_NO2;
                        result_Rw_C(i,j)=Rw_C;
                        result_R2(i,j)=R2;
                        result_Xv_nit(i,j)=Xv_nit;
                        result_O2_requirement_nit(i,j)=O2_requirement_nit;
                        result_Total_effluent_TIN(i,j)=Total_effluent_TIN;
                        result_Rw_nit(i,j)=Rw_nit;
                                 j=j+1;
                    end
                i=i+1;
            end
            sitax_C=2.5 :2.5:15;
            sitax_nit=3:0.01:60;
           size_C=size(sitax_C);
           size_C=size_C(2)
 %         
        subplot(2,2,1);
        for ii=1:size_C
                plot(sitax_nit, result_R2(ii,:));
                hold on;
                xlabel('\theta_x_,_n_i_t (day)');
                ylabel('Value of R2');
                title('Value of  R2'); 
        end
        legend('\theta_x_c=2.5','\theta_x_c=5','\theta_x_c=7.5','\theta_x_c=10','\theta_x_c=12.5','\theta_x_c=15');
%%         
         subplot(2,2,2);
         for ii=1:size_C
                plot(sitax_nit, result_O2_requirement_nit(ii,:)/0.001/1000000);
                hold on;
                xlabel('\theta_x_,_n_i_t (day)');
                ylabel('O2 reqirement (kg)');
                title(' O2 reqirement');
         end
        legend('\theta_x_c=2.5','\theta_x_c=5','\theta_x_c=7.5','\theta_x_c=10','\theta_x_c=12.5','\theta_x_c=15');

 %%
         subplot(2,2,3);
         for ii=1:size_C
                plot(sitax_nit, result_Total_effluent_TIN(ii,:));                   
                hold on;
                xlabel('\theta_x_,_n_i_t (day)');
                ylabel('Total effluent TIN (mg/L)');
                title('Total effluent TIN');
         end
        legend('\theta_x_c=2.5','\theta_x_c=5','\theta_x_c=7.5','\theta_x_c=10','\theta_x_c=12.5','\theta_x_c=15');

%%
         subplot(2,2,4);
         for ii=1:size_C
                plot(sitax_nit, result_Rw_nit(ii,:));          
                hold on;
                xlabel('\theta_x_,_n_i_t (day)');
                ylabel('waste flow rate of nitrification reactor(m3/day)');
                title('waste flow rate of nitrification reactor');
         end
        legend('\theta_x_c=2.5','\theta_x_c=5','\theta_x_c=7.5','\theta_x_c=10','\theta_x_c=12.5','\theta_x_c=15');
       suptitle ('Performance of the system when \theta_x_c and \theta_x_,_n_i_t varies')
 end
         