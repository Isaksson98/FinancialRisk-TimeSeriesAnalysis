filename='Data.xlsx';

weekly = xlsread(filename, 'Weekly');
daily = xlsread(filename, 'Daily');

figure(1)
title('weekly data')
xlabel('Time Stamp')
yyaxis left
ylabel('SEK')
plot(weekly(:,1)) 

yyaxis right
%ylabel('SEK')
plot(weekly(:,2)) 
legend({'OMX','USD/SEK'},'Location','northwest','Orientation','vertical')

%% Calculate returns
trade_weeks = 52;
trade_days = 250;


[mean_u_OMX_yearly, u_OMX_weekly]= calc_returns(weekly,trade_weeks);
[mean_u_USD_yearly, u_USD_weekly]= calc_returns(weekly,trade_weeks);

[mean_u_OMX_yearly_2, u_OMX_daily]= calc_returns(daily,trade_days);
[mean_u_USD_yearly_2, u_USD_daily]= calc_returns(daily,trade_days);

figure(2)
title('log data')
xlabel('Time Stamp')
yyaxis left
ylabel('SEK')
plot(u_OMX_weekly) 

yyaxis right
ylabel('SEK')
plot(u_USD_weekly) 
legend({'OMX','USD/SEK'},'Location','northwest','Orientation','vertical')

%% Calculate volatility
n = length(weekly(:,2));
m = n-1;

sigma_OMX_weekly = calc_sigma(u_OMX_weekly,m,n,trade_weeks)
sigma_USD_weekly = calc_sigma(u_USD_weekly,m,n,trade_weeks)


n = length(daily(:,2));
m = n-1;

sigma_OMX_daily = calc_sigma(u_OMX_daily,m,n,trade_days)
sigma_USD_daily = calc_sigma(u_OMX_daily,m,n,trade_days)

%% Confidence interval

alpha = 0.975
conf_interval_lower = mean_u_OMX_yearly - sigma_OMX_weekly*norminv(alpha)
conf_interval_upper = mean_u_OMX_yearly + sigma_OMX_weekly*norminv(alpha)

exp( mean_u_OMX_yearly/sqrt(52) )*sqrt(52);

%% 1 b) i

skevhet = mean( ( (u_OMX_weekly - mean_u_OMX_yearly*sqrt(trade_weeks))/sigma_OMX_weekly*sqrt(trade_weeks) ).^3 )

excess = mean( ( (u_OMX_weekly - mean_u_OMX_yearly*sqrt(trade_weeks))/sigma_OMX_weekly*sqrt(trade_weeks) ).^4 )-3

%%  1 b) ii

histfit(u_OMX_weekly);

p = 99; %unit percent
prctile(u_OMX_weekly,p)
median(u_OMX_weekly)

%% 1 b) ii

figure(5)
delta_t = 1/52;
qq_plot(u_OMX_weekly, sigma_OMX_weekly, delta_t)

figure(6)
qqplot(u_OMX_weekly/std(u_OMX_weekly))

%% 2 a)

m = 90;
std_deviation = EqWMA(u_OMX_weekly,m, trade_weeks);
sqrt(std_deviation)

%% 2 b)
m = 90;
lambda = 0.94;
std_deviation = EWMA(u_OMX_weekly,m, trade_weeks, lambda);
sqrt(std_deviation)

%% 2 c)

fun = @(x)w+a*u_OMX_daily^2 + b*sigma_OMX_daily^2; %function of GARSH(1,1) model
res = fmincon(fun)







%% 3 a)

corr_weekly = corr(u_OMX_weekly,weekly(:,2))


%% 3 b)

num = 250;
a_c = zeros(num,1);
for i = 1:num
    a_c(i) = auto_correlation(u_OMX_weekly, i, sigma_OMX_weekly);
end

%scatter(1:num,a_c)

num2=zeros(250,1)
for k = 1:250

    length(u_OMX_daily(1:end-k))
    length(u_OMX_daily(k+1:end))
    num2(k) = (corr(u_OMX_daily(1:end-k), u_OMX_daily(k+1:end)));
end

scatter(1:250,num2)


%%

k = 5;
num3 = u_OMX_weekly(1:end-k);
num4 = u_OMX_weekly(k+1:end);







