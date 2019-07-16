function data_filt = cheby_band_filt(a,b,data) 


d = designfilt('bandpassiir','FilterOrder',4, ...
    'PassbandFrequency1',a,'PassbandFrequency2',b, ...
    'PassbandRipple',4,'SampleRate',50);

data_filt = filter(d,data);
