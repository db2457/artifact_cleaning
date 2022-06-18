# Automated artifact cleaning for autoregulatory data


![Capture](https://user-images.githubusercontent.com/95881960/174457611-8edeb142-a427-44f4-b5eb-d10bbfeca4ac.PNG)

Automated removal of artifacts in waveform arterial blood pressure (ABP) and numeric near-infared spectroscopy (NIRS) signals.

### Introduction

The objective of this code is to remove artifacts in high-frequency ABP waveforms and NIRS signals collected from ICM+ software at the bedside (Cambridge Enterpises, 2022). Previously, artifact removal in the Petersen lab was done manually to prevent non-physiological abberations in ICM+ computed autoregulary data such as the cerebral oximetry index (COx) and limits of autoegulation (LA). However, manual artifact review is both time-costly and rater dependent. This project seeks to address these issues by standardizing and automating the artifact review process.

This artifact-cleaning step precedes calculation of autoregulatory data in ICM+.

### Method
This project is created with MATLAB R2022a and interfaces with .HDF5 files exported from ICM+. In brief, this code implements a sliding window that traverses the complete signal and rates the quality of many small subsets of data. If a particular subset is deemed poor quality, it is removed from the signal. 


ABP quality metric is based on the NB-SQI algorithm adapted from Ignacz et al. (2021).
NIRS quality metric is based on line-length calculations.


### Usage
Clone this repo to your desktop. The artifact cleaning process takes place in three steps:

1) Load ABP and NIRS signals from HDF5 file : `getData(filename,data_dir)`
2) Clean signal: `artifact_cleaner(rawData, isNIRS)`. Pass `isNIRS=1` if `rawData` is a NIRS signal. For ABP signal, `isNIRS=0`.
3) Overwrite cleaned data onto original HDF5 file: `writeData(abp_cleaned,nirsl_cleaned,nirsr_cleaned,filename,data_dir)`.

### Example
Yale folks: [download example HDF5 file on Yale Box](https://yale.box.com/s/kv3bies0mhiwqar22juyhg71wv8tfkpi). Open `example.m`. This script runs the above three steps on the example file.

### Customization 
Change cleaning specifications in `artifact_cleaner.m`
  - `NBISQI_THRESHOLD` refers to the minimum permitted quality for a given subset of ABP signal based on the 0-5 scale created by Ignacz et al.
  - `LINELENGTH_THRESHOLD` refers to the highest permitted line-length for a given subset of NIRS signal. 


  - `LL_winLen` and `LL_winDisp` refer to the length (L) and displacement (D) of the sliding window implemented to clean NIRS signals.
  - `NBSQI_winLen` and `NBSQI_winDisp` refer to the length (L) and displacement (D) of the sliding window implemented to clean ABP signals. 


  - `NIRS_MIN` and `NIRS_MAX` refer to the minimum and maximum allowed physiological NIRS values.
  - `ABP_MIN` and `ABP_MAX` refer to the minimum and maximum allowed physiological ABP values.


### Reference
Ignacz, A., Földi, S., Sotonyi, P., & Cserey, G. (2021). NB-SQI: A novel non-binary signal quality index for continuous blood pressure waveforms. Biomedical Signal Processing and Control, 70, 103035. https://doi.org/10.1016/j.bspc.2021.103035


