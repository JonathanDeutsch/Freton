
Fréton: a software for processing and visualization of smFRET data
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
Movies of single molecules can be loaded in the .TIF file format using module 1 (KAT) from movies collected using 1-2 cameras with 1-2 channel image splitting. Movies can be loaded individually or using "batch mode" to pull multiple movies using the same parameters. Extracted donor and acceptor intensity traces are stored in .mat structures that are passed between modules.

Using Fréton
---------------
Navigate to kit_kat_launch.m in the main repository to launch the GUI menu. Open the KAT module (Module 1) to load your data, computationally register the channels, and extract intensity traces from FRETing molecules. Instructions are integrated into the GUI via 'Quickguide' popups.

The trace visualization and selection module (Module 2A; KAT) can be launched from the main menu or directly from Module 1. Empirical filtering of traces based on established criteria is performed during bleach point identification, followed by manual selection into up to three subgroups. Histograms for each trace group can be plotted within the module, and tools for advanced plotting and fitting of FRET efficiency distributions can also be launched. Integrated instructions are available via the '?' buttons.


Sample Data
-----------
Test data can be found in the smFRETSampleData folder.


Acknowledgments
---------------
Fréton was developed at Stanford University.

License
-------
Software and manual copyright (c) 2024 are available under the MIT license. See the LICENSE file for more info. 

