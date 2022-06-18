function [abp_raw,nirsl_raw,nirsr_raw] = getData(filename,data_dir)
% DESCRIPTION:
%   Pulls ABP and NIRS signals from HDF5 files

% INPUT (REQUIRED):
%   filename - (char) filename of HDF5 file
%   data_dir - (char) directory where HDF5 file is located
% 
%   
% OUTPUT:
%   abp_raw - (single vector) raw arterial blood pressure waveform
%   nirsl_raw - (single vector) raw NIRS numerics on left side
%   nirsr_raw - (single vector) raw NIRS numerics for right side
%
% ASSUMPTIONS AND LIMITATIONS:
%   None.
%   
% REVISION HISTORY:
%   
    
    old_dir = cd;
    cd(data_dir)


    try

        abp_raw = h5read([filename, '.hdf5'],'/waves/abp');
        nirsl_raw = h5read([filename, '.hdf5'],'/numerics/rso2l');
        nirsr_raw = h5read([filename, '.hdf5'],'/numerics/rso2l');

    catch err

        if (strcmp(err.identifier,'MATLAB:imagesci:h5read:libraryError'))

            warning([filename, ' is probably a TCD file. Unable to load.']) % this error occurs when abp,nirs_l,nirs_r do not exist in the HDF5 data.

        end

        warning(['HDF5 could not be loaded for ', filename, ' ',err.message]) % erorr unknown
        
        abp_raw = NaN;
        nirsl_raw = NaN;
        nirsr_raw = NaN;
        
    end

    
    cd(old_dir)

end