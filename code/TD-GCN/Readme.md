**Final Code**

Contains code for:

- Pre-processing the data
- Plotting the time domain heat maps
- Plotting Confusion Matrices, for evaluation

Also contains some example CSV Files, to illustrate how they were created in MATLAB and loaded in Python. Note that the actual training, test and validation set CSV files could not be uploaded due to file size constraints.

**Networks**

  - TDGCN loads the pre-processed data and adjacency/Laplacian matrices. 
  - It then trains the model using a GCN class, defined by Defferard's library (this code is in Lib).
  - Finally, it evaluates the model on test data
  - N.B. The TDGCN code given here applies the GCN fitting and evaluation to imaginary data, from all 64 electrodes
  - Similar code was used for the executed data
  - TDGCN_1 applies the code to Brain Region 1
  - Similar code was used for the other 3 regions
  
