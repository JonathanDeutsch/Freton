
smFRET.ai: Flexible software for visualization and analysis of smFRET data
========================================================================

Single-molecule Förster Resonance Energy Transfer (smFRET) measures the real-time conformational dynamics of immobilized biomolecules. Advances in microscopy, detectors, fluorophores, and protein biochemistry have made smFRET more accessible. However, many labs continue to rely on custom analysis code, creating barriers for new users. Existing software tools often lack customization flexibility or are too complex for non-experts. Variability in data quality, inherent to the system under investigation, imposes diverse processing requirements and complicates interpretation. Protein systems present additional challenges due to nonspecific interactions with fluorescent probes and the need for lipids, salts, or high concentrations of small molecules, which can compromise probe stability and brightness. To address these challenges, we developed smFRET.ai, a GUI-based software suite that balances ease of use with optional advanced control over parameters and algorithms. It features a versatile image processing module for 1–4 color single-molecule data and a trace selection module that integrates manual, empirical, and machine learning approaches to identify biomolecules with suitable photophysics for further analysis. The suite also includes standard tools for graphing and evaluation results, established kinetic analysis algorithms, and export/import compatibility with other software like Spartan and tMaven. Additionally, the available MATLAB source code provides a library of algorithms for customization and new tool development, offering a comprehensive and adaptable platform for smFRET analysis.

Note: smFRET.ai is currently in beta.

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

Data format
-----------
Data can be loaded in the .TIF file format using the KAT module from movies collected using 1-2 cameras with 1-2 channel image splitting (vertical or horizontal). Movies can be loaded individually or using "batch mode" to pull multiple movies using the same parameters. You can also load binary files from data collected using avalanche photodiodes (APDs).

Using smFRET.ai
---------------
Navigate to kit_kat_launch.m in the main repository to launch the GUI menu. Open the KAT module to load your data to extract traces from FRETing molecules. Traces can be loaded into the KIT module for further selection, launched from KAT or the main menu. A typical workflow is illustrated in the diagram below. Detailed documentation can be found in the Manual folder. 


Sample Data
-----------
Test data can be found in the smFRETSampleData folder.

Citing FRET.ai 
-------------
If you use our software or algorithms in your data analysis please cite the following paper: 

Jonathan Deutsch, Srikara Vishnubhatla, Gabriele Boncoraglio, John Janetzko, Brian K. Kobilka, Steven Chu* and Rabindra V. Shivnaraine*. smFRET.ai: A fully integrated software suite for analysis of smFRET data. _Puplication in progress_ (2025). 
*Corresponding authors: rvshiv@stanford.edu (RVS)

Acknowledgments
---------------
smFRET.ai was developed at Stanford University by the authors of the above paper. 

License
-------
Software and manual copyright (c) 2024 are available under the MIT license. See the LICENSE file for more info. 

