close('all');
clearvars();

%% Create base series
t = 0:1:50;
f = @(t,amp,off,fre,dam) amp*sin(fre*(0:1:t)) .* exp(-dam*(0:1:t)) + off;
y = [-1*ones(1, 10), f(20,1.2,1,0.6,0.1), f(30,-1.1,-2,0.4,0.16), f(22,0.9,2,0.3,0.05), -1*ones(1,15)];
y = lowpass(y, 0.2);
t_max = length(y)-1;
y_max = max(y);
y_min = min(y);
t = 0:1:t_max;

%% outliers
y_outliers = y + 3*(rand(1, t_max+1)+3) .*(rand(1, t_max+1)<0.2) .* ((rand(1, t_max+1)>0.5)-0.5);
augExplPlot(t, y, t, y_outliers, 'Outliers', 'with $p=0.2$');

%% white noise
y_whiteNoise = y + randn(1, t_max+1);
augExplPlot(t, y, t, y_whiteNoise, 'White noise', '$\sim\mathcal{N}(\mu=0, \sigma=1)$');

%% noise
y_noise = y + 2*(rand(1, t_max+1)-0.5);
augExplPlot(t, y, t, y_noise, 'Noise', 'with noise $\sim\mathcal{U}$(-1,1)');

%% invert
y_invert = y * (-1);
augExplPlot(t, y, t, y_invert, 'Invert');

%% scale
y_scale = y * 1.3;
augExplPlot(t, y, t, y_scale, 'Scale', 'with scale factor = 1.3');

%% offset
y_offset = y - 2.4;
augExplPlot(t, y, t, y_offset, 'Offset', 'with offset = -2.4');

%% drift
process = [0, cumsum(0.2 * randn(1, length(y)-1))];
y_addGaussianProcess = y + process;
augExplPlot(t, y, t, y_addGaussianProcess, 'Drift', 'adding a Wiener process with $\sigma=0.2$');

%% clip
y_clip = y;
minmax = [-2, 1.3];
y_clip(y_clip < minmax(1)) = minmax(1);
y_clip(y_clip > minmax(2)) = minmax(2);
augExplPlot(t, y, t, y_clip, 'Clip', 'within interval [-2, 1.3]');

%% quantize
y_quantize = round(y*2)/2;
augExplPlot(t, y, t, y_quantize, 'Quantize', 'with resolution $\Delta y = 0.5$');

%% random downtime
y_randomDowntime = y;
n = length(y);
substitute = -4;

p_soll = 0.3;
mu = 6;
sigma = 2;
scale = sigma^2/mu;
shape = mu/scale;

n_down_soll = round(n*p_soll);
n_up_soll = n - n_down_soll;
n_downtimes_prior = round(n_down_soll / mu);
downtimes = [];
while sum(downtimes) < (n_down_soll-mu/2)
    downtimes(end+1) = round(gamrnd(shape, scale));
end
if sum(downtimes) > n
    downtimes(end) = [];
end
n_down_ist = sum(downtimes);
n_up_ist = n - n_down_ist;
p_ist = n_down_ist / n;
% now mix the downtimes into
lottery = [zeros(1, n_up_ist), 1:length(downtimes)];
lottery = lottery(randperm(length(lottery)));
for i=1:length(downtimes)
    idx = find(lottery == i);
    lottery = [lottery(1:idx-1), ones(1, downtimes(i)), lottery(idx+1:end)];
end
y_randomDowntime = y;
y_randomDowntime(lottery == 1) = substitute;
augExplPlot(t, y, t, y_randomDowntime, 'Random downtime', 'with $\frac{t_{down}}{t_{down}+t_{up}} \approx 0.3$, duration $\sim \Gamma(\mu=4,\sigma=1)$ and substitude = -4');








%% helper functions
function augExplPlot(t1, y1, t2, y2, name, desc)
    t1_min = min(t1);
    t1_max = max(t1);
    t2_min = min(t2);
    t2_max = max(t2);
    t_min = min([t1_min, t2_min]);
    t_max = max([t1_max, t2_max]);
    y1_min = min(y1);
    y1_max = max(y1);
    y2_min = min(y2);
    y2_max = max(y2);
    y_min = min([y1_min, y2_min]);
    y_max = max([y1_max, y2_max]);
    %% figure
    f = figure('Name', name, 'NumberTitle', 'off'); 
    f.Position = [10 10 550 220]; 
    plot(t1, y1, 'o', 'Color', 'blue', 'MarkerSize', 4, 'LineWidth', 1.5);
    hold('on');
    plot(t2, y2, '.', 'Color', 'red', 'MarkerSize', 11, 'LineWidth', 2);
    if nargin == 5
        title(name, 'interpreter', 'latex');
    else
        title([name, ' (', desc, ')'], 'interpreter', 'latex');
    end
    ylabel('Value', 'interpreter', 'latex');
    xlabel('Time', 'interpreter', 'latex');
    xlim([t_min, t_max]);
    ylim([floor(-max(abs([y_min, y_max])))-1, ceil(max(abs([y_min, y_max]))+1)]);
    set(gcf,'color','w');
    xArrow = annotation('line');
    xArrow.Parent = gca;
    xArrow.Position = [t_min, 0, t_max, 0];
    legend('original', 'augmented', 'interpreter', 'latex');
    grid on;
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(groot, 'defaultLegendInterpreter','latex');
    set(findall(gcf,'-property','FontSize'), 'FontSize', 14);
    saveas(gcf, ['img/', strrep(name,' ','_'), '.png']);
end
