# Automated artifact cleaning for autoregulatory data

Automated removal of artifacts in arterial blood pressure (ABP) and near-infared spectroscopy (NIRS) signals.

### Introduction

The objective of this code is to remove artifacts in high-frequency ABP waveforms and NIRS signals collected from ICM+ software at the bedside (Cambridge Enterpises, 2022). This artifact-cleaning step precedes calculation of autoregulatory data such as the cerebral oximetry index (COx) and limits of autoregulation (LA). 

### Method
This project is created with MATLAB R2022a and interfaces with .HDF5 files exported from ICM+. 


ABP artifact cleaning is based on the NB-SQI algorithm adapted from Ignacz et al. (2021).
NIRS artifact cleaning is based on line-length calculations.

### Usage
Clone this repo to your desktop and open  `xxxx.m` in MATLAB. Change variable `RAW_DATA_DIR` to the directory containing raw HDF5 files

- Clean HDF5 files in directory: `xxxx.m`


### Reference
Ignacz, A., Földi, S., Sotonyi, P., & Cserey, G. (2021). NB-SQI: A novel non-binary signal quality index for continuous blood pressure waveforms. Biomedical Signal Processing and Control, 70, 103035. https://doi.org/10.1016/j.bspc.2021.103035


