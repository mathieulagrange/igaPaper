addpath(genpath('tsne'));
addpath(genpath('export_fig'));

dataFileName = '../data/scatteringFeatures.mat';
parametersFileName = '../data/synthesisParameters.mat';

projectionFileName = '../data/tsneProjection2d.mat';

soundFileListFileName = '../data/soundFileList.mat';

data = load(dataFileName);
features = data.features;
data = load(parametersFileName);
parameters = data.parameters;
data = load(soundFileListFileName);
soundFileList = data.fileList;

%%
recompute = 0
if recompute
    p = tsne(features);
    save(projectionFileName, 'p')
end
%%

data = load('../data/Sons_optimaux_expe2.mat');
clear opti
for k=1:length(data.sonsOptimauxPourExpe2)
    opti(k) = str2num(strrep(num2str(data.sonsOptimauxPourExpe2(k, :)), ' ', ''));
end
optiSelector = find(sum(opti==parameters, 2));

if ~exist('p', 'var')
    data = load(projectionFileName);
    p = data.p;
end

clf
hold on
scatter(p(:, 1), p(:, 2), 30,  'filled',...
    'ButtonDownFcn', {@playSoundFromPlot,soundFileList})
r1 = randn(length(optiSelector), 1);
r2 = randn(length(optiSelector), 1);
scatter(p(optiSelector, 1)+r1*5, p(optiSelector, 2)+r2*5, 120,  'filled',...
    'ButtonDownFcn', {@playSoundFromPlot,soundFileList(optiSelector)})
hold off
set(gcf, 'Color', 'w');
export_fig ../figures/optimalRandomized.png

mean(std(features))
mean(std(features(optiSelector, :)))

mean(std(p))
mean(std(p(optiSelector, :)))

%%
data = load('../data/optimalListe.mat')
liste=data.liste;


for l=1:length(liste)
    ll = liste{l};
    clf
    hold on
    scatter(p(:, 1), p(:, 2), 30,  'MarkerFaceColor', [0 0 0])
    %scatter(p(optiSelector, 1), p(optiSelector, 2), 120,  'MarkerFaceColor', [0 0 0])
    
    cm = parula(length(ll)/9);
    for k=1:length(ll)/9
        optiSelector = find(sum(ll((k-1)*9+1:k*9)==parameters, 2));
        
        scatter(p(optiSelector, 1), p(optiSelector, 2), 120*(length(ll)/9-k+1),  'MarkerFaceColor', cm(k, :),  'MarkerEdgeColor', cm(k, :))
        de = plot_gaussian_ellipsoid(mean(p(optiSelector, :)), cov(p(optiSelector, :)));
        de.set('LineWidth', k)
        de.set('Color', cm(k, :))
    end
    hold off
    set(gcf, 'Color', 'w');
    export_fig(['../figures/subject_' num2str(l) '.png'])
end
