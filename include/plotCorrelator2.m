function plotCorrelator2(channelList, trackResults, settings)
    channelList = intersect(channelList, 1:settings.numberOfChannels);
    figure;
    legendPRN = [];
    multicorr = zeros(1, 11);

    for channelNR = channelList
        if trackResults(channelNR).status == 'T'
        	corrAxis = [];
            for i = 1:11
            	tmp = sqrt(trackResults(channelNR).I_I(i,:).^2 + trackResults(channelNR).Q_Q(i,:).^2);
            	corrAxis = [corrAxis mean(tmp)];
            end
            multicorr = multicorr + corrAxis;
            timeAxis = [-0.5:0.1:0.5];
            plot(timeAxis, corrAxis, '-*');
            hold on;
            legendPRN = [legendPRN, trackResults(channelNR).PRN];
        end
    end
    xlabel('Chip');
    ylabel('Correlation $\sqrt{I^2+Q^2}$', 'Interpreter', 'latex');
    title('Correlation Results');
    legend(int2str(legendPRN'));
    figure;
    timeAxis = -0.5:0.1:0.5;
    plot(timeAxis, multicorr, 'r-*');
    xlabel('Chip');
    ylabel('Correlation');
    title('Multi-correlator');
    
end 