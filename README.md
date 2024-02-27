
smFRET.ai: A fully integrated software suite for analysis of smFRET data
========================================================================

Single-molecule Forster Resonance Energy Transfer (smFRET) is a technique used to measure the conformational dynamics of immobilized single biomolecules in real time. Advances in microscopy, detectors, fluorophores and protein biochemistry have made the application of smFRET more commonplace, yet it remains typical for individual labs to write and develop their own analysis code. For new users, this creates a high barrier to entry because of the infrastructure and expertise needed to perform these studies. Ready-made software tools for smFRET do exist but are typically difficult to use for non-experts and/or lack the ability to customize the analysis pipeline treating it as a black box. Large variation in data quality due to the system under investigation is characteristic of smFRET and leads to wide differences in data processing and interpretation. This is especially a problem for protein systems which often non-specifically interact with the fluorophores or otherwise require the inclusion of lipids, salts or small molecules that degrade the photophysical properties of dyes. 
At the basis of any smFRET data processing are two elements: one, processing of the movies to extract the traces; two, analysis of the traces to identify traces with ideal photophysics that represent real biomolecules that would warrant further analysis. smFRET.ai offers an extremely versatile and powerful image processing module to extract 1-4 color single-molecule data. In addition, smFRET.ai has a core trace selection module that combines manual, empirical and newly developed machine learning models to facilitate the appropriate approach for a vast range of data quality and type. Within the suite are field-standard tools to aid in graphing and interpreting smFRET results, including a collection of established kinetic analysis algorithms and interconvertibility with other software such as Spartan and tMaven. Taken together, smFRET.ai offers a comprehensive suite that integrates multiple methods to provide control over each stage of the analysis pipeline in GUI format that can be enjoyed by both basic and advanced users. The smFRET.ai source code also provides a library of algorithms for further customization of our software or the development of new analysis tools. 

smFRET.ai is under ongoing development and will be update soon. If this text is here the current version of smFRET.ai is the beta version. 

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
Data can be loaded in the .TIF file format using the KAT module from movies collected using 1-2 cameras with 1-2 channel image splitting (vertical or horizontal). Movies can be loaded individually or using "batch mode" to pull multiple movies using the same parameters. You can also load binary files from data collected using APDs. 

Using smFRET.ai
---------------
Navigate to kit_kat_launch.m in the main repository to launch the GUI menu. Open the KAT module to load your data to extract traces from FRETing molecules. Traces can be loaded into the KIT module for further selection, launched from KAT or the main menu. A typical workflow is illustrated in the diagram below. Detailed documentation can be found in the Manual folder. 

<img width="700" alt="image" src="https://github.com/JonathanDeutsch/smFRET-analysis-tools/assets/159817384/1134604f-cc4e-45c0-847f-b627c52230c9">


Sample Data
-----------
Sample data to explore the capabilities of FRET.ai can be found in smFRETSampleData. 

Citing FRET.ai 
-------------
If you use our software or algorithms in your data analysis please cite the following paper: 

Jonathan Deutsch, Srikara Vishnubhatla, Gabriele Boncoraglio, John Janetzko, Brian K. Kobilka, Steven Chu* and Rabindra V. Shivnaraine*. smFRET.ai: A fully integrated software suite for analysis of smFRET data. _Puplication in progress_ (2024). 

Acknowledgments
---------------
smFRET.ai was developed at Stanford University by the authors of the above paper. We would also like to thank the authors of the other packages we utilized. 

License
-------
Software and manual copyright (c) 2024 are available under the MIT license. See the LICENSE file for more info. 

