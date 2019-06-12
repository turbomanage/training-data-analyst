# AI Notebooks 

Updated labs to use AI Notebooks instead of Datalab.
## Getting started with AI Notebooks
### Create a notebook to run the machine learning Qwiklabs
1. In GCP Console, select AI Platform > Notebooks.
1. Click NEW INSTANCE.
1. Choose Tensorflow 1.x without GPUs.
1. Name the instance _dataengvm_.
1. Accept the default zone (us-west1-b).
1. Click CREATE and wait for the instance to start.

### Open the notebook and install missing libraries
1. Once the instance is up, click OPEN JUPYTERLAB.
1. Click the Terminal launcher and type `pip install jupyter-tensorboard`. You'll need this later.
1. Close the JupyterLab tab.
1. Back in the GCP Console tab showing your notebook instance, restart the instance using the RESET button.

### Clone the git repo used for the labs
1. Click OPEN JUPYTERLAB.
1. From the Git menu, select Git Interface.
1. Click the icon to clone a repository.
1. For the repo URL, enter this branch: 
`https://github.com/turbomanage/training-data-analyst/`
1. You will see the training-data-analyst folder appear.
1. Select the git icon in the left nav and click the refresh icon in the git menu bar.
1. Select the branch named `origin/extra`. This branch contains the lab notebooks updated to use AI Notebooks instead of Datalab.

### Open the first notebook
1. In JupyterLab, click the folder icon in the left nav.
1. Navigate to training_data_analyst/courses/machine_learning/datasets.
1. Click create_datasets.ipynb to open the notebook for Lab 1.

## Additional notes
"Dr. Fibonacci" has shared additional notes about the taxifare labs at [drfib.me/taxilab](https://drfib.me/taxilab).
