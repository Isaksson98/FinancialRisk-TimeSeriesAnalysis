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
legend({'OMX','USD/SEK'},'Location','southeast','Orientation','vertical')
%% Calculate returns
trade_weeks = 52;
trade_days = 252;

u_OMX_weekly = calc_returns(weekly(:,1));
u_USD_weekly= calc_returns(weekly(:,2));

Mean_yearly_w_u_OMX = mean(u_OMX_weekly) * trade_weeks * 100
Mean_yearly_w_u_USD = mean(u_USD_weekly) * trade_weeks * 100

test = 1;

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

Volatilitet_w_OMX = calc_sigma(u_OMX_weekly,n,trade_weeks);
Volatilitet_w_USD = calc_sigma(u_USD_weekly,n,trade_weeks);

Volatilitet_yearly_w_OMX = Volatilitet_w_OMX  * sqrt(trade_weeks) * 100
Volatilitet_yearly_w_USD = Volatilitet_w_USD  * sqrt(trade_weeks) * 100

%% Confidence interval
Years_w = sqrt(length(u_OMX_weekly) / trade_weeks)

alpha = 0.975
conf_interval_lower_OMX = Mean_yearly_w_u_OMX - (Volatilitet_yearly_w_OMX / Years_w) * norminv(alpha)
conf_interval_upper_OMX = Mean_yearly_w_u_OMX + (Volatilitet_yearly_w_OMX / Years_w) * norminv(alpha)

conf_interval_lower_USD = Mean_yearly_w_u_USD - (Volatilitet_yearly_w_USD / Years_w) * norminv(alpha)
conf_interval_upper_USD = Mean_yearly_w_u_USD + (Volatilitet_yearly_w_USD / Years_w)* norminv(alpha)

%% 1 b) i - moment
skevhet_OMX_w = calc_moment(u_OMX_weekly, Volatilitet_w_OMX, 3)
excess_OMX_w = calc_moment(u_OMX_weekly, Volatilitet_w_OMX, 4) - 3

skevhet_USD_w = calc_moment(u_USD_weekly, Volatilitet_w_USD, 3)
excess_USD_w = calc_moment(u_USD_weekly, Volatilitet_w_USD, 4) - 3

u_OMX_daily = calc_returns(daily(:,1));
u_USD_daily = calc_returns(daily(:,2));

n = length(daily(:,2));

Volatilitet_d_OMX = calc_sigma(u_OMX_daily,n,trade_days);
Volatilitet_d_USD = calc_sigma(u_USD_daily,n,trade_days);

skevhet_OMX_d = calc_moment(u_OMX_daily, Volatilitet_d_OMX, 3)
excess_OMX_d = calc_moment(u_OMX_daily, Volatilitet_d_OMX, 4) - 3

skevhet_USD_d = calc_moment(u_USD_daily, Volatilitet_d_USD, 3)
excess_USD_d = calc_moment(u_USD_daily, Volatilitet_d_USD, 4) - 3

%%  1 b) ii - histfit och percentiler

figure(3)
subplot(2,2,1);
histfit(u_OMX_weekly)
title('Subplot 1: USD weekly');
subplot(2,2,2);
histfit(u_USD_weekly)
title('Subplot 2: USD weekly');
subplot(2,2,3);
histfit(u_OMX_daily)
title('Subplot 3: OMX daily');
subplot(2,2,4);
histfit(u_USD_daily)
title('Subplot 4: USD daily');

p = 99; %unit percent
prctile(u_OMX_weekly,p);
median(u_OMX_weekly);

percentile_OMX_w_1 = prctile(u_OMX_weekly, 1) %-0.0787
percentile_OMX_w_5 = prctile(u_OMX_weekly, 5) %-0.0491
percentile_OMX_w_95 = prctile(u_OMX_weekly, 95) %0.0450
percentile_OMX_w_99 = prctile(u_OMX_weekly, 99) %0.0752

p = 99; %unit percent
prctile(u_USD_weekly,p);
median(u_USD_weekly);

percentile_USD_w_1 = prctile(u_USD_weekly, 1) %-0.0367
percentile_USD_w_5 = prctile(u_USD_weekly, 5) %-0.0246
percentile_USD_w_95 = prctile(u_USD_weekly, 95) %0.0259
percentile_USD_w_99 = prctile(u_USD_weekly, 99) %0.0413

p = 99; %unit percent
prctile(u_OMX_daily,p);
median(u_OMX_daily);

percentile_OMX_d_1 = prctile(u_OMX_daily, 1) %-0.0787
percentile_OMX_d_5 = prctile(u_OMX_daily, 5) %-0.0491
percentile_OMX_d_95 = prctile(u_OMX_daily, 95) %0.0450
percentile_OMX_d_99 = prctile(u_OMX_daily, 99) %0.0752

p = 99; %unit percent
prctile(u_USD_daily,p);
median(u_USD_daily);

percentile_USD_d_1 = prctile(u_USD_daily, 1) %-0.0367
percentile_USD_d_5 = prctile(u_USD_daily, 5) %-0.0246
percentile_USD_d_95 = prctile(u_USD_daily, 95) %0.0259
percentile_USD_d_99 = prctile(u_USD_daily, 99) %0.0413

%% 1 b) iii

figure(4)
subplot(2,2,1);
qqplot(u_OMX_weekly)
title('Subplot 1: OMX weekly');
subplot(2,2,2);
qqplot(u_USD_weekly)
title('Subplot 1: USD weekly');
subplot(2,2,3);
qqplot(u_OMX_daily)
title('Subplot 1: OMX daily');
subplot(2,2,4);
qqplot(u_USD_daily)
title('Subplot 1: USD daily');

%% 2 a)

Historisk_volatilitet_EqWMA_OMX_30 = EqWMA(u_OMX_weekly, 30, trade_weeks);

Historisk_volatilitet_EqWMA_OMX_90 = EqWMA(u_OMX_weekly, 90, trade_weeks);

Historisk_volatilitet_EqWMA_USD_30 = EqWMA(u_USD_weekly, 30, trade_weeks);

Historisk_volatilitet_EqWMA_USD_90 = EqWMA(u_USD_weekly, 90, trade_weeks);

figure(5)
subplot(2,2,1);
plot(Historisk_volatilitet_EqWMA_OMX_30)
title('Subplot 1: Historisk volatilitet EqWMA OMX 30');
subplot(2,2,2);
plot(Historisk_volatilitet_EqWMA_OMX_90)
title('Subplot 2: Historisk volatilitet EqWMA OMX 90');
subplot(2,2,3);
plot(Historisk_volatilitet_EqWMA_USD_30)
title('Subplot 3: Historisk volatilitet EqWMA USD 30');
subplot(2,2,4);
plot(Historisk_volatilitet_EqWMA_USD_90)
title('Subplot 4: Historisk volatilitet EqWMA USD 90');

%% 2 b)

lambda = 0.94;
Risk_metrics_EWMA_OMX = Garch(u_OMX_weekly, 1 - lambda, lambda, 0); 
Risk_metrics_EWMA_USD = Garch(u_USD_weekly, 1 - lambda, lambda, 0); 

figure(6)
subplot(2,1,1);
plot(Risk_metrics_EWMA_OMX)
title('Subplot 1: RiskMetrics EWMA OMX');
subplot(2,1,2);
plot(Risk_metrics_EWMA_USD)
title('Subplot 2: RiskMetrics USD OMX');
%% 2 c)

%MLE Garch (1,1) utan variance targeting
[par_OMX, ll_OMX] = fmincon(@(x)MLE(x, weekly(:,1)), [0.09 0.8 0.0002], [1 1 0], 1, [], [], [0 0 0], []);
[par_USD, ll_USD] = fmincon(@(x)MLE(x, weekly(:,2)), [0.09 0.8 0.0002], [1 1 0], 1, [], [], [0 0 0], []);

par_OMX_print = [sqrt(par_OMX(3)*trade_weeks), par_OMX(1), par_OMX(2)];
par_USD_print = [sqrt(par_USD(3)*trade_weeks), par_USD(1), par_USD(2)];

par_OMX(3) = par_OMX(3) * (1 - par_OMX(1) - par_OMX(2));
par_USD(3) = par_USD(3) * (1 - par_USD(1) - par_USD(2));


%MLE Garch (1,1) med variance targeting
n = length(u_USD_weekly);
m = n - 1;

VL_OMX = calc_sigma(u_OMX_weekly,n,trade_weeks)^2;
VL_USD = calc_sigma(u_USD_weekly,n,trade_weeks)^2;

[par_OMX_vt, ll_OMX_vt] = fmincon(@(x)MLE(x, weekly(:,1)), [0.09 0.8 0.0002], [1 1 0], 1, [], [], [0 0 VL_OMX], [1 1 VL_OMX]);
[par_USD_vt, ll_USD_vt] = fmincon(@(x)MLE(x, weekly(:,2)), [0.09 0.8 0.0002], [1 1 0], 1, [], [], [0 0 VL_USD], [1 1 VL_USD]);

par_OMX_vt_print = [sqrt(par_OMX_vt(3)*trade_weeks), par_OMX_vt(1), par_OMX_vt(2)];
par_USD_vt_print = [sqrt(par_USD_vt(3)*trade_weeks), par_USD_vt(1), par_USD_vt(2)];

par_OMX_vt(3) = par_OMX_vt(3) * (1 - par_OMX_vt(1) - par_OMX_vt(2));
par_USD_vt(3) = par_USD_vt(3) * (1 - par_USD_vt(1) - par_USD_vt(2));

%MLE EWMA
[par_OMX_EWMA, ll_EWMA_OMX] = fmincon(@(x)MLE(x, weekly(:,1)), [0.5 0.3 1], [1 1 0], 1, [], [], [0 0 0], [1 1 0]);
[par_USD_EWMA, ll_EWMA_USD] = fmincon(@(x)MLE(x, weekly(:,2)), [0.5 0.3 1], [1 1 0], 1, [], [], [0 0 0], [1 1 0]);

%EWMA
EWMA_OMX = Garch(u_OMX_weekly, par_OMX_EWMA (1), par_OMX_EWMA (2), par_OMX_EWMA (3));

EWMA_USD = Garch(u_USD_weekly, par_USD_EWMA (1), par_USD_EWMA (2), par_USD_EWMA (3));

%Garch (1,1) utan variance targeting

Garch_OMX = Garch(u_OMX_weekly, par_OMX (1), par_OMX (2), par_OMX (3));

Garch_USD = Garch(u_USD_weekly, par_USD (1), par_USD (2), par_USD (3));


%Garch (1,1) med variance targeting
Garch_OMX_vt = Garch(u_OMX_weekly, par_OMX_vt (1), par_OMX_vt (2), par_OMX_vt (3));
sigma_OMX_vt = Garch_OMX_vt(length(Garch_OMX_vt))

Garch_USD_vt = Garch(u_USD_weekly, par_USD_vt (1), par_USD_vt (2), par_USD_vt (3));
sigma_USD_vt = Garch_USD_vt(length(Garch_USD_vt))

figure(9)
subplot(3,2,1);
plot(EWMA_OMX * 100 * sqrt(trade_weeks))
title('Subplot 1: sigma EWMA OMX');

subplot(3,2,2);
plot(EWMA_USD * 100 * sqrt(trade_weeks))
title('Subplot 2: sigma EWMA USD');

subplot(3,2,3);
plot(Garch_OMX * 100 * sqrt(trade_weeks))
title('Subplot 3: sigma GARCH OMX');

subplot(3,2,4);
plot(Garch_USD * 100 * sqrt(trade_weeks))
title('Subplot 4: sigma GARCH OMX');

subplot(3,2,5);
plot(Garch_OMX_vt * 100 * sqrt(trade_weeks))
title('Subplot 5: sigma GARCH OMX vt');

subplot(3,2,6);
plot(Garch_USD_vt * 100 * sqrt(trade_weeks))
title('Subplot 6: sigma GARCH USD vt');

%% 2 d)

OMX_scaled = zeros(length(u_OMX_weekly), 1); %måste vara standard normalfördelad

for i = 3:length(u_OMX_weekly)
OMX_scaled(i) = u_OMX_weekly(i) / Garch_OMX(i);
end

USD_scaled = zeros(length(u_USD_weekly), 1);

for i = 3:length(u_USD_weekly)
USD_scaled(i) = u_USD_weekly(i) / Garch_USD(i);
end

figure(10)

subplot(1,2,1);
qqplot(OMX_scaled)
title('Subplot 1: GARCH OMX');

subplot(1,2,2);
qqplot(USD_scaled)
title('Subplot 2: GARCH USD');

%% 3 a)

corr_weekly = corr(u_OMX_weekly, u_USD_weekly);

%% 3 b)
Autocorr_OMX = zeros(5,1);
Autocorr_USD = zeros(5,1);

for lag = 1:5
    Autocorr_OMX(lag) = corr(u_OMX_weekly(2:end - lag), u_OMX_weekly(lag + 2:end));
    Autocorr_USD(lag) = corr(u_USD_weekly(2:end - lag), u_USD_weekly(lag + 2:end));
end

Autocorr_OMX;
Autocorr_USD;
%% 3c)

standard_OMX_scaled = normcdf(OMX_scaled(3:length(OMX_scaled))); %måste vara likformigt fördelad mellan 0 och 1
standard_USD_scaled = normcdf(USD_scaled(3:length(USD_scaled)));

v = [standard_OMX_scaled, standard_USD_scaled];

l_l = zeros(5, 1);

[rho] = copulafit('gaussian', v);
cop_gaussian = copulapdf('gaussian', v, rho);
l_l(1) = sum(log(cop_gaussian));

[rho, nu] = copulafit('t', v);
cop_student_t = copulapdf('t', v, rho, nu);
l_l(2) = sum(log(cop_student_t));

[param_hat] = copulafit('gumbel', v);
cop_gumbel = copulapdf('gumbel', v, param_hat);
l_l(3) = sum(log(cop_gumbel));

[param_hat] = copulafit('clayton', v);
cop_clayton = copulapdf('clayton', v, param_hat);
l_l(4) = sum(log(cop_clayton));

[param_hat] = copulafit('frank', v);
cop_frank = copulapdf('frank', v, param_hat);
l_l(5) = sum(log(cop_frank));

l_l

COP_RND = copularnd('t', rho, nu, 1204);

figure(11)

subplot(1,2,1);
scatter(COP_RND(:,1), COP_RND(:,2));
title('Subplot 1: Random t-test');
subplot(1,2,2);
scatter(standard_OMX_scaled, standard_USD_scaled);
title('Subplot 2: Historiska');

%% Output

    output.RIC = {'OMXS30', 'USD/SEK'}

    output.stat.mu = [Mean_yearly_w_u_OMX Mean_yearly_w_u_USD]        %Mean returns (weekly data)
    output.stat.sigma = [Volatilitet_yearly_w_OMX Volatilitet_yearly_w_USD]        %St.dev. (weekly data)
    output.stat.CI = [conf_interval_lower_OMX conf_interval_upper_OMX ; conf_interval_lower_USD conf_interval_upper_USD]       %Conf. int., [cl1 cu1; cl2 cu2], cl1 = lower limit RIC1
    output.stat.skew = [skevhet_OMX_w skevhet_USD_w skevhet_OMX_d skevhet_USD_d]          %Coeff. of skewness [RIC1w, RIC2w, RIC1d, RIC2d]
    output.stat.kurt = [excess_OMX_w excess_USD_w excess_OMX_d excess_USD_d]      %Coeff. of kurt [RIC1w, RIC2w, RIC1d, RIC2d]
    output.stat.perc = [percentile_OMX_w_1 percentile_OMX_w_5 percentile_OMX_w_95 percentile_OMX_w_99 ...
        ; percentile_USD_w_1 percentile_USD_w_5 percentile_USD_w_95 percentile_USD_w_99 ...
        ; percentile_OMX_d_1 percentile_OMX_d_5 percentile_OMX_d_95 percentile_OMX_d_99 ...
        ; percentile_USD_d_1 percentile_USD_d_5 percentile_USD_d_95 percentile_USD_d_99]       %Percentiles [pw11 pw15 pw195 pw199; pw21 pw25 pw295 pw299;], pw11 weekly data, RIC1, first percentile etc.
    output.stat.corr = corr_weekly     %Correlations [Linear Spearman Kendall]
    output.stat.acorr = [Autocorr_OMX , Autocorr_OMX]              %Autocorrelations, rows: lag 1-5, cols: RIC1-2

    output.EWMA.obj = [ll_EWMA_OMX, ll_EWMA_USD]          %[log-L (RIC1), log-L (RIC2)]
    output.EWMA.param = [par_OMX_EWMA(2), par_USD_EWMA(2)]    %[lambda (RIC1), lambda (RIC2)]

    output.GARCH.obj = [ll_OMX, ll_OMX]       %[log-L (RIC1) unconstrained, log-L (RIC2) unconstrained]
    output.GARCH.param = [par_OMX_print, par_USD_print]       %[sigma, alpha, beta (RIC1), sigma, alpha, beta (RIC2) (unconstrained MLE)] %sigma is the yearly volatility, i.e. sqrt(VL*52), from MLE

    output.GARCH.objVT = [ll_OMX_vt, ll_USD_vt]     %[log-L (RIC1) variance targeting, log-L (RIC2) variance targeting.;]
    output.GARCH.paramVT = [par_OMX_vt_print, par_USD_vt_print]     %[sigma, alpha, beta (RIC1), sigma, alpha, beta (RIC2) (variance targeting)] %sigma is the yearly volatility, i.e. sqrt(VL*52), from sample estimate.
    output.copulaLogL = l_l %Normal, Stud.-t, Gumbel, Clayton, Frank
    
    printResults(output, 1);