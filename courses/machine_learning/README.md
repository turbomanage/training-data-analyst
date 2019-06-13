# AI Notebooks 

Updated labs to use AI Notebooks based on [JupyterLab](https://github.com/jupyterlab/jupyterlab) instead of Datalab.
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

### Lab index
1. [datasets/create_datasets.ipynb](datasets/create_datasets.ipynb)
1. [tensorflow/a_tfstart.ipynb](tensorflow/a_tfstart.ipynb)
1. [tensorflow/b_estimator.ipynb](tensorflow/b_estimator.ipynb)
1. [tensorflow/c_batched.ipynb](tensorflow/c_batched.ipynb)
1. [tensorflow/d_traineval.ipynb](tensorflow/d_traineval.ipynb)
1. [cloudmle/cloudmle.ipynb](cloudmle/cloudmle.ipynb)
1. [feateng/feateng.ipynb](feateng/feateng.ipynb)

## Working with JupyterLab
* The round circle in the upper right is hollow when the notebook is idle and filled when the kernel is working.
* The \[\] to the left of each code block indicate status: a number represents the sequence in which it was run, an asterisk shows it's running, and it's otherwise empty.

## How to launch Tensorboard from Jupyterlab
Before you can launch Tensorboard directory from JupyterLab, you must install a helper package.

### Install jupyter-tensorboard
After creating an AI Notebook instance, click OPEN JUPYTERLAB, then click Terminal in the launcher tab and run the following command:
```
> pip install jupyter-tensorboard
```
Restart the instance using the RESET button on the AI Platform Notebooks page.

### Launch Tensorboard in a notebook

Many notebooks contain TensorBoard.start(). Run the cell, then go to the Launcher tab (File > New Launcher) and click the Tensorboard launcher. Your Tensorboard will now show up in the Tensorboards tab in the left nav bar also.

### Launch Tensorboard from the command line
Alternatively, you can launch Tensorboard from the notebook Terminal. In the JupyterLab folder containing your notebook, click Git > Open Terminal to get a prompt in that directory, then run
```
> tensorboard --logdir=output_dir
```
where _output_dir_ is the model directory in your TF code.
Try the Tensorboard launcher as above.

If the launcher doesn't work, you can still connect to it using Cloud Shell Web Preview:

* Note the port on which TensorBoard is running.
* In the Cloud Shell, run [start_tunnel.sh](../../../extra/util/start_tunnel.sh) to connect to your AI Notebook instance using its internal IP address and the port above.
* Open Web Preview on port 8080.

### How to launch TensorBoard from the Cloud Shell
Sometimes it's useful to run TensorBoard on the Cloud Shell to see the progress of AI Platform jobs. To do this, go to the job detail and note the output directory, which will be a Cloud Storage path. Then in the Cloud Shell:
```
> tensorboard --port=8080 --logdir=gs://...[path from ML job --output-dir]
```

Now you can connect using Web Preview.
