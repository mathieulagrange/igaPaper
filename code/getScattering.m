addpath(genpath('scatnet'))

inputPath = '../data/audio/';

fileList = dir([inputPath '*wav']);

sct = [25, 128, 250, 500, 1000];
setting.sct = sct(3);

scat_opt.M = 2;
scat_opt.oversampling = 1;
scat_opt.path_margin = 1;

clear features

for k=1:length(fileList)
    ceil(k/length(fileList)*1000)/10
    fileName = [inputPath fileList(k).name];
    [a,sr] = audioread(fileName);
    a = pad_signal(a, max(size(a, 1), sr*setting.sct/1000), 'zero', true);
    
    
    tm_filt_opt = struct();
    tm_filt_opt.Q = [12 1];
    tm_filt_opt.J = T_to_J(sr*setting.sct/1000, tm_filt_opt);
    
    % NOTE: The parameter `fr_filt_opt.J` controls the largest scale
    % along the frequency axis as a power of two. For `J = 4`, this
    % means a largest frequency scale of `2^4 = 16`, which is equal to
    % 1.5 octaves since `Q = 12`.
    fr_filt_opt = struct();
    fr_filt_opt.J = 4;
    
    Wop = joint_tf_wavelet_factory_1d(size(a, 1), tm_filt_opt, ...
        fr_filt_opt, scat_opt);
    
    S = scat(a(:,1), Wop);
    S = format_scat(S, 'order_table');
    features(k, :) = nanmean(real([S{1+1}' S{1+2}']));

end

save('../data/scatteringFeatures.mat', 'features')