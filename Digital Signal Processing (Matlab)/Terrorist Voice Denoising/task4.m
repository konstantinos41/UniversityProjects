%% Data Input

fs = 8000;

terroristWord1 = audioread('word8.wav');
terroristWord2 = audioread('word6.wav');
terroristWord3 = audioread('word2.wav');

testingWord  = audioread('morphed_voice.wav');


%% Feature Extraction (MFCCs)

featuresTerroristWord1 = melcepst(terroristWord1, fs);
featuresTerroristWord2 = melcepst(terroristWord2, fs);
featuresTerroristWord3 = melcepst(terroristWord3, fs);

featuresTestingWord  = melcepst(testingWord, fs);


%% Feature Matching (Minimum-Distance Classifier)

delta = 0.85; % threshold for identification

mean_featuresTerroristWord1 = mean(featuresTerroristWord1);
mean_featuresTerroristWord2 = mean(featuresTerroristWord2);
mean_featuresTerroristWord3 = mean(featuresTerroristWord3);

mean_featuresTestingWord = mean(featuresTestingWord);

d1 = mean((mean_featuresTerroristWord1 - mean_featuresTestingWord).^2);
d2 = mean((mean_featuresTerroristWord2 - mean_featuresTestingWord).^2);
d3 = mean((mean_featuresTerroristWord3 - mean_featuresTestingWord).^2);


%% Print Vault's Message

if (d1 < 1-delta || d2 < 1-delta || d3 < 1-delta)
    disp('Terrorist identified. Welcome Mr.Terrorist. Have fun terrifying people.');
else
    disp('Terrorist not identified. ALARM! We have a break in!');
end


