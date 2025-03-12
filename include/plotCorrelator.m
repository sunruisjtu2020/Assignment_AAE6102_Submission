function plotCorrelator(channelList, trackResults, settings)
    channelList = intersect(channelList, 1:settings.numberOfChannels);
    figure;
    legendPRN = [];

    for channelNR = channelList
        if trackResults(channelNR).status == 'T'
            vEarly  = sqrt(trackResults(channelNR).I_E.^2 + trackResults(channelNR).Q_E.^2);
            vLate   = sqrt(trackResults(channelNR).I_L.^2 + trackResults(channelNR).Q_L.^2);
            vPrompt = sqrt(trackResults(channelNR).I_P.^2 + trackResults(channelNR).Q_P.^2);
            
            timeAxis = [-0.5, 0, 0.5];
            corrAxis = [mean(vEarly), mean(vPrompt), mean(vLate)];
            plot(timeAxis, corrAxis, '-*');
            hold on;
            legendPRN = [legendPRN, trackResults(channelNR).PRN];
        end
    end
    xlabel('Chip (ms)');
    ylabel('Correlation $\sqrt{I^2+Q^2}$', 'Interpreter', 'latex');
    title('Correlation Results');
    legend(int2str(legendPRN'));
end