function playSoundFromPlot(h, e, soundFileList)
% Plays the sound file corresponding to the data point clicked in a figure
% Takes a structure with a list of the sound file locations as an imput.
% The order of the files must be the same as for the data points in the
% plot.

% Stop any sound from playing
clear sound

% Get coordinates
x = get(h, 'XData');
y = get(h, 'YData');

% Get index of the clicked point
[~, i] = min((e.IntersectionPoint(1)-x).^2 + (e.IntersectionPoint(2)-y).^2);

% Play the corresponding sound
if ~isempty(soundFileList(i).name)
    [signal,fs] = audioread(fullfile(soundFileList(i).folder,soundFileList(i).name));
    sound(signal,fs);
end

end
