
smFRET.ai: a software for processing and visualization of smFRET data
========================================================================

Single-molecule FRET (smFRET) enables real-time analysis of biomolecular dynamics, but data processing remains a barrier due to the reliance on complex, often custom-built tools. While several software solutions exist, they typically offer either ease of use or flexibility in data handling — rarely both. This flexibility is essential, as difficult protein systems generate data with highly variable noise and signal characteristics. Our software package addresses this challenge by combining a user-friendly GUI with optional fine-grained control over processing parameters and standard analysis algorithms at multiple stages of the pipline. It supports 1–4 color imaging and is compatible with other popular analysis packages and integrated with kinetic toolkits for streamlined downstream analysis.


System Requirements
-------------------
Requires MathWorks MATLAB(R) with the following tool boxes installed: 
- Curve Fitting Toolbox
- Image Processing Toolbox
- Optimization Toolbox
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- Parallel Computing Toolbox
- SoC Blockset
- Symbolic Math Toolbox

The code has been tested to work on MATLAB version R2023b or earlier.

Data format
-----------
Data can be loaded in the .TIF file format using the KAT module from movies collected using 1-2 cameras with 1-2 channel image splitting (vertical or horizontal). Movies can be loaded individually or using "batch mode" to pull multiple movies using the same parameters. You can also load binary files from data collected using avalanche photodiodes (APDs).

Using smFRET.ai
---------------
Navigate to kit_kat_launch.m in the main repository to launch the GUI menu. Open the KAT module to load your data to extract traces from FRETing molecules. Traces can be loaded into the KIT module for further selection, launched from KAT or the main menu. A typical workflow is illustrated in the diagram below.


Sample Data
-----------
Test data can be found in the smFRETSampleData folder.


Acknowledgments
---------------
smFRET.ai was developed at Stanford University.

License
-------
Software and manual copyright (c) 2024 are available under the MIT license. See the LICENSE file for more info. 

