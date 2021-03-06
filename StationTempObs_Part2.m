%% Add a comment at the top with the names of all members of your group

%Leafia and Nhia

%% Load in a list of all 18 stations and their corresponding latitudes and longitudes
load GlobalStationsLatLon.mat

%% Calculate the linear temperature trends over the historical observation period for all 18 station
% You will do this using a similar approach as in Part 1 of this lab, but
% now implementing the work you did last week within a function that you
% can use to loop over all stations in the dataset

%Set the beginning year for the more recent temperature trend
RecentYear = 1960; %you can see how your results change if you vary this value

%Initialize arrays to hold slope and intercept values calculated for all stations
P_all = NaN*zeros(length(sta),2); %example of how to do this for the full observational period
%<-- do the same thing just for values from RecentYear to today

P_recent = NaN*zeros(length(sta),2); %same length because the time period does not affect how many stations there are

%Use a for loop to calculate the linear trend over both the full
%observational period and the time from RecentYear (i.e. 1960) to today
%using the function StationTempObs_LinearTrend
%<--

for i = 1:18
    [P_all(i,1:2),P_recent(i,1:2)]=StationTempObs_LinearTrend(sta(i),RecentYear);
end


%% Plot global maps of station locations
%Example code, showing how to plot the locations of all 18 stations
figure(1); clf
worldmap('World')
load coastlines
plotm(coastlat,coastlon)
plotm(lat,lon,'m.','markersize',15)
title('Locations of stations with observational temperature data')
hold off
%%
%Follow the model above, now using the function scatterm rather than plotm
%to plot symbols for all 18 stations colored by the rate of temperature
%change from RecentYear to present (i.e. the slope of the linear trendline)
%<--
figure(2);clf
worldmap('World')
load coastlines
plotm(coastlat,coastlon)
title('Locations of stations with observational temperature data from 1960 to Present')
colorbar
scatterm(lat,lon,100,P_recent(:,1), 'filled')

%Extension option: again using scatterm, plot the difference between the
%local rate of temperature change (plotted above) and the global mean rate
%of temperature change over the same period (from your analysis of the
%global mean temperature data in Part 1 of this lab).
%Data visualization recommendation - use the colormap "balance" from the
%function cmocean, which is a good diverging colormap option
%<--

%% Now calculate the projected future rate of temperature change at each of these 18 stations
% using annual mean temperature data from GFDL model output following the
% A2 scenario (here you will call the function StationModelProjections,
% which you will need to open and complete)

%Finished completing StationModelProjections function

%Use the function StationModelProjections to loop over all 18 stations to
%extract the linear rate of temperature change over the 21st century at
%each station
% Initialize arrays to hold all the output from the for loop you will write
% below
%<--
%Created empty arrays to store outputs from StationModelProjections
%function
baselineData = NaN*zeros(2,18);
TempAnomalyData = NaN*zeros(94,18);
LinearTrendData = NaN*zeros(2,18);

% Write a for loop that will use the function StationModelProjections to
% extract from the model projections for each station:
% 1) the mean and standard deviation of the baseline period
% (2006-2025) temperatures, 2) the annual mean temperature anomaly, and 3)
% the slope and y-intercept of the linear trend over the 21st century
%<--
%this for loop stores the outputs in the above arrays, each array has 18
%columns for each station, and the respective data for each station is
%stored in the appropriate column 
for i = 1:18
    [baselineData(:,i), TempAnomalyData(:,i), LinearTrendData(:,i)] = StationModelProjections(sta(i));
end

%% Plot a global map of the rate of temperature change projected at each station over the 21st century
%<--
%plots first row and all columns of LinearTrendData, which contains the
%slope values for the different stations - LinearTrendData(1,:)
figure(3);clf
worldmap('World')
load coastlines
plotm(coastlat,coastlon)
colorbar
title('Rate of Temperature Change Projected at Each Station Over the 21st Century')
scatterm(lat,lon,100,LinearTrendData(1,:), 'filled')
%% Plot a global map of the interannual variability in annual mean temperature at each station
%as determined by the baseline standard deviation of the temperatures from
%2005 to 2025
%<--
%plot standard deviation, which is stored in baselineData(2,:)
figure(4);clf
worldmap('World')
load coastlines
plotm(coastlat,coastlon)
colorbar
title('Interannual Variability in Annual Mean Temperature')
scatterm(lat,lon,100,baselineData(2,:), 'filled')
%% Calculate the time of emergence of the long-term change in temperature from local variability
%There are many ways to make this calcuation, but here we will compare the
%linear trend over time (i.e. the rate of projected temperature change
%plotted above) with the interannual variability in the station's
%temperature, as determined by the baseline standard deviation

%Calculate the year of long-term temperature signal emergence in the model
%projections, calculated as the time (beginning from 2006) when the linear
%temperature trend will have reached 2x the standard deviation of the
%temperatures from the baseline period
%<--
%divide slope by standard deviation 
YearofEmer = LinearTrendData(1,:)./baselineData(2,:);

%Plot a global map showing the year of emergence
%<--
figure(5);clf
worldmap('World')
load coastlines
plotm(coastlat,coastlon)
colorbar
title('Time of Emergence of the Long-term Change in Temperature from Local Variability')
scatterm(lat,lon,100,YearofEmer, 'filled')
