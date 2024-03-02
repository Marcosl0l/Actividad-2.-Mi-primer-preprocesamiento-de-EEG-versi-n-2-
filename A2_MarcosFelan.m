eeglab();
EEG = pop_biosig('C:\Users\EQUIPO\Documents\Neuro\Señalcruda1.gdf');
nans = isnan(EEG.data);
EEG.data(nans) = 0;
EEG = pop_editset(EEG);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 0,'setname','Señal Cruda','gui','off'); 
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',50,'plotfreqz',1);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname','Señal Filtrada','gui','off'); 
pop_eegplot( EEG, 1, 1, 1);
EEG2 = EEG;
EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion',10, ...
'ChannelCriterion',0.6,'LineNoiseCriterion',6,...
'Highpass',[0.25 0.75],'BurstCriterion',80,...
'WindowCriterion','off','BurstRejection','off' ,...
'Distance','Euclidian','channels',[]);
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 2,'setname','Canales Malos','gui','off'); 
pop_eegplot( EEG, 1, 1, 1);
BadChan = [];
x = 1;
for i = 1:length(EEG.etc.clean_channel_mask)
    if EEG.etc.clean_channel_mask(i, 1) == 0
        BadChan(1, x) = i;
        x = x + 1;
    end
end
EEG2 = pop_interp(EEG2, EEG.chanlocs, "spherical")
EEG2 = pop_runica(EEG2);
EEG2 = pop_iclabel(EEG2);
EEG2 = pop_viewprops(EEG2, 0, 1:size(EEG2.icawinv, 2), {'ICLabel'});