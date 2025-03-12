function dop = doppler(trackResults, currMeasSample, channelList, settings)
    for channelNr = channelList 
        for index = 1: length(trackResults(channelNr).absoluteSample)
            if(trackResults(channelNr).absoluteSample(index) > currMeasSample)
                break
            end 
        end
        index = index - 1;
        carrFreq=trackResults(channelNr).carrFreq(index);
        dop(channelNr)=(carrFreq-settings.IF)*settings.c/1575.42e6;
    end
end