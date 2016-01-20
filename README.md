# Linux setup scripts
For reproducibility of results and synchronisation of development environments the software/tool stack has to be installed via installation scripts. Currently scripts for the following software is provided.
```
GIT_DIR=$HOME/git
mkdir $GIT_DIR
cd $GIT_DIR
git clone https://github.com/matthiaskoenig/linux-setup
cd linux-setup
```
**ubuntu_core**  
Get a current Ubuntu distribution with long term support (LTS). Burn the iso or put on an USB stick and make a clean installation. Basic library installation after Ubuntu 14.04 LTS installation.
```
./ubuntu_core.sh 2>&1 | tee ./logs/ubuntu_core.log
```
**libsbml**  
SBML installation with language bindings for R and python.
```
./libsbml.sh 2>&1 | tee ./logs/libsbml.log
```
**libsedml**
SEDML installation with language bindings for R and python
```
./libsedml.sh 2>&1 | tee ./logs/libsedml.log
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

**tellurium**  
```
./tellurium.sh 2>&1 | tee ./logs/tellurium.log
```

**sbml2matlab**  
```
./sbml2matlab.sh 2>&1 | tee ./logs/sbml2matlab.log
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
