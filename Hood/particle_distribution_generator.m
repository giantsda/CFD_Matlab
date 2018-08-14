m = 0.5; % Unit is micron.
sigma_g=1.97;
sigma =log(sigma_g);
v=(exp(sigma*sigma)-1)*m*m;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));

X = lognrnd(mu,sigma,1,200000000);

% while(1)
%     X = lognrnd(mu,sigma,1,20000);
%     hist(X,200);
% %     mean(X)
% %     exp(std(log(X)))
% haha=find(X<0.20);
% length(haha)/20000
% min(X )
%     pause()
% end


% haha=find(X<0.005)
% X(haha)=[];
% haha=find(X>9)
% X(haha)=[];
% save('r_sample.mat','X')

