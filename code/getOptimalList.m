inputPath = '../data/listes/';

fileList = dir([inputPath '*optimaux.mat']);

liste={};
for k=1:length(fileList)
    data = load([inputPath fileList(k).name]);
    ll = []
    for l=1:length(data.sonsOptimaux)
        ll(l) = str2num(strrep(num2str(data.sonsOptimaux(l, :)), ' ', ''));
    end
    liste{k} = ll;
end

save('../data/optimalListe.mat', 'liste')