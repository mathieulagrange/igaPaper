inputPath = '../data/audio/';

fileList = dir([inputPath '*wav']);

for k=1:length(fileList)
  [p, n]  = fileparts(fileList(k).name);
  p = split(n, '_');
  parameters(k, :) = str2num(p{2});
end

save('../data/synthesisParameters.mat', 'parameters')