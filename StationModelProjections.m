function [baseline_model, tempAnnMeanAnomaly, P] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%Updated usage example
% USAGE:  [baseline_model, tempAnnMeanAnomaly, P] = StationModelProjections(station_number) <--update here
%
% DESCRIPTION:
%  Added description
% Use this function to calculate the baseline from 2006-2025, the annual mean temperature anomaly, 
% and the linear trend for the mean temperature values
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    tempAnnMeanAnomaly: Annual mean temperature anomaly, as compared to
%       the 2006-2025 baseline period
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%
%   **list any other outputs you choose to include**
%
% AUTHOR:   Nhia and Leafia
%
% REFERENCE:
%    Written for GEOS 215: Earth System Data Science, Wellesley College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file
filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
%<--
%reads stationdata file and assigns all the years to variable yearlist and
%assigns all temperature anual means to the variable tempAnnMean

%I realized what we did before hear was wrong, because we were working on
%incorrect assumptions about how the data was formatted and what we needed
%to do, but all we actually needed to do was assign variables to the years
%and annual mean amounts stored in the station data
stationdata = readtable(filename);

%extracts years
yearlist = stationdata.Year;

%extracts annual mean temperature data
% tempAnnMean = mean(stationdata(2:end,2));
tempAnnMean = stationdata.AnnualMeanTemperature(:);
%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
 %<-- (this will take multiple lines of code - see the procedure you
 %followed last week for a reminder of how you can do this)
 
 %creates an array that gives the indicies for data from 2006 to 2025
 ind_baseline = find(stationdata.Year >= 2006 & stationdata.Year <= 2025);
 
 %calculates the mean of the annual mean temperature for the years 2006 to
 %2025
 baselineMean = mean(tempAnnMean(ind_baseline));
 
 %calculates the standard deviation of the annual mean temperature for the years 2006 to
 %2025
 baselineSD = std(tempAnnMean(ind_baseline));
 
 %stores the mean and standard deviation in an array
 baseline_model = [baselineMean baselineSD];


%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
% I copied these from Part 1 of the assignment and changed the variable
% names to line up with the variable names we're currently using 
 %<-- calculates the anomaly
 tempAnnMeanAnomaly = tempAnnMean - baselineMean;
 %<-- calculates the smoothed anomaly 
smoothAnMeanTempAnomaly = movmean(tempAnnMeanAnomaly,5);
%% Calculate the linear trend in temperature this station over the modeled 21st century period
 %<--
 %use the polyfit function to generate slope and intercept for a linear fit to annual mean temperature 
 %values over the full 21st century modeled period
P = polyfit(yearlist,tempAnnMean,1);

end