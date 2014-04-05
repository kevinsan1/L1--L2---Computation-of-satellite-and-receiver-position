function [x,y,z] = importApproxPosition(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column
%vectors.
%   [X,Y,Z] = IMPORTFILE(FILENAME) Reads data from text file
%   FILENAME for the default selection.
%
%   [X,Y,Z] = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data
%   from rows STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   [x,y,z] = importApproxPosition('0lov033b.04o',8, 8);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2014/04/05 16:33:48

%% Initialize variables.
delimiter = ' ';
if nargin<=2
    startRow = 8;
    endRow = 8;
end

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to
% generate this code. If an error occurs for a different file,
% try regenerating the code from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so
% no post processing code is included. To generate code which
% works for unimportable data, select unimportable cells in a
% file and regenerate the script.

%% Allocate imported array to column variable names
x = dataArray{:, 1};
y = dataArray{:, 2};
z = dataArray{:, 3};

