# Linux setup
[![Build Status](https://travis-ci.org/matthiaskoenig/linux-setup.svg?branch=master)](https://travis-ci.org/matthiaskoenig/linux-setup)
[![License (LGPL version 3)](https://img.shields.io/badge/license-LGPLv3.0-blue.svg?style=flat-square)](http://opensource.org/licenses/LGPL-3.0)

For the reproducibility of scientific analysis, for providing identical 
development and execution environments across multiple computers and 
for the setup of testing and execution environments within continuous 
integration (travis) it is necessary to provide setup scripts for 
the environment.

**linux-setup** are a collection of shell scripts for the setup of 
a linux environment for numerical simulations. The scripts have been
tested with Ubuntu LTS 16.04 and LTS 14.04. 

This repository provides the necessary setup scripts to create the 
core COMBINE libraries with their python bindings on linux systems.

To clone the repository use:
```
GIT_DIR=$HOME/git
mkdir $GIT_DIR
cd $GIT_DIR
git clone https://github.com/matthiaskoenig/linux-setup
cd linux-setup
```

## Overview
Overview over the available installation scripts in the `/scripts/` folder:

The `combine.sh` installation script functions as master installation script and
installs the following components:

* `ubuntu_base.sh` : Basic Ubuntu setup for the library installation
* `libsbml.sh` : SBML with language bindings for R and python
* `libsedml.sh` : SEDML with language bindings for R and python
* `roadrunner.sh` : libRoadrunner for numerical simulation with python bindings
* `antimony.sh` : Antimony with python bindings
* `phrasedml.sh` : phrasedml with python bindings    
* `tellurium.sh` : tellurium
* `sbml2matlab.sh` : sbml2matlab  
* `spyder.sh` : Spyder IDE installation

In addition a `ubuntu_core.sh` script is available which installs additional 
functionality used on ubuntu LTS 16.04 (14.04). This is not required for 
the libraries and the simulation environment and should not be called.

## Changelog
*v0.1.1* [?]
- updated documentation
- license added
- cleanup of folder structure

*v0.1* [2016-10-05]
- initial release
