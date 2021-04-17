
% Ucritical3=[0.15232993 0.023022675 0.036143176 0.064585776 0.088015825 0.112139283 0.170710726 0.179259116 0.173909492 0.054838321 0.072916895 0.142829801 0.150849245 0.164898011 0.22209371 0.226708302 0.217736612 0.047318544 0.091096255 0.166495402 0.235283825 0.204269635 0.229288037 0.222852492 0.205650177 0.03670973 0.059580538 0.086599503 0.147273859 0.194161022 0.217932364 0.202436713 0.218204022 0.027426769 0.055692535 0.080884019 0.112907434 0.154744947 0.229276849 0.249921606 0.152215079 0.013476136 0.032365962 0.06061071 0.092489329 0.132386115 0.183825367 0.01313738 0.15505604 0.007188461 0.021294314 0.058972949 0.094509016 0.134041249 0.171903445 0.166350353];
% for i=1:length(resultsnew)
%      if ~isempty(resultsnew{i})
%          if i==2
%              continue;
%          end
%      Ucritical=resultsnew{i}.UcriticalS;
%      percentage=resultsnew{i}.percentage;
%      plot(Ucritical,percentage);
%      hold on;
% %      perUcritical = interp1(Ucritical,percentage,Ucritical3(i),'spline','extrap')*1.3;
% %      plot(Ucritical3(i),perUcritical,'*')
%      end
% end


for i=1:length(resultsnew)
    if ~isempty(resultsnew{i})
        if i==2
            continue;
        end
        Ucritical=resultsnew{i}.UcriticalS;
        percentage=resultsnew{i}.percentage;
        haha=Ucritical.*percentage;
        plot(Ucritical,haha);
        hold on;
%         perUcritical = interp1(Ucritical,percentage,Ucritical3(i),'spline','extrap')*1.3;
%         plot(Ucritical3(i),perUcritical,'*')
    end
end