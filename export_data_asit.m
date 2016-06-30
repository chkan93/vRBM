function  export_data_asit( fileName, data )
%EXPORT_DATA_ASIT Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(fileName,'w');
fprintf(fileID,'%d\n', data);
fclose(fileID);
end

