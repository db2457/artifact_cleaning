function writeData(abp_cleaned,nirsl_cleaned,nirsr_cleaned,filename,data_dir)
% DESCRIPTION:
%   Writes cleaned ABP and NIRS signals to HDF5 files

% INPUT (REQUIRED):
%   abp_cleaned - (double) cleaned ABP data
%   nirsl_cleaned - (double) cleaned NIRS data, L side
%   nirsr_cleaned - (double) cleaned NIRS data, R side
%   filename - (char) filename of HDF5 file
%   data_dir - (char) directory where HDF5 file is located
%   
% 
%   
% OUTPUT:
%   None.
%
% ASSUMPTIONS AND LIMITATIONS:
%   None.
%   
% REVISION HISTORY:
%   


old_dir = cd;
cd(data_dir)

    try 
            h5write([filename,'.hdf5'],'/waves/abp',abp_cleaned);
            h5write([filename,'.hdf5'],'/numerics/rso2r',single(nirsr_cleaned));
            h5write([filename,'.hdf5'],'/numerics/rso2l',single(nirsl_cleaned));
    catch err

            warning([filename, ' cleaned data could not be written to HDF5 dataset: ', err])

    end


cd(old_dir)