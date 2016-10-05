# Linux setup
[![Build Status](https://travis-ci.org/matthiaskoenig/linux-setup.svg?branch=master)](https://travis-ci.org/matthiaskoenig/linux-setup)

For the reproducibility of scientific analysis, for providing identical development and execution environments across multiple computers and for the setup of testing and execution environments within continuous integration (travis) it is necessary to provide setup scripts for the envoronment.

This repository provides the necessary setup scripts to create the core COMBINE libraries with their python bindings on linux systems.

The installation script provides 
```
libsbml
libsedml
libcombine
libnuml
antimony
roadrunner
phrasedml
tellurium
sbml2matlab
```

For the installation use
```
GIT_DIR=$HOME/git
mkdir $GIT_DIR
cd $GIT_DIR
git clone https://github.com/matthiaskoenig/linux-setup
cd linux-setup
```

## Overview
Here an overview over the individual scripts is provided.

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
**libcellml**
Install the libraries

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
**phrasedml**  
```
./phrasedml.sh 2>&1 | tee ./logs/phrasedml.log
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

## Changelog
*v0.1*
- initial release
