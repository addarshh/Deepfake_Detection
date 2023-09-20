# Deepfake Detection Project
### Video Face Manipulation Detection Through Ensemble of different experiemnetation technique
[![Build Status](https://travis-ci.org/polimi-ispl/icpr2020dfdc.svg?branch=master)](https://travis-ci.org/polimi-ispl/icpr2020dfdc)

The code is also hosted on git. Please refer to [Git Repo](https://github.com/wwt/deepfake/tree/final_consolidated)

Project has been inspired from the Kaggle Competition from the [Kaggle Deepfake Detection Challenge](https://www.kaggle.com/c/deepfake-detection-challenge/).
We used a base kernel for the solution, where Blazeface is used as face dectection technique and Efficient NetB4 is used a classification model to detect manipulated faces. We did several experiments on top of these base solution, listed below:
- Convex Hull
- Sensory Augmettaion
- Full Augmentation
- Side Blaze Face
- Blurring
- Face Angle Sampling
- Masking (polygon)
- Side Face Augmentation
- Ensemble of expirements above

With this implementation, we reached achieved best test score of 0.38 AUC

You can also refer to this [Notebook Guide](https://wwt-my.sharepoint.com/personal/pokkunus_wwt_com/_layouts/15/Doc.aspx?sourcedoc={65171b14-8e79-4846-8f6f-04f5ac290b6a}&action=edit&wd=target%28Deepfake%20Usecase.one%7C9e660857-3a66-4b50-9534-91bf43032765%2FProject%20on%20VSC%7Ce048bc45-d16b-4c30-b255-bc545fd8709e%2F%29&wdorigin=NavigationUrl) for detail implementation
## Getting started

    
## Prerequisites  
### Downloading Dataset
The existing work is performed on a dataset from the [Kaggle Deepfake Detection Challenge](https://www.kaggle.com/c/deepfake-detection-challenge)

If you are working on the WWT DGX server (IP address: 10.255.174.68), at this location: /raid/raid/baa-projects/datasets

Otherwise, to download the dataset from Kaggle, you can use any method [listed in the discussion here](https://www.kaggle.com/c/deepfake-detection-challenge/discussion/121695) to suit your requirements

### Setting up with Docker Image  
You need to have the code setup on the server which you are working on. 
If you are working on the WWT DGX server (IP address: 10.255.174.68), the codes are existing at this location: /mnt/deepfake/baa-video-analytics/final/deepfake

Otherwise, perform a git pull to extract latest codes from the branch, "final_consolidated"  
```bash 
$ git pull https://github.com/wwt/deepfake  
$ git checkout final_consolidated 
``` 
To create the docker image containing required dependencies, navigate to the directory, 'docker-files' and run the command below  
```bash 
$ docker build -t deepfake_image .  
``` 
### Spinning up a docker container  
While creating the docker container, make sure that you have correct paths for the codes and dataset. (do not include the terms "<" and ">"): 

```bash 
$ codes_path=<path to the directory containing the codes pulled from git> 
$ dataset_path=<path to the directory containing the data>  
``` 

If you are working on WWT DGX server (IP address: 10.255.174.68), use the variables below to use the existing codes and data:
```bash 
$ codes_path=/mnt/deepfake/baa-video-analytics/final/deepfake
$ dataset_path=/raid/raid/baa-projects/datasets
``` 

Now, spin up a container by running the following (edit the term <container name> with the name you want to give to your experiment): 
```bash 
$ docker container run --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=0 -it -d --name <container name> -v $codes_path:/codes -v $dataset_path:/datasets deepfake_image  
```
The parameter, "NVIDIA_VISIBLE_DEVICES"  is/are GPU indices you want to use for your training. If you want to use multiple GPUs, specify the GPU indices separated out by commas for example: NVIDIA_VISIBLE_DEVICES=0,1,2,3

### Quick run
Activate the anaconda environment within the docker 

```bash
$ conda activate deepfake 
```
If you want to train models from the data, you can run - [Train Script](https://github.com/wwt/deepfake/blob/final_consolidated/train.sh) 
```bash
bash train.sh
```
You can also add parameters to the command based on requirement. You can find these comprehensive list of all the commands to train the models presented in the paper. Please refer to the comments in the script for hints on their usage.

If you just want to test the pre-trained models against your own videos or images [Test Script](https://github.com/wwt/deepfake/blob/final_consolidated/test.sh) 
```bash
bash test.sh
```
You can find a comprehensive list of all the commands for testing the models presented in the paper. 
Please note that we use only 32 frames per video. You can easily tweak this parameter in [extract_faces.py](extract_faces.py)

### Train
In [train_all.sh](scripts/train_all.sh) you can find a comprehensive list of all the commands to train the models presented in the paper. 
Please refer to the comments in the script for hints on their usage. 

#### Training a single model
If you want to train some models without lunching the script:
- for the **non-siamese** architectures (e.g. EfficientNetB4, EfficientNetB4Att), you can simply specify the model in [train_binclass.py](train_binclass.py) with the *--net* parameter;
- for the **siamese** architectures (e.g. EfficientNetB4ST, EfficientNetB4AttST), you have to:
  1. train the architecture as a feature extractor first, using the [train_triplet.py](train_triplet.py) script and being careful of specifying its name with the *--net* parameter **without** the ST suffix. For instance, for training the EfficientNetB4ST you will have to first run `python train_triplet.py --net EfficientNetB4 --otherparams`;
  2. finetune the model using [train_binclass.py](train_binclass.py), being careful this time to specify the architecture's name **with** the ST suffix and to insert as *--init* argument the path to the weights of the feature extractor trained at the previous step. You will end up running something like `python train_binclass.py --net EfficientNetB4ST --init path/to/EfficientNetB4/weights/trained/with/train_triplet/weights.pth --otherparams`



## Datasets
- [Facebook's DeepFake Detection Challenge (DFDC) train dataset](https://www.kaggle.com/c/deepfake-detection-challenge/data) | [arXiv paper](https://arxiv.org/abs/2006.07397)
- [FaceForensics++](https://github.com/ondyari/FaceForensics/blob/master/dataset/README.md) | [arXiv paper](https://arxiv.org/abs/1901.08971)

## References
- [EfficientNet PyTorch](https://github.com/lukemelas/EfficientNet-PyTorch)
- [Xception PyTorch](https://github.com/tstandley/Xception-PyTorch)

## Credits
- Adarsh Agrawal
- Adeem Jassani
- Sai Pokkunuri
