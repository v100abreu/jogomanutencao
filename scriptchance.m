%script chance

prob_acumulada = chance(1000,120,1);
dp = diff(prob_acumulada);

t = 1:119;

weibull = wblpdf(t,44,2);

plot(t,dp);
figure
plot(t,weibull);
figure
plot(t,dp,t,weibull);