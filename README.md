# Image processing and analysis of phase imaging data of the butterfly wing

This repository includes data, code, and measurements used in 

- AD McDougal, S Kang, Z Yaqoob, P So, and M Kolle, _In vivo_ visualization of butterfly scale cell morphogenesis in _Vanessa cardui_. _PNAS_, in press.

Additional details may be found in the Materials and Methods, as well as the SI, of the above publication. 
It is recommended to download all files and folders into a single root folder for use in MATLAB. 
This code was prepared for use in MATLAB R2019b, and some scripts or functions require the Image Processing Toolbox.

## Visualize phase data
For an example of the essential data visualization techniques, please run `butterflyVizScript.m`. Depth location may be adjusted within the script where z-slices are noted. 

## Main figure images
Run any of `makeFig1.m`, `makeFig2.m`, `makeFig3.m`, `makeFig4.m`,  `makeFig5AB.m`, `makeFig5CDEF.m`, `makeFig5G.m`, or `makeFig5H.m`, to produce the images and plots for the corresponding figure.

## Analysis scripts 
`analyzePhaseProfile.m` is an example script detailing the analysis of phase data for surface profile characteristics measurements plotted in `makeFig5H.m`. 
`analyzeActinRidgePeriod.m` is an example script detailing the analysis of longitidinal periodicity measurements plotted in `makeFig5G.m`.

## Supporting functions
Functions called in the scripts above are included in the root folder.

## Data
Data referred to by the above scripts are found in `/Processed/` and `/Measured/`. Data references in `/RawData/` will be forthcoming.
