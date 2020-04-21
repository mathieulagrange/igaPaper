inputPath = '../data/audio/';

fileList = dir([inputPath '*wav']);
% Replace folder paths with relative paths
[fileList.folder] = deal(inputPath);
save('../data/soundFileList.mat','fileList')
