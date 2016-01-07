# Linux setup scripts
For reproducibility of results and synchronisation of development environments the software/tool stack has to be installed via installation scripts. Currently scripts for the following software is provided.

**ubuntu_core**
Basic library installation after Ubuntu 14.04 LTS installation.
```
./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
```
**libsbml**
SBML installation with language bindings for R and python.
```
./libsbml.sh 2>&1 | tee ./logs/libsbml.log
```
**roadrunner**
libRoadrunner installation for numerical integration of kinetic models.
```
./roadrunner.sh 2>&1 | tee ./logs/roadrunner.log
```
**antimony**
```
./antimony.sh 2>&1 | tee ./logs/antimony.log
```
**spyder**
Spyder IDE installation
```
./spyder.sh 2>&1 | tee ./logs/spyder.log
```

### TODO
* cobrapy

## Docker
Here docker container for the projects are defined reusing the defined scipts from above





