#!/bin/bash
############################################################
# Clone the git projects
############################################################
GITDIR=$HOME/git
mkdir ${GITDIR}
cd ${GITDIR}

# Cytoscape
git clone https://github.com/matthiaskoenig/cy3sbml
git clone https://github.com/matthiaskoenig/cy3robundle
git clone https://github.com/matthiaskoenig/cy3javascript

git clone https://github.com/cytoscape/cytoscape-impl.git
cd cytoscape-impl
git checkout 3.4.0
cd ..

git clone https://github.com/cytoscape/cytoscape-api.git
cd cytoscape-api
git checkout 3.4.0
cd ..

git clone https://github.com/apache/incubator-taverna-language.git

# PLF
git clone https://github.com/matthiaskoenig/sbmlutils
git clone https://github.com/matthiaskoenig/multiscale-galactose

